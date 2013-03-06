(in-package :abra)

(defvar *bidirectional-bias* nil)

(defun get-unifiable-justifications (mblf agt)
  ;; a justification may have variable bindings that conflict with the
  ;; belief. if so, then we need to toss it out. also, justifications
  ;; may not match based on the modality of the predicate, so we need
  ;; to check for that.
  (filter #'(lambda (j) (bindable? mblf j))
	  (get-justifications agt)))

(defun get-unifiable-rules (mblf kb)
  ;; expand the modals of the rule to the top agent, using the modals
  ;; in mblf as a guide when needed. also, rules may not match based
  ;; on the modality of the predicate, so we need to check for that.
  (filter #'(lambda (j) (bindable? mblf j))
	  (mappend #'(lambda (r) (make-modal mblf r)) (get-inst-rules mblf kb))))

;;;;;
;; old-plan-abd
;; 
;; the first stage in the plan-generate-test approach.
;;
;; * plan - applies cheap constraints that don't require binding the
;;   rule to a belief. this could be something like "if there's
;;   already an explanation for the belief, use that. the heuristics
;;   here can be just as flexible as anywhere else. this gets and
;;   analyzes the belief, the current applicable justifications, and
;;   the applicable rules and prunes a bit.
;;
;; b:    the belief
;; wrld: the world from which we're viewing the belief. usually its home.
;; wm:   working memory
;; kb:   knowledge base
;;
;; options: 
;;   bc-only? - when true, will enforce inferences from the consequent
;;              only. if the consequent is a conjunction, only requires
;;              one member to fire the rule. we can later add a means
;;              to require multiple members.
;;
;;   focused? - when true, automatically prefers existing
;;              justifications over new ones. importantly, if a belief
;;              is already explained by a rule, then that
;;              justification will be selected, and no alternatives
;;              will be explored (unless randomization is used).
;;
;;   random? - when true, a single rule/justification will be selected
;;             uniformly at random. if focused? is true, then there is
;;             a fifty-percent chance that the result will be a new
;;             rule even when there is an existing justification.
(defun plan-abd (f wm kb 
		 &key (bc-only? nil) (focused? nil) (random? nil))
  (let ((joptions (get-unifiable-justifications (focus-modal f) (focus-view f)))
	(roptions (get-unifiable-rules (focus-modal f) kb)))

    ;; combine the two lists depending on how conservative we want the
    ;; system to be.
    (unless (and focused? joptions)
      (setq joptions (append roptions joptions)))

    ;; we could add any number of optional constraints to apply at
    ;; this point. each one would serve to reduce the work required
    ;; during the candidate generation phase.

    ;; drop rules unless the belief predicate appears in the
    ;; head. (back chain abduction only)
    (when bc-only?
      (setq joptions (delete-if-not #'(lambda (rl) (in-consequent? (predicate-name (focus-modal f)) rl))
				    joptions)))

    ;; inject a bit of randomness if you're brave.
    (mapcar #'(lambda (j) (make-candidate :original-justification j 
					  :original-belief (focus-belief f)
					  :world (focus-view f)))
	    (if random?
		(if (and focused? roptions (= (random 2) 0))
		    (list (nth (random (length roptions)) roptions))
		    (when joptions
		      (list (nth (random (length joptions)) joptions))))
		joptions))))

(defun plan-ded (f wm kb)
  ;; rules may not match based on the modality of the
  ;; predicate, so we need to check for that.
  ;;
  ;; drop rules unless the belief predicate appears in the
  ;; tail. (forward chaining only)
  (mapcar #'(lambda (jblob) (make-candidate :original-justification (first jblob) 
					    :original-belief (second jblob)
					    :world (third jblob)))
	  (mappend #'(lambda (rl) (full-groundings f rl wm))
		   (delete-if-not #'(lambda (rl) (in-antecedent? (predicate-name (focus-modal f)) rl))
				  (delete-if #'(lambda (rl) (not (bindable? (focus-modal f) rl))) 
					     (get-unifiable-rules (focus-modal f) kb))))))
  
