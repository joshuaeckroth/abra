(in-package :abra)

;;;; lookahead.lisp

;;; XXX: part of the hack for the prototype demo representation of mental attitudes
(defun filter-dialog-justifications (on? lst)
  (if on?
      (remove-if #'(lambda (x) 
		     (member 'dialog 
			     (if (typep x 'rule)
				 (rule-contexts x)
				 (justification-contexts x)))) lst)
      lst))

(defun filter-dialog-rules (on? lst)
  (if on?
      (remove-if #'(lambda (x) 
		     (member 'dialog 
			     (if (typep x 'rule)
				 (rule-contexts x)
				 (justification-contexts x)))) lst)
      lst))


(defun print-laleaf (lf str d)
  (declare (ignore d))
  (format str "~%Candidate ::~%~TScore ~A~%~TA: ~A~%~TC: ~A~%~TnR: ~A"
	  (lookahead-leaf-score lf) 
	  (lookahead-leaf-world lf)
	  (lookahead-leaf-candidate lf)
	  (length (lookahead-leaf-roots lf))))

(defstruct (lookahead-leaf  (:print-function print-laleaf))
  original  ; the original candidate if one exists (primarily for roots)
  candidate ; the candidate justification
  world     ; the world from which we should view the canddiate (needed for properly continuing search)
  roots     ; a list of roots that lead to this leaf
  score)    ; the score of the candidate


