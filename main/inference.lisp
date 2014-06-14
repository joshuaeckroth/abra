(in-package :abra)

;;;;; inference.lisp
;;;
;;; Inference 
;;;
;;; 1.	New literals arrive.
;;; 2.	Pick a literal based on recency and value of information.
;;; 3.	Find all rules that, once grounded, could contain that literal.
;;; 4.	Rank the rules by coherence.
;;; 5.	Fire the most coherent rule; assume new literals as needed.
;;; 6.	Repeat until time runs out.
;;;
;;; Assumptions about rules/justifications:
;;;
;;; * written as IF-THEN rules.
;;; * the antecedent and consequent are conjunctions of arbitrary length.
;;; * individual predicates may be negated on either side of the implication.
;;;
;;; Assumptions about beliefs:
;;;
;;; * associated with a unique identifier
;;; * may be positive or negative literals

(defvar *split-skolem-hook* nil)
(defvar *use-kb-constraints* nil)

(defun add-facts (lst agt wm)
  ;; find the source world that will house these beliefs
  ;; add the facts to that world
  (mapcar #'(lambda (x) 
	      (let (wb (lt (skolemize x)))
		(introduce-agents x agt wm)
		(cond ((setf wb (find-belief lt agt))
		       (setf (belief-source (second wb)) 'fact) ;; lazy. we should call it an actual source.
		       (second wb)) 
		      ((setf wb (find-belief lt agt :flip-negation? t :inherit? nil))
		       nil) ;; lazy. replace with conflict resolution later.
		      (t
		       (believe lt agt wm 'fact)))))
	  lst))

(defvar *vocal* nil)

;;;;;
;; infer
;;
;; runs a single inference step, selecting a belief according to :pick-belief.
(defun infer (wm kb &key (w (wm-prime wm)) (bc-only? nil) (focused? nil) (p -1.0)
	                 (pick-belief #'pick-belief-random) (deduction? nil))
  ;; get a world--belief tuple to explain
  (let ((focus (funcall pick-belief wm kb :agent w))
	new-beliefs)
    (when *vocal* (format t "~%focus: ~A~%" (focus-belief focus)))
    ;; explain b in the context of w
    (if deduction?
	(deduce-from-b focus wm kb)
	(setf new-beliefs (explain-b focus wm kb bc-only? focused? p)))
    (revise-beliefs new-beliefs wm)))

;;;;;
;; explain-b
;;
;; runs a single inference step, given a belief. returns a list of
;; world-belief pairs for all beliefs created during this cycle.
(defun explain-b (f wm kb &optional (bc-only? nil) (focused? nil) (p -1.0))
  ;; select a candidate justification
  (let (new-beliefs
	(c (select-abd wm kb
	    (test-abd f wm 
		      (filter-abd wm kb 
				  (pick-sides f *bidirectional-bias*
					      (generate-abd f wm kb
							    (plan-abd f wm kb 
								      :bc-only? bc-only? 
								      :focused? focused?
								      :random? nil)))))
	    :probability p)))
    ;; add new knowledge and carry out truth maintenance.
    (when c
      (when *split-skolem-hook* (setf c (split-skolem c)))
      (setf new-beliefs (apply-explanation c (focus-view f) wm))
      ;; (when (and *vocal-0* new-beliefs) (format t "created beliefs: ~A~%" new-beliefs))
      (when *vocal* (format t "~%applying: ~A~%created beliefs: ~A~%" c new-beliefs)))
    new-beliefs))

;; like explain-b but returns the candidate explanation without applying it.
(defun test-explain-b (f wm kb &optional (bc-only? nil) (focused? nil) (p -1.0))
  (let ((c (select-abd wm kb 
	    (test-abd f wm 
		      (filter-abd wm kb
				  (pick-sides f *bidirectional-bias*
					      (generate-abd f wm kb
							    (plan-abd f wm kb 
								      :bc-only? bc-only? 
								      :focused? focused?
								      :random? nil)))))
	    :probability p)))
    c))

(defun deduce-from-b (f wm kb)
  ;; select a candidate justification
  (let ((c (select-abd wm kb
	    (test-abd f wm 
		      (filter-abd wm kb
		       (generate-abd f wm kb
				     (plan-ded f wm kb))))
	    :probability -1.0)))
    ;; add new knowledge and carry out truth maintenance.
    (when c
      (apply-explanation c (focus-view f) wm))))

;;;;;
;; modal-bindable?
;;
;; takes two literals and returns nil if the first literal cannot bind
;; to the second. expects modals to be expanded.
(defun modal-bindable? (lit1 lit2)
  ;; XXX: assumes that modals will not be negated.
  (and
   (eql (predicate-name lit1) (predicate-name lit2))
   (match-modals? lit1 lit2)
   (eql (negated? (strip-modals lit1)) 
	(negated? (strip-modals lit2))) 
   (not (binding-conflict? (literal-args lit1) 
			   (literal-args lit2)))))


;;;;;
;; lit-bindable?
;;
;; takes a modal literal and a rule or the contents of a justification
;; returns nil if the belief cannot bind to the rule
(defun lit-bindable? (mlit rl)
  (find-if #'(lambda (p)
	       (if (not (modal-lit? p))
		   ;; if a rule contains a literal without a modal, that's shorthand for 
		   ;; a belief modal of the current agent. 
		   (modal-bindable? mlit (append (list +belief+ (modal-agent mlit)) (list p)))
		   (modal-bindable? mlit p)))
	   (find-predicate-in-rule mlit rl)))

;;;;;
;; bindable?
;;
;; takes a modal literal and a rule or the contents of a justification
;; returns nil if the belief cannot bind to the rule. expands modals.
(defun bindable? (mb rl)
  (lit-bindable? mb rl))


;;;;;
;; binding-conflict?
;;
;; returns true if the constants in new-args cannot override
;; the constants in old-args.
(defun binding-conflict? (new-args old-args)
  (mismatch new-args old-args :test #'bindable-args?))


;;;;;
;; bindable-args?
;;
;; true when one argument can be bound to another
(defun bindable-args? (arg1 arg2)
  (or (eq arg1 arg2)
      (skolem? arg1)
      (skolem? arg2)))

;;;;;
;; in-consequent?
;;
;; returns true if the predicate appears in the consequent of the rule
(defun in-consequent? (predicate rule)
  (find predicate (consequent-literals rule) :test #'eql :key #'predicate-name))

;;;;;
;; in-antecedent?
;;
;; returns true if the predicate in modal literal mb appears in the 
;; antecedent of rule rl
(defun in-antecedent? (predicate rule)
  (find predicate (antecedent-literals rule) :test #'eql :key #'predicate-name))


;;;;;
;; apply-binding
;;
;; replace skolems in the belief with corresponding domain constants
;; in the literal.
;;
;; returns a literal that merges the arguments in the contents of b
;; and lit. modal operators in lit are preserved.
;; 
;; future: will need to take a world argument to handle modals that 
;; have arguments other than the literal they modify.
(defun apply-binding (b lit)
  (labels ((replace-args (b lit) 
	     (cons (predicate-name (belief-content b))
		   (mapcar #'(lambda (x y) 
			       (if (and (not (skolem? x))
					(skolem? y))
				   x 
				   y))
			   (literal-args lit)
			   (literal-args (belief-content b))))))
    (add-modals-and-agents (list-modals lit) (list-agents lit)
		    (if (negated? (belief-content b)) 
			(negate (replace-args b lit))
			(replace-args b lit)))))

;;;;;
;; make-substitution-map
;;
;; creates a map between skolems in lit1 and domain constants in lit2
(defun make-substitution-map (lit1 lit2)
  (loop with ht = (make-hash-table) 
	;; note that we have to map agents as well as literal arguments
        for arg1 in (append (list-agents lit1) (literal-args lit1))
        and arg2 in (append (list-agents lit2) (literal-args lit2))
     unless (or (equivalent-args? arg1 arg2)
		(gethash arg1 ht)
		(not (skolem? arg1)))
     do (setf (gethash arg1 ht) arg2)
     finally (return ht)))

;;;;;
;; find-bindings
;; 
;; takes a (modal) literal and a justification
;;
;; returns the literals in the justification that can unify with the
;; given literal.
(defun find-bindings (mlit j)
  ;; only consider literals that have the same modal operators,
  ;; the same predicate, and the same negation status.
  (delete-if-not #'(lambda (x) 
		     (modal-bindable? mlit x))
		 (find-predicate-in-rule mlit j)))

(defun find-bindings-in-list (mlit litlst)
  ;; only consider literals that have the same modal operators,
  ;; the same predicate, and the same negation status.
  (delete-if-not #'(lambda (x) 
		     (and (match-modals? x mlit)
			  ;; XXX: assumes that modals will not be negated.
			  (eq (negated? (strip-modals x)) (negated? (strip-modals mlit)))
			  (not (binding-conflict? (literal-args mlit) (literal-args x)))))
		 (find-predicate mlit litlst)))


;;;;;
;; pick-binding
;; 
;; takes a justification, a modal literal, the world where the justification
;; lives, and an optional selection function.
;;
;; returns the literal in the justification that best fits the belief
;; according to the selection function.
(defun pick-binding (j mlit jw &optional (selector #'most-specific-binding))
  ;; * get all possible matchings of this belief to the rule and then
  ;; * find the most specific binding
  ;; * get rid of candidates whose negation status doesn't match the belief
  ;; * return the best candidate literal to assign to the belief
  (funcall selector 
	   mlit
	   (find-bindings mlit j)))

;;;;;
;; update-justification
;;
;; takes a justification, a belief, a literal that the belief should match,
;; and a world that encloses the reasoning.
;;
;; returns the justification that would ultimately match the belief
;; along with the literal that matches the belief. note that the
;; skolems in the literal may have different names from the ones in
;; the justification. if the justification is new, then its ID is JNEW.

(defun old-update-justification (j b mblf lit wrld)
  (let (tmpj)
    (if (find-if-not #'skolem? (literal-args (belief-content b)))
	;; if we can replace skolems in the justification with domain
	;; constants from the belief, do it, otherwise poke around for
	;; an existing version of the justification and return that (or
	;; the original input).
	(if (mismatch (literal-args lit) 
		      (literal-args (belief-content b)) :test #'equivalent-args?)
	    (multiple-value-bind (new-j lit) (bind-to-support mblf j lit 'JNEW)
	      (setf tmpj (find-justification new-j wrld))
	      (if tmpj
		  (values tmpj lit)
		  ;; until they're official, new justifications get a flag ID
		  (values new-j lit)))
	    ;; no replaceable skolems.
	    (if (setf tmpj (find-justification j wrld))
		(values tmpj lit)
		(values j lit)))
	;; case: all belief constants are skolems.
	(cond ((get-justification (justification-id j) wrld)
	       ;; if the justification already exists, then just use it.
	       (values j lit))
	      ((setf tmpj (find-subsumed-justification j wrld))
	       ;; if the justification doesn't already exist, look for
	       ;; one that it subsumes and use that one.  make sure to
	       ;; update the literal for the new justification.
	       (values tmpj (pick-binding tmpj mblf wrld)))
	      (t
	       ;; justification doesn't exist and there's nothing that
	       ;; it subsumes, so just use what you have.
	       (values j lit)))))) 

(defun update-justification (j b mblf lit wrld)
  (cond ((not (find-if-not #'skolem? (literal-args (belief-content b))))
	 ;; all skolems, so return what you have
	 (values j lit))
	((mismatch (literal-args lit) (literal-args (belief-content b)) :test #'equivalent-args?)
	 ;; if we can replace skolems in the justification with domain
	 ;; constants from the belief, do it.
	 (bind-to-support mblf j lit 'JNEW)) ; until they're official, new justifications get a flag ID
	(t
	 ;; no replaceable skolems.
	 (values j lit))))


;; binds the skolems in b to domain constants in lit. if this creates
;; a new belief, then it's added to the world.
;;
;; returns a tuple containing either
;; (a) the world that contains b and b (no change)
;; (b) the world that should contain the new belief and the new belief with ID 'BNEW
(defun update-belief (b lit wrld wm)
  ;; either b and lit will only contain skolems, or they will have
  ;; equivalent arguments, or we'll need to update b. in the first
  ;; two cases, we just need to add new-rule as support for b. in
  ;; the third case, we need to make some changes beforehand.
  (if (mismatch (literal-args lit) (literal-args (belief-content b)) :test #'equivalent-args?)
      ;; is the new belief already in the world? if so, use
      ;; the existing belief, otherwise return the new belief.
      (let* ((nlit (apply-binding b lit))
	     (tmp-b (find-belief nlit wrld)))
	(if tmp-b
	    tmp-b ;; existing belief
	    ;; ASSUME: for purposes of a first pass, we assume that we
	    ;; can resolve the belief to a single world. this means
	    ;; that all the agents must be specified. we can't handle
	    ;; cases like, "Does AGT-P believe that somebody has a
	    ;; goal to X?" instead, everything must be framed as "Does
	    ;; AGT-P believe that AGT-T has a goal to X?"
	    (list (first (base-worlds (resolve-world nlit wrld)))
		  (make-belief :id 'BNEW 
			       :content (strip-modals nlit)))))
      ;; no change required
      (list (belief-home b wm) b)))

;;;;; EXTENDED NOTE ;;;;;
;;
;; abduction, in the sense of creating new beliefs, happens in two
;; ways given a rule and a belief. first, as the belief is matched to
;; the justification some of its skolems may be replaced by domain
;; constants. the new belief supersedes the original one under the
;; assumption that the skolems match constants from the justification.
;; this increases coherence.  second, as the justification is matched
;; to the belief, the justification may be completely new or skolems
;; that occur in multiple literals of an existing justification may be
;; replaced by domain constants from the belief. if these new literals
;; don't exist in working memory, they're assumed, which brings more
;; beliefs into the system without perception.

;;;;;
;; bind-justification
;;
;; given a justification, a belief, and a world, bind the belief to
;; the justification. since skolems may be replaced by domain
;; constants, this could generate a new belief and a new justification
;; or transform the input into existing structures.
;;
;; returns a list of raw candidate justifications. the list contains
;; triples that consist of
;; (1) the justification after being bound to the belief
;; (2) the belief after being bound to the justification
;; (3) the world where the belief should reside
(defun old-bind-justification (j b wrld wm)
  (let (cands lit new-j new-wb (mblf (expand-modals b wrld (belief-home b wm))))
    (dolist (binding (find-bindings mblf j) cands)
      (multiple-value-setq (new-j lit) (update-justification j b mblf binding wrld))
      ;; now, new-j either contains a completely new justification or an
      ;; existing one. (in the latter case, the belief will also be
      ;; redundant, and already supported by the existing justification.)
      (setf new-wb (update-belief b lit wrld wm))
      (if (remove-if-not #'skolem? (mappend #'list-agents (literals new-j)))
	  (dolist (tj (ground-skolem-agents new-j wrld wm)) ;; ground agent skolems
	    (push (list tj (second new-wb) (first new-wb)) cands))
	  (push (list new-j (second new-wb) (first new-wb)) cands))))) ;; or not

(defun bind-justification (j b wrld wm)
  (let (cands lit new-j (mblf (expand-modals b wrld (belief-home b wm))))
    (dolist (binding (find-bindings mblf j) cands)
      (multiple-value-setq (new-j lit) (update-justification j b mblf binding wrld))
      ;; HACK: this conditional is part of the test of utility for
      ;;       inequality constraints in a rule. the test will be in
      ;;       the Monroe domain where it's safe to assume that all
      ;;       variables bind to different constants.
      (when (no-variables-re-bound j new-j)
      ;; now see if the justification already exists.
      ;; if it is all skolems, check to see what it subsumes
      (setf cands 
	    (append (mapcar #'(lambda (c)
				(let (fj)
				  (if (find-if-not #'skolem? (literal-args (belief-content b)))
				      (progn 
					(setf fj (find-justification c wrld))
					(unless fj
					  (setf fj c)))
				      (progn ;; all skolems, so look for a more specific justification
					(setf fj (find-subsumed-justification c wrld))
					(if fj 
					    (setf lit (pick-binding fj mblf wrld))
					    (setf fj c))))
				  ;; update the belief after the justification is finalized.
				  (cons fj (reverse (update-belief b lit wrld wm)))))
			    (ground-skolem-agents new-j wrld wm))
		    cands))))))

;; HACK to quickly test a particular constraint ;;
;;
;; Modified code from Ben Meadows that lets AbRA act as if each
;; variable in a rule had inequality constraints with all other
;; variables in the rule. Using it here to see how it'll alter the
;; evaluation of the Monroe domain. These types of constraints were
;; used in Tolga's code and should lead to general improvements in
;; accuracy.
(defvar *monroe-inequality* nil)
(defun no-variables-re-bound (j new-j)
  ;; jump out unless we're testing
  (unless *monroe-inequality* (return-from no-variables-re-bound t))
  (let (arguments old-pairs new-pairs)
    (setf arguments (mapcan #'literal-args (literals (clone-justification j))))
    (setf old-pairs (mapcar #'(lambda (x) (cons x 0)) arguments))
    (dolist (x arguments)
      (when (not (skolem? x))
	(incf (cdr (assoc x old-pairs)))))
    
    ;; same as above, but for new-j/new-pairs
    (setf arguments (mapcan #'literal-args (literals (clone-justification new-j))))
    (setf new-pairs (mapcar #'(lambda (x) (cons x 0)) arguments))
    (dolist (x arguments)
      (when (not (skolem? x))
	(incf (cdr (assoc x new-pairs)))))

    ;; compare new-pairs and old-pairs
    ;;
    ;; 1. If (= x 0) for j, continue without even looking at
    ;; new-j. it's ok to replace a skolem with a constant for the
    ;; first time,
    ;; (WB 12/10/12: not sure what this assumption means)
            ; ASSUMING that it only does so for occurrences of one
            ; specific skolem in each step.
    ;;; 2. If x -> y for j -> new-j, immediately return false.
    ;;; 3. Finally, otherwise return true.
    (dolist (j-pair old-pairs t)
      (when (/= (cdr j-pair) 0)
	;; get the equivalent from new-j.
	(when (/= (cdr j-pair) (cdr (assoc (car j-pair) new-pairs)))
	  ;; change is bad.
	  (return-from no-variables-re-bound nil))))))

;; takes a candidate justification. creates a list of all
;; justifications produced when skolemized agents are grounded.
;; exponential in the number of agents and skolems.
(defun ground-skolem-agents (j wrld wm)
  (let ((vars ;; list of agent skolems
	  (remove-if-not #'skolem? (remove-duplicates (mappend #'list-agents (literals j))))))
    (if vars
	;; for each row in the table, make a skolem--agent map and call clone-justification
	(loop with table = (combinatorial-assignment vars (mapcar #'agent-name (hash-table-values (wm-agents wm))))
	      for x upfrom 0 below (array-dimension table 0)
	      collect (clone-justification j (make-sub-map vars table x) 'JNEW))
	;; nothing to do, be useful.
	(list j))))

;; given a matrix of variable assignments to vars and a row index,
;; return a hash-table that maps vars to the values in the given row.
(defun make-sub-map (vars table row)
  (loop with ht = (make-hash-table)
	for col upfrom 0 below (array-dimension table 1)
	do (setf (gethash (nth col vars) ht) (aref table row col))
	finally (return ht)))
		 
;; add the belief to its intended home world if it's new
;; returns a list containing the relevant world and the belief
;; or nil if nothing was added.
(defun add-new-belief (c wm)
  (when (eq (belief-id (candidate-belief c)) 'BNEW)
    (believe (belief-content (candidate-belief c)) (candidate-world c) wm)))


;; add the justification to the focal world if it's new
(defun add-new-justification (c wrld wm)
  (let (new-beliefs)
    (when (fresh-candidate? c)
      (setf (values (candidate-justification c) new-beliefs)
	    (fire-justification (copy-justification (candidate-justification c)) wrld wm)))
    new-beliefs))

;;;;;;
;; remove-justification-if-allowed
;;
;; input:
;; b - belief that is suspected of being specialized
;; j - justification that supported that belief
;; wrld - world that the system is focusing on (perspective)
;; wm - working memory
;; 
;; if b or j are owned by wrld, then j is removed from working memory.
;; returns the beliefs that are no longer supported by j if it was removed.
(defun remove-justification-if-allowed (b j wrld wm)
  ;; (a) if b is in wrld.
  ;;        drop jid.
  ;;        drop any beliefs that relied only on jid.
  ;;
  ;; [ more specific b in this world overshadows the more general 
  ;;   one in the imported world ]
  ;; (b) if b is in some imported world.
  ;;        if jid is in wrld.
  ;;           drop jid.
  ;;           drop any beliefs that relied only on jid.
  ;;; i can only remove the justification if my wrld owns the belief or the justification
  ;;; that's what makes this bit of code a little convoluted.
  (if (get-local-belief (belief-id b) wrld)
      (remove-justification j (justification-home j wm))
      (when (get-justification (justification-id j) wrld)
	(remove-justification j wrld))))

;; if a new justification was created, returns the justification and any new beliefs.
(defun move-isolated-justification (new-j jhome c wrld wm)
  ;; if j is duplicated in the list or was already removed and
  ;; this belief hadn't heard about it, we have an error.
  (assert jhome)
  ;; update any justifications in any world that rely on the original belief.
  (let (exists-j added-j new-beliefs)
    ;; look for duplicate justifications (only) in the world that houses jid.
    (setf exists-j (get-justification (find-justification-id new-j jhome) jhome))
    ;; register either the old rule or the new one as support for the new belief.
    (if exists-j
	;; since exists-j is a different justification, we need to recheck this condition.
	;; see one-to-one-belief-update
	(unless (member (candidate-belief c) (get-supported-beliefs exists-j wrld) :key #'second)
	    (register-support exists-j wrld (candidate-belief c) (candidate-world c)))
	(setf (values added-j new-beliefs) (fire-justification new-j wrld wm)))
    (values added-j new-beliefs)))

;; if a new justification was created, returns the justification and any new beliefs.
(defun move-shared-belief-justification (j c wrld wm)
  ;; grab all potential bindings in this justification
  ;; bind justification should grab existing justifications if possible
  (let ((opts (bind-justification j (candidate-belief c) wrld wm))
	(score -1) 
	best tmp added-j new-beliefs)
    ;; find the highest scoring binding
    (dolist (opt opts)
      (setf tmp (score-justification (first opt) wrld wm))
      (when (> tmp score)
	(setf best (first opt) score tmp)))
    ;; process the best one.
    ;; if it already exists, then there's nothing to do. (i think.)
    (unless (or (null best) (find-justification-id best (justification-home j wm)))
      (setf (values added-j new-beliefs) (fire-justification (clone-justification best) wrld wm)))
    (values added-j new-beliefs)))

;;;;;;
;; one-to-many-belief-update
;;
;; sometimes a single belief appears multiple times in a
;; justification. this can happen when a skolem eventually resolves to
;; two or more separate domain constants. we need to treat this
;; scenario differently by creating a new justification, moving one of
;; its support links to the new belief, and creating links to the old
;; (more general) belief. the original justification disappears, and
;; we don't move any of the other justifications for the original
;; belief to the new one (leaving them maximally general).  this is a
;; cautious strategy because we don't assume that the specialization
;; of the belief should percolate to the other justifications that it
;; originally supported.
;;
;; returns a list of beliefs created during the process
(defun one-to-many-belief-update (c wrld wm)
  (let ((ht1 (make-hash-table))
	(ht2 (make-hash-table))
	(sub-map (make-substitution-map 
		  (belief-content (candidate-original-belief c)) 
		  (belief-content (candidate-belief c))))
	added-j new-beliefs belief-list)
    ;; isolate the duplicated justifications
    (dolist (j (get-support (candidate-original-belief c) wrld))
      (if (gethash j ht1)
	  (incf (gethash j ht1))
	  (setf (gethash j ht1) 1)))
    ;; handle justifications where the belief appears once as normal.
    ;; do one localized search step when the belief appears multiple times in a justification.
    (loop for count being the hash-values of ht1 using (hash-key j)
       do (if (= count 1) 
	      (let ((new-j  (clone-justification j sub-map)))
		;; NOTE: our filtering of inconsistent justifications is slowly being replaced
		;;       with a basic approach to belief revision, but we leave the hook here 
		;;       for the moment.
		(if (or (and *filter-inconsistent-justifications* (inconsistent-justification new-j))
                        (not (every #'(lambda (constraint)
                                        (every #'(lambda (b)
                                                   (not (null (literal-contradiction? (belief-content b) constraint))))
                                               (get-beliefs-by-predicate (predicate-name constraint) nil wrld)))
                                    (justification-constraints new-j))))
		    (setf (gethash j ht2) t) ;; pass on update
		    (progn 
		      (setf (values added-j new-beliefs) 
			    (move-isolated-justification new-j (justification-home j wm) c wrld wm))
		      (setf belief-list (append new-beliefs belief-list)))))
	      ;; XXX: not sure if we'll have a bug w/ violated constraints here.
	      ;;      if so, see solution above.
	      (progn 
		(setf (values added-j new-beliefs) 
		      (move-shared-belief-justification j c wrld wm))
		(setf belief-list (append new-beliefs belief-list)))))
    ;; remove the original justification, which was just specialized.
    ;; drop any beliefs that are no longer supported.
    (loop for count being the hash-values of ht1 using (hash-key oldj)
       unless (or (fresh-candidate? c :original? t) (gethash oldj ht2))
       do (dolist (empty-b (remove-justification-if-allowed (candidate-original-belief c) 
							    oldj
							    wrld wm))
	    (unless (or (fact? empty-b wrld) (null (belief-home empty-b wm)))
	      (unbelieve empty-b (belief-home empty-b wm) wm))))
    belief-list))

;;;;;;
;; one-to-one-belief-update
;;
;; if a belief never supports the same justification twice, then when
;; the belief is specialized, we update all the other justifications
;; that relied on that belief, specializing them all. in this special,
;; common case, the system can be aggressive.
;;
;; returns a list of beliefs created during the process
(defun one-to-one-belief-update (c wrld wm)
  ;; note: should only be called when a belief was updated
  (let ((sub-map (make-substitution-map 
		  (belief-content (candidate-original-belief c)) 
		  (belief-content (candidate-belief c))))
	added-j new-beliefs belief-list)
    (dolist (j (get-support (candidate-original-belief c) wrld) belief-list)
      ;; if cand-bel is already in the justification, then we treat this as
      ;; a one-to-many case and do not move the support. 
      ;; 
      ;; normally, if you have a belief that is supported by a single
      ;; justification and you replace Skolems in that belief with
      ;; domain constants, then you replace that version of the
      ;; justification with one that has been specialized.
      ;;
      ;; this line says that if the specialized version of the belief
      ;; already appears in a justification for the original,
      ;; unmodified belief, then don't use that justification as
      ;; support for the specialized belief. AbRA probably matched the
      ;; general belief from the justification to the more specialized
      ;; existing one from the same justification, which is most
      ;; likely nonsense. future versions of the code should probably
      ;; prevent that sort of matching or allow for its control
      ;; through declarative knowledge.
      (unless (member (candidate-belief c) (get-supported-beliefs j wrld) :key #'second) 
	;; we only want to move the justification if it doesn't violate constraints.
	;; if it violates constraints, we have to keep the old version around.
	(let ((new-j (clone-justification j sub-map)))
          (unless (every #'(lambda (constraint)
                             (every #'(lambda (b)
                                        (not (null (literal-contradiction? (belief-content b) constraint))))
                                    (get-beliefs-by-predicate (predicate-name constraint) nil wrld)))
                         (justification-constraints new-j))
            ;; NOTE: our filtering of inconsistent justifications is slowly being replaced
            ;;       with a basic approach to belief revision, but we leave the hook here 
            ;;       for the moment.
            (unless (and *filter-inconsistent-justifications* (inconsistent-justification new-j))
              (setf (values added-j new-beliefs) (move-isolated-justification new-j (justification-home j wm) c wrld wm))
              (setf belief-list (append new-beliefs belief-list))
              ;; drop any beliefs that are no longer supported
              (dolist (empty-b (remove-justification-if-allowed (candidate-original-belief c) j wrld wm))
                ;; sometimes two beliefs might be linked by multiple justifications
                ;; that could lead to two attempts to zap the same belief
                (unless (or (fact? empty-b wrld) (null (belief-home empty-b wm)))
                  (unbelieve empty-b (belief-home empty-b wm) wm))))))))))

;;;;;;
;; apply-explanation
;;
;; input:
;; c - a candidate that contains the justification and the world--belief
;;     actually being explained.
;; wrld - the world where the belief is being explained, this may not
;;        be the world where the belief resides.
;; wm - working memory
;;
;; output:
;;     all created beliefs are returned in a list of world-belief pairings
;;
;; registers the belief in c if it's new, and ensures that all the
;; knowledge structures are updated appropriately.
(defun apply-explanation (c wrld wm)
  ;; test whether the justification will lead to a contradiction.
  ;; if so, then resolve the contradiction before applying the explanation.
  ;; if the justification is rejected, store the contradictory literal and 
  ;; the rejected justification.
  (let (new-beliefs 
	(wb (add-new-belief c wm)))
    (when wb 
      (setf (candidate-belief c) (second wb))
      (push wb new-beliefs))
    (setf new-beliefs (append (add-new-justification c wrld wm) new-beliefs))
    
    ;; stop, unless c specializes an existing belief.
    (unless (eq (candidate-original-belief c) (candidate-belief c))
      (let ((support (get-support (candidate-original-belief c) wrld)))
	(if (= (length support) (length (remove-duplicates support)))
	    (setf new-beliefs (append (one-to-one-belief-update c wrld wm) new-beliefs))
	    (setf new-beliefs (append (one-to-many-belief-update c wrld wm) new-beliefs)))))
    
  ;;; TODO: needs testing.
  ;;; I think this is all that's needed when removing stale justifications.
  ;;; notes:
  ;;;   * when a world imports beliefs (accepts w/o modal qualifiers), those beliefs are 
  ;;;     considered immutable and justified. the world can only override those beliefs locally.
  ;;;     this is the case when an agent uses an observational world or a counterfactual world
  ;;;     imports beliefs from the agent's "real" world.
  ;;;   * otherwise, the beliefs may be altered if local justifications are retracted. if my 
  ;;;     belief world drops a goal because it's no longer supported, then the goal world should
  ;;;     update accordingly.
    (unless (or
	   (null (find-justification-id (candidate-original-justification c) wrld)) ;; never existed
	   (eq (candidate-original-justification c) (candidate-justification c)) ;; never changed
	   (fresh-candidate? c :original? t)) ;; nothing to remove
      ;; remove the justification to get the emptyb's 
      ;; remove the emptyb's
      (dolist (empty-b (remove-justification (candidate-original-justification c) wrld))
	(unless (fact? empty-b (world-parent wrld))
	  (unbelieve empty-b (belief-home empty-b wm) wm))))
    new-beliefs))
  
;;;;
  ;;
;; bp - a positive or negative literal 
;; rps - literals from an instantiated rule that could bind to bp
;;       without any conflicts (plus same modals, same negation status)
;;
;; return - the literal in rps that shares the most domain constants
;;          with bp and, in case of a tie, would leave the fewest skolems
;;          in both literals after they're bound to each other.
(defun most-specific-binding (bp rps)
  (cond ((null rps) nil)
	((= (length rps) 1)  
	   (car rps))
	(t
	 ;; XXX: inelegant solution...
	 ;;      i don't know if this code has been tested. rules typically only contain 
	 ;;      a single instance of a predicate
	 (cadar (stable-sort
		 ;; count the arguments that won't be bound.
		 (mapcar #'(lambda (x) 
			     (list (loop for rarg in (literal-args x) and barg in (literal-args bp)
				      count (and (skolem? rarg) (skolem? barg)))
				   x))
			 rps)
		 #'(lambda (x y) 
		     ;; prefer bindings that don't involve skolems at all
		     (cond ((= (first x) (first y))
			    (< (count-if #'skolem? (literal-args (second x)))
			       (count-if #'skolem? (literal-args (second y)))))
			   ;; avoid bindings skolems to each other
			   (t 
			    (< (first x) (first y))))))))))

;; bind-to-support
;;
;; blit - literal from a belief
;; j - justification
;; lit - literal from j that can unify with blit 
;;
;; return the (modal) literal with the updated constants and a new
;; justification that contains that literal
;;
;; TODO: We are not handling generic rules like B(?A, ?X) =>
;;       G(?A, ?X). The literal must not be a variable, like ?X.
(defun bind-to-support (mblf j lit id)
  (let ((map (make-substitution-map lit mblf)) tmp-j tmp-lit)
    (values (clone-justification j map id)
	    (clone-literal lit map))))