;;;;;
;; generate-abduction
;; 
;; the second stage in the plan-generate-test approach.
;;
;;   * generate - carries out the bindings and can produce rules
;;     either by binding the individual belief to each candidate
;;     or by attempting to further specialize those candidates
;;     with the most specific beliefs.  (or possibly both)
;; 
;; takes a list of candidate rules/justifications as input and
;; specializes these to create a larger set of candidates.
(defun generate-abd (f wm kb cands)
  (declare (ignore kb)) ;; consider removing kb from signature
  ;; there are two options that we initially want to support 
  ;;
  ;;  * return the candidate justifications bound to the belief
  ;;  * return the candidates bound to the belief, and if more
  ;;    specific beliefs could appear in the rules, try binding to
  ;;    those as well.
  ;; 
  ;; for now, well just do the former because the latter option
  ;; considerably extends the search space.
  
  ;; in addition to each justification, if binding the belief to a
  ;; justification altered the belief's content (replaced skolems),
  ;; then we want to return the original belief so that the system
  ;; knows that it has been superceded (and should probably be
  ;; unbelieved, although that's not entirely necessary).
  (mappend #'(lambda (x) 
	       (mapcar #'(lambda (j) 
			   (make-candidate 
			    :original-belief (candidate-original-belief x)
			    :original-justification (candidate-original-justification x)
			    :la-score (candidate-la-score x)
			    :score (candidate-score x)
			    :world (third j)
			    :belief (second j)
			    :justification (first j)))
		       (bind-justification (candidate-original-justification x) (focus-belief f) (focus-view f) wm)))
	   cands))