;; tracks the search boundary for a breadth-first traversal
;; stores visited nodes, but not complete paths
(defstruct boundary
  ;; map instantiated rule to leaf
  (current (make-hash-table :test 'equal))
  ;; set of instantiated rules
  (history (make-hash-table :test 'equal)))

(defun clear-boundary? (score boundary-ht)
  (and (not (zerop (hash-table-count boundary-ht)))
       (> score (lookahead-leaf-score (first (hash-table-values boundary-ht))))))

(defun expand-boundary? (score boundary-ht)
  (or (zerop (hash-table-count boundary-ht))
      (>= score (lookahead-leaf-score (first (hash-table-values boundary-ht))))))

;;;;;
;; extend-boundary
;; 
;; lf - a lookahead-leaf
;; b - a boundary
;;
;; adds the leaf to the boundary as long as its score is >= the scores
;; of other nodes on the boundary. if the leaf has a higher score, it
;; replaces all nodes on the boundary.
(defun extend-boundary (lf b)
  (let ((bc (boundary-current b))
	(candidate (justification-content (lookahead-leaf-candidate lf))))
    ;; new leader, so wipe the earlier boundary
    (when (clear-boundary? (lookahead-leaf-score lf) bc)
      (clear-boundary b))
    (when (expand-boundary? (lookahead-leaf-score lf) bc)
      ;; either add new roots to an existing version of lf or add lf to the boundary
      (if (gethash candidate bc)
	  (setf (lookahead-leaf-roots (gethash candidate bc))
		(union (lookahead-leaf-roots lf) (lookahead-leaf-roots (gethash candidate bc))))
	  (setf (gethash candidate bc) lf)))))

;;;;;
;; get-boundary
;; 
;; b - a boundary
;;
;; returns a list of leaves that compose the current search
;; boundary. these are limited to the most promising branches
;; according to the lookahead-leaf score.
(defun get-boundary (b)
  (hash-table-values (boundary-current b)))

;;;;;
;; clear-boundary
;; 
;; b - a boundary
;;
;; clears the boundary of all contents.
(defun clear-boundary (b)
  (clrhash (boundary-current b)))

;;;;;
;; update-historical-boundary
;; 
;; b - a boundary
;;
;; updates the search history with items currently in the boundary.
(defun update-historical-boundary (b)
  (dolist (c (hash-table-keys (boundary-current b)))
    (setf (gethash c (boundary-history b)) t)))

;;;;;
;; in-historical-boundary?
;; 
;; lf - a lookahead-leaf
;; b - a boundary
;;
;; true if the justification associated with the leaf has been previously explored.
(defun in-historical-boundary? (lf b)
  (gethash (justification-content (lookahead-leaf-candidate lf)) (boundary-history b)))

;;;;;
;; unifiable-belief?
;; 
;; lit - a literal
;; blf - a belief 
;;
;; true if the literal can unify with the belief.
(defun unifiable-belief? (lit blf)
  (not (binding-conflict? (literal-args lit) (literal-args (belief-content blf)))))

;;;;;
;; find-unifiable-beliefs
;; 
;; lit - a literal
;; blf - a list of beliefs
;;
;; returns a list of the beliefs in bfs that can unify with lit.
(defun find-unifiable-beliefs (lit bfs)
  (loop for b in bfs
       when (unifiable-belief? lit b)
       collect b))

;;;;;
;; get-beliefs-by-literal
;; 
;; lit - a literal
;; wrld - a world
;;
;; gets beliefs that match the given non-modal literal's predicate and sign.
;; scours world and any observation worlds that it touches.
;; returns a list of beliefs.
(defun get-beliefs-by-literal (lit wrld)
  (get-beliefs-by-predicate (predicate-name lit) (negated? lit) wrld))

;;  (mappend #'(lambda (x) 
;;	       (get-beliefs-by-predicate (predicate-name lit) (negated? lit) x))
;;	   (cons wrld (mapcar #'second (world-obs-worlds wrld)))))

;;;;;
;; collect-candidates
;; 
;; blf - a list of beliefs
;; wrld - a world
;;
;; true if the literal can unify with the belief.
;; returns the justifications that support the given beliefs within the given world.    
(defun collect-candidates (bfs wrld)
  (loop for b in bfs
     append (append (get-support b wrld) (mapcar #'second (belief-weak-links b)))))

;;;;;
;; lookahead-ties
;;
;; lvs - a list of lookahead-leaves
;;
;; returns leaves that tie for highest score
(defun lookahead-ties (lvs)
  (when lvs
    (let ((mx (apply #'max (mapcar #'lookahead-leaf-score lvs))))
      (filter #'(lambda (x) (= mx (lookahead-leaf-score x))) lvs))))


;;;;;
;; same-roots?
;;
;; leaves - list of leaf nodes
;;
;; true if all the leaves stem from the same root.
(defun same-roots? (leaves)
  (when (apply #'= (mapcar #'(lambda (x) (length (lookahead-leaf-roots x))) leaves))
    (= (length (delete-duplicates (mappend #'(lambda (x) (lookahead-leaf-roots x)) leaves) :test #'equal))
       (length (lookahead-leaf-roots (first leaves))))))

;;;;;
;; spread-unifications
;; 
;; lit - a literal
;; jsts - a list of justifications
;;
;; find all justifications in jsts that can unify with lit. carry out
;; the unification and return the resulting justifications. if there
;; are multiple legal unifications per justification, return a new
;; justification for each of these.
;;
;; returns a list of bound justifications
(defun spread-unifications (lit jsts &key (rootmode nil))
  (let (lst)
    (dolist (j (filter #'(lambda (j) (bindable? lit j)) jsts) lst)
      (if rootmode
	  (push (clone-justification j nil 'JNEW) lst)
	  (dolist (newj (mapcar #'(lambda (bnd) (bind-to-support lit j bnd 'JNEW)) (find-bindings lit j)))
	    ;; definitely need to indicate that this should be treated as a new justification.
	    (push newj lst))))))

;;;;;
;; score-roots
;; 
;; leaves - a list of scored lookahead-leaves 
;;
;; assigns a score to each root justification that is equal to the
;; highest score of its reachable leaves.
(defun score-roots (leaves)
  (dolist (leaf leaves)
    (dolist (root (lookahead-leaf-roots leaf))
      (when (< (lookahead-leaf-score root) (lookahead-leaf-score leaf))
	(setf (lookahead-leaf-score root) (lookahead-leaf-score leaf))))))

;;;;;
;; find-unifiable-justifications
;;
;; lit - a literal
;; wrld - a world
;; rootlit - the lit that started the hunt. needed if we resolved modals.
;; rootwrld - the wrld that started the hunt. needed if we resolved modals.
;; wm - working memory
;; kb - a knowledge base
;; ignore - literals that should not be treated as matches when encountered
;;
;; 1. looks for existing justifications that could unify with the literal.
;; 2. looks for justifications from the knowledge base that could unify with the literal.
;;
;; returns those justifications as lookahead-leaves when they exist.
(defun find-unifiable-justifications (lit wrld rootlit rootwrld wm kb &key (ignore nil) (rootmode nil))
  ;; essentially looks for existing beliefs that can unify with the
  ;; literal and returns the justifications for those beliefs.
  (mapcar #'(lambda (c) 
	      (make-lookahead-leaf 
	       :candidate c 
	       :world rootwrld
	       :score (score-justification c rootwrld wm :ignore (cons rootlit ignore))))
	  (remove-duplicates 
	   (append 
	    (collect-candidates 
	     (find-unifiable-beliefs lit (get-beliefs-by-literal lit wrld)) wrld)
	    (spread-unifications lit (get-inst-rules lit kb) :rootmode rootmode)))))

;; generates literals implied by the given one.
;; for instance, if lit were (belief a1 (belief a2 (foo x))) and 
;; agt were a1, then we would get 
;; ((<a1's belief world> (belief a1 (belief a2 (foo x))))
;;  (<a2's belief world> (belief a2 (foo x))))
;;
;; NOTE: if the nested agent doesn't exist yet, then end. since we
;; need to look at beliefs *inside* of partitions to carry out
;; lookahead, it makes sense that we would actually *have* those
;; partitions. if we don't, then we can't go any further.
(defun implied-literals (lit agt)
  (unless (null agt)
    (let ((m-wrld (modal-to-world (modality lit) agt))
	  (next-lit (modal-content lit)))
      (cons (list m-wrld lit)
	    (implied-literals next-lit
			      (find (modal-agent next-lit) 
				    (world-agents m-wrld) 
				    :key #'agent-name))))))

;;;;;
;; lookahead-from-roots
;;
;; rtcands - a list of lookahead-leaf candidates
;; depth - the maximum amount of lookahead to apply
;; wm - working memory
;; kb - a knowledge base
;;
;; connects members of rtcands to existing beliefs using the lookahead
;; strategy and returns the candidates with the maximum score (using
;; score-justification).
(defun lookahead-from-roots (rtcands depth wm kb)
  (when rtcands
    (let ((b (make-boundary))
	  (cands rtcands))
      (mapcar #'(lambda (x) (setf (lookahead-leaf-roots x) (list x))) cands)
      (loop while (and (>= (decf depth) 0)
		       (> (length (setf cands (lookahead-ties cands))) 1)
		       (not (same-roots? cands)))
	 do
	   (clear-boundary b)
	   (mapcar #'(lambda (x) (extend-boundary x b)) cands)
	   (update-historical-boundary b)
	   (setf cands nil)
	 ;; now do the lookahead from the new boundary to the next boundary
	   (dolist (lal (get-boundary b))
	     (dolist (wrld-lt (mappend #'(lambda (x) (implied-literals x (world-parent (lookahead-leaf-world lal))))
						      (literals (lookahead-leaf-candidate lal))))
	       ;;; XXX: this is the bastard that needs a change.
	       ;;; (1) expand the set of literals to include ones where the 
	       ;;;     layers of modal operators are stripped off, one at a time.
	       ;;; (2) adjust the world argument accordingly.
	       ;;; (3) afterwards, find-unifiable-justifications should simply work.
	       ;;; (4) except we'll need to ensure that the world perspective is 
	       ;;;     preserved in the new lookahead leaves, but it looks like
               ;;;     find-unifiable-justifications will already do this.
	       (dolist (new-leaf (find-unifiable-justifications (second wrld-lt) (first wrld-lt) 
								(second wrld-lt) (first wrld-lt) wm kb))
		 ;; root lists will get merged when the boundary is extended
		 (setf (lookahead-leaf-roots new-leaf) (lookahead-leaf-roots lal))
		 (push new-leaf cands))))
	 ;; eh, it happens.
	   (setf cands (remove nil cands))
	 ;; don't revisit candidates
	   (setf cands (remove-if #'(lambda (x) (in-historical-boundary? x b)) cands)))
      (score-roots cands)
      (setf rtcands (lookahead-ties rtcands))
      (mapcar #'convert-leaf-to-candidate rtcands))))


(defun convert-leaf-to-candidate (leaf)
  (setf (candidate-la-score (lookahead-leaf-original leaf))
	(lookahead-leaf-score leaf))
  (lookahead-leaf-original leaf))

(defun convert-candidate-to-leaf (c wm)
  (make-lookahead-leaf 
   :original c
   :candidate (candidate-justification c) 
   :world (candidate-world c)
   :score (score-justification (candidate-justification c)
			       (candidate-world c) 
			       wm 
			       :ignore (cons (candidate-belief c) '()))))

(defun lookahead (wm kb cands &key (maxdepth 10))
  (lookahead-from-roots 
   (mapcar #'(lambda (x) (convert-candidate-to-leaf x wm)) cands)
   maxdepth wm kb))