;;;;;
;; filter-abduction
;;
;; This is a a new stage in the plan-generate-test approach where we
;; remove candidates after the generation stage. Unification could
;; have led to justifications that violate temporal constraints,
;; pruning heuristics, or other potential requirements.
(defun filter-abd (wm kb cands) cands
#|  (hook-filter-inconsistent-jcandidates 
   ;; filters inconsistent justifications when feature is turned on
   (when cands
    ;; Filter: Time Constraints
    (let ((fcands (if *temporal-filter* (temporal-filter cands) cands)))
      ;; Filter: Directionality Preferences
      (when *divide-lookahead?* 
	;; all candidates will have the same original belief...
	(let* ((c (first cands))
	       (cob (candidate-original-belief c))
	       (cow (candidate-world c))
	       (mlit (expand-modals cob cow (belief-home cob wm)))
	       (cb (consequent-belief? cob cow 
				       :no-dialog? 
				       (dialog-hack cob)))
	       (ab (antecedent-belief? cob cow 
				       :no-dialog? 
				       (dialog-hack cob))))
	  (setf fcands 
		(cond ((or (and (not cb) (not ab)) (and cb ab))
		       cands)
		      ((and (not cb) ab 
			    (> (count-matching-rules mlit cob cow kb :key #'consequent-literals) 0))
		       ;; keep only the candidates with belief in consequent
		       (loop for x in cands
			     when (in-consequent? (expand-modals (candidate-belief x) (candidate-world x) (belief-home x wm)) 
						  (candidate-justification x))
			       collect x))
		      ((and (not ab) cb
			    (> (count-matching-rules mlit cob cow kb :key #'antecedent-literals) 0))
		       ;; keep only the candidates with belief in antecedent
		       (loop for x in cands
			     when (in-antecedent? (expand-modals (candidate-belief x) (candidate-world x) (belief-home x wm)) 
						  (candidate-justification x))
			       collect x))))))

      ;; Filter: Internal Contradictions
      ;; get rid of justifications that contain X and (not X). we'll
      ;; need to make contradictory-justification time aware when we
      ;; reason about actions.
      (delete-if  #'contradictory-justification fcands :key #'candidate-justification))))
|#
)

(defvar *filter-inconsistent-justifications* nil)
   ; default of hook is turned off

(defun hook-filter-inconsistent-jcandidates (candidates)
  "hook to filter out justifications that don't satisfy consistency constraints"
  (if *filter-inconsistent-justifications*
      (filter-inconsistent-jcandidates candidates) 
      candidates))


;;;;;
;; test-abduction
;;
;; the third stage in the plan-generate-test approach.
;;
;;   * test - evalutes each candidate
(defun test-abd (f wm cands)
  (dolist (c cands cands)
    (setf (candidate-score c) 
	  (score-justification (candidate-justification c) (focus-view f) wm :cost 1))))

(defun display-justifications (wrld wm)
  (dolist (j 
	    (sort (mapcar #'(lambda (j) (cons (score-justification j wrld wm) j)) 
			  (get-justifications wrld))
		  #'< :key #'car))
    (format t "~A: ~A~%" (car j) (cdr j))))

(defun display-beliefs (wrld)
    (dolist (b (sort (mapcar #'(lambda (wb)
				 (cons (length (get-support (second wb) wrld)) (second wb)))
			     (get-local-beliefs wrld))
		     #'< :key #'car))
      (format t "~A: ~A~%" (car b) (cdr b))))

;; the justification gains points for using beliefs that are supported
;; by other existing justifications. when cost is greater than zero,
;; justifications are penalized by the number of new assumptions they
;; make (cost is uniformly applied to all assumptions).
#|
(defun score-justification (j wrld wm &key (cost 0))
  (let ((score 0) b (nass 0) old-skolems new-skolems nsk)
    (dolist (lit (literals j))
      (setf b (find-belief lit wrld wm))
      (if b
	  (progn 
	    (incf score (score-belief (second b) (first b) wrld))
	    (append (remove-if-not #'skolem? lit) old-skolems))
	  (progn 
	    (incf nass)
	    (append (remove-if-not #'skolem? lit) new-skolems))))
    ;; number of skolems introduced by the justification
    (setf nsk (length (set-difference new-skolems old-skolems)))
    ;; for now, subtract the number of assumptions weighted by some cost measure.
    (- score (* nass cost))))
    ;; (- score (* nsk cost))))
|#

(defun score-justification (j jwrld wm &key (cost 0) (ignore nil))
  (declare (ignore cost))
  (let ((score 0) b)
    (dolist (lit (literals j) 
	     (/ score (length (literals j))))
      (setf b (find-belief lit jwrld))
      (when (and b (not (find (belief-content (second b)) ignore :test #'equal))) 
	(incf score  
	      ;;; 11/29/11 we need to encourage the use of grounded
	      ;;; beliefs. this may be too much, but we need to debug
	      ;;; other things besides this. fully skolemized beliefs
	      ;;; don't count for anything.
	      (let ((args (literal-args (belief-content (second b)))))
		(* (/ (count-if-not #'skolem? args) (length args))
		   (score-belief (second b) (first b) jwrld))))))))


(defun score-belief (b bwrld jwrld)
  (if (eql bwrld jwrld)
      ;; belief and justification are in the same world, so return the local score
      ;; XXX: this line doesn't lead to the intended results.
      ;; (if (find-if #'skolem? (belief-content b)) 1 (length (get-support b bwrld)))
      (+ (if (fact? b bwrld) 1 0) (length (get-support b bwrld)))
      ;; justification is in a different world, so report the normal
      ;; score for the belief in its own world plus any extra support
      ;; it has in jwrld
      (+ 
       (if (fact? b bwrld) 1 0) ; a point for being an observation
       (length (get-support b bwrld)) ; points for local support in bwrld
       ;; points for other connections to jworld
       (count-if #'(lambda (x) (eql (first x) jwrld)) (belief-weak-links b))))) 

;;; XXX: Working Here 
;;; 
(defun score-belief-testing (b bwrld jwrld)
  (if (eql bwrld jwrld)
      ;; belief and justification are in the same world, so return the local score
      (* (count-if-not #'skolem? (literal-args (belief-content b))) (length (get-support b bwrld)))
      ;; justification is in a different world, so report the normal
      ;; score for the belief in its own world plus any extra support
      ;; it has in jwrld
      (+ 
       (if (member bwrld (world-obs-worlds jwrld) :key #'second) 1 0) ; a point for being an observation
       (length (get-support b bwrld)) ; points for local support in bwrld
       ;; points for other connections to jworld
       (count-if #'(lambda (x) (eql (first x) jwrld)) (belief-weak-links b))))) 

;;;;;
;; select-abduction
;;
;; input: cands - a list of scored candidates
;;        selector - a function to select among the candidates
;;        probability - a probability
;;
;; output: a candidate explanation
;; 
;; the explanation is chosen based on the selector function. if
;; probability is greater than zero, then there is a chance
;; (corresponding to the probability) that a random candidate will be
;; selected instead.
(defun select-abd (wm kb cands 
		   &key (lookahead? nil) (selector #'high-score-elt) (probability -1.0))
  (when lookahead?  (lookahead wm kb cands))
  (if (and (> probability 0.0) (< (random 1.0) probability))
      (random-elt cands)
      (funcall selector cands)))

;;;;;
;; random-elt
;;
;; input: a list
;; output: a random element from that list
(defun random-elt (lst)
  (when lst (nth (random (length lst)) lst)))

;;;;;
;; trim-candidates
;;
;; input: a list of candidates sorted by their scores.
;;        the threshold for keeping a candidate.
;; output: a list of candidates whose scores are higher than
;;         the threshold.
(defun trim-candidates (lst scr scrf)
  (cond ((null lst) nil)
	((< (funcall scrf (car lst)) scr) nil)
	(t (cons (car lst) (trim-candidates (cdr lst) scr scrf)))))

;;;;;
;; high-score-elt (selector)
;; 
;; input: a list of candidates
;; output: the candidate with the highest score. picks randomly
;;         from the list of candidates with the highest score.
(defun high-score-elt (lst)
  (when lst
    (let (slst)
      (setf slst (sort (copy-list lst) #'> :key #'candidate-score))
      (setf slst (trim-candidates slst (candidate-score (car slst)) #'candidate-score))
      ;; resort to lookahead score when there's a tie.
      (when (second slst) 
	(setf slst (sort (copy-list slst) #'> :key #'candidate-la-score))
	(setf slst (trim-candidates slst (candidate-la-score (car slst)) #'candidate-la-score)))
      ;; if all else fails, go random.
      (random-elt slst))))

(defun candidate-split-by-chaining (cands)
  (let (tail head)
    (dolist (c cands (list tail head))
      ;; who knows? the literal might match in both locations.
      (when  (member (belief-content (candidate-belief c))
		     (consequent-literals (candidate-justification c))
		     :test #'literal-equal?)
	(push c head))
      (when  (member (belief-content (candidate-belief c))
		     (antecedent-literals (candidate-justification c))
		     :test #'literal-equal?)
	(push c tail)))))

;;;;;;
;; fresh-candidate
;;
;; c - a candidate structure
;; original? - if true, then evaluate the original-justification 
;;             as opposed to justification
;;
;; returns true if j is flagged as a new justification (i.e., not
;; already in the system).
(defun fresh-candidate? (c &key original?)
  (if original?
      (eq 'JNEW (justification-id (candidate-original-justification c)))
      (eq 'JNEW (justification-id (candidate-justification c)))))


(defun all-new-justifications? (clst &key original?)
  (not (find-if-not #'(lambda (c) (fresh-candidate? c :original? original?)) clst)))

;;;;;
;; high-score-connect (selector)
;; 
;; input: a list of candidates
;; output: the candidate with the highest score.
;;
;; XXX: close, but no cigar.
(defun high-score-connect (lst)
  (when lst
    (let* ((slst (candidate-split-by-chaining lst))
	   (hlst (sort (copy-list (second slst)) #'> :key #'candidate-score))
	   (tlst (sort (copy-list (first slst)) #'> :key #'candidate-score)))
      (when tlst
	(setf tlst (trim-candidates tlst (candidate-score (car tlst)) #'candidate-score)))
      (when hlst 
	(setf hlst (trim-candidates hlst (candidate-score (car hlst)) #'candidate-score)))
      
     
      (setf slst '())
      (when (all-new-justifications? tlst)
	(setf slst (append tlst slst)))
      (when (all-new-justifications? hlst)
	(setf slst (append hlst slst)))
      (unless slst
	(setf slst (append hlst tlst)))

      ;; resort to lookahead score when there's a tie.
      (when (second slst) 
	(setf slst (sort (copy-list slst) #'> :key #'candidate-la-score))
	(setf slst (trim-candidates slst (candidate-la-score (car slst)) #'candidate-la-score)))
      ;; if all else fails, go random.
      (random-elt slst))))

;;;;; 
;; high-score-new (selector)
;;
;; input: a list of candidates
;; output: the candidate with the highest score that (a) is not already 
;;         explaining the belief and (b) does not generalize an existing
;;         explanation of the belief.
(defun high-score-new (lst)
  (when lst
    (let ((slst (sort (copy-list lst) #'> :key #'candidate-score)))
      (loop for c in slst 
	 when (or (fresh-candidate? c)
		  (find-if-not #'literal-grounded? (literals (candidate-justification c))))
	 return c))))


;;;;;
;; split-by-chaining
;;
;; lit - a literal
;; cands - a list of lookahead-leafs
;;
;; returns a list where the first element is a list of all cands where lit 
;; appears in the tail and the second element contains the ones where lit
;; appears in the head.
(defun split-by-chaining (lit cands)
  (let (tail head)
    (dolist (c cands (list tail head))
      ;; who knows? the literal might match in both locations.
      (when  (member lit (consequent-literals (candidate-justification c))
		     :test #'modal-bindable?)
;		     :test #'literal-equal?)
	(push c head))
      (when  (member lit (antecedent-literals (candidate-justification c))
		     :test #'modal-bindable?)
;		     :test #'literal-equal?)
	(push c tail)))))

;; this function prunes a set of candidates based on whether the focus
;; is used in both the antecedent and the consequent of some
;; justification.  if the focus appears in the antecedent of some
;; existing justification but not in the consequent of one, then it
;; will only keep the candidates where the focus appears in the
;; consequent and vice versa.
;;
;; if the candidate has already been used in justifications as
;; antecedent and consequent or never been used, then the full set of
;; candidates is returned.
(defun pick-sides (f on? cands)
  (if on?
      ;; if one side is all JNEW, drop the other side.
      (destructuring-bind (side1 side2) (split-by-chaining (focus-modal f) cands)
	;; handle degenerate cases
	(cond ((null side1) side2)
	      ((null side2) side1)
	      (t
	       (if (not (all-new-justifications? side1 :original? t))
		   (if (not (all-new-justifications? side2 :original? t))
		       (append side1 side2) ;; existing justifications on each side
		       side2)
		   (if (all-new-justifications? side2 :original? t)
		       (append side1 side2) ;; all new justifications on each side
		       side1)))))
      cands))


;;;;;
;; print-candidate
;;
;; print a candidate in a way that's suitable for debugging.
(defun print-candidate (c str d)
  (declare (ignore d))
  (format str "~%Candidate ::~%~TScore ~A~%~TLookahead ~A~%~TW: ~A~%~TB: ~A to ~%~T~T~T~A~%~TJ: ~A to ~%~T~T~T~A"
	  (candidate-score c) 
	  (candidate-la-score c)
	  (candidate-world c)
	  (candidate-original-belief c)
	  (candidate-belief c)
	  (candidate-original-justification c)
	  (candidate-justification c)))

;;;;;
;; candidate
;;
;; a structure that contains all the relevant information for
;; candidate explanations of a belief.
(defstruct (candidate (:print-function print-candidate)
		      (:predicate candidate?))
  original-belief        ;; belief before unification
  original-justification ;; justification before unification
  world                  ;; the home world of belief if it exists
                         ;; or the world that should eventually contain a new belief
                         ;; not necessarily the intended home of the justification
  belief
  justification
  (la-score 0) ;; score based on a lookahead heuristic
  (score 0))

(defun candidate-constraints (candidate)
  (justification-constraints
    (candidate-justification candidate)))
