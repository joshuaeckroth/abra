(in-package :abra)

(defvar *mutex-preds* nil)
(defvar *belief-conflict-test* nil)

(defun support-strength (b wrld wm &key (test #'max))
  (apply test
         ;; add a 0 so that max or whatever has at least one value to work with
         (cons 0 (mapcar #'(lambda (j) (score-justification j wrld wm)) (get-support b wrld)))))

(defun revise-beliefs (potential-conflicts wm)
  (revise-beliefs-local-score potential-conflicts wm))

;; currently only suitable for the case where a belief conflicts with one other belief
(defun revise-beliefs-arguments (potential-conflicts wm)
  (let (current-conflicts)
    (dolist (pc potential-conflicts)
      (setf current-conflicts (predicate-conflict (second pc) *mutex-preds* (first pc)))
      ;; XXX: assume that current conflicts contains a single item
      (when current-conflicts
	(destructuring-bind (w b)
	    (reject-argument (second pc) (first current-conflicts) (first pc))
	  (resolve-by-removal b w wm))))))
	

;; can handle the case when a belief conflicts with multiple others.
(defun revise-beliefs-local-score (potential-conflicts wm)
  ;; process one potential conflict at a time
  ;; check for conflict
  ;; resolve contradiction if necessary
  ;; see if the next potential conflict is still in memory
  ;; if so, then continue processing.
  (let (current-conflicts conflict-score (best-existing-score 0) (test #'max))
    (dolist (pc potential-conflicts)
      (setf current-conflicts (predicate-conflict (second pc) *mutex-preds* (first pc)))
      (when current-conflicts
	;; score the justification for the belief
	(setf conflict-score 
	      (support-strength (second pc) (first pc) wm :test test)
	      best-existing-score 
	      (apply #'max (mapcar #'(lambda (x) (support-strength x (first pc) wm :test test)) current-conflicts)))
	(when *vocal*
          (format t "~A [~A] conflicts with ~A [~A] (no facts? ~A)~%" (second pc) conflict-score current-conflicts best-existing-score
                  (notany #'(lambda (c) (fact? c (wm-prime wm)))
                          current-conflicts)))
        ;; if at least one conflict is a fact, remove the new belief, not the fact
        (if (some #'(lambda (c) (fact? c (wm-prime wm)))
                  current-conflicts)
            (progn (when *vocal* (format t "Removing ~A~%" (second pc)))
                   (resolve-by-removal (second pc) (first pc) wm))
            (if (or (< conflict-score best-existing-score))
                ;; if there are any conflicts at all, we're going to retract
                ;; the new belief.  we're not going to prevent reintroduction
                ;; in any way since there's no support for that in the system.
                (progn (when *vocal* (format t "Removing ~A~%" (second pc)))
                       (resolve-by-removal (second pc) (first pc) wm))
                (progn (when *vocal* (format t "Removing each of ~A~%" current-conflicts))
                       (dolist (x current-conflicts)
                         (resolve-by-removal x (first pc) wm)))))))))

;; if the given predicate conflicts with an existing literal in the
;; world, return a list of conflicting literal. mutex pred is a list
;; of lists of mutually exclusive predicates. assume that it's okay to
;; have multiple literals with the *same* predicate, which might not
;; be the case.
(defun predicate-conflict (blf mutex-preds world) 
  ;; this function is a basic implementation designed so that i can
  ;; run experiments on the monroe, shopping, and similar domains
  ;; where there are mutually exclusive interpretations of an event
  ;; and where there are no negation. as a result, we don't worry
  ;; about the effect of negation right now. assume that all the
  ;; mutual exclusive constraints are concerned with positive
  ;; literals.
  (let ((pred (predicate-name (belief-content blf)))
        conflicts)
    (when *belief-conflict-test*
      (dolist (b (get-beliefs-by-predicate pred nil world))
        (when (funcall *belief-conflict-test* pred blf b)
          (setf conflicts (cons b conflicts)))))
    (dolist (mx mutex-preds (remove blf conflicts))
      (when (member pred mx)
        (let ((blf-conflicts
               (filter #'(lambda (b)
                           (when *vocal*
                             (format t "~A conflicts? ~A: ~A~%" blf b
                                     (belief-contradiction? blf b)))
                           (belief-contradiction? blf b))
                       (mappend #'(lambda (p) (get-beliefs-by-predicate p nil world)) mx))))
          (setf conflicts (append blf-conflicts conflicts)))))))

;; removes the specified belief from memory.
;; does not block it from being reintroduced.
;; absolutely the least one could do.
(defun resolve-by-removal (b wrld wm)
  ;; remove all justifications for b
  (dolist (j (get-support b wrld))
    (when *vocal* (format t "Removing justification:~%~T~A~%" j))
    (dolist (dead-b (remove-justification j wrld))
      ;; as we remove the justification, we'll end up removing b unless it's
      ;; a fact. in that case, we keep it around unjustified.
      (unless (fact? dead-b (world-parent wrld))
        (when *vocal* (format t "Unbelieving ~A~%" dead-b))
        (unbelieve dead-b wrld wm)))))



;; NOTE: only develops arguments based on beliefs in wrld.  does not
;;       try to develop cross partition or cross agent explanations
(defun reject-argument (blf1 blf2 wrld)
  (destructuring-bind (arg1 arg2) 
      (build-arguments (belief-depths blf1 wrld) (belief-depths blf2 wrld) wrld)
    (multiple-value-bind (winner score1 score2) (select-argument arg1 arg2 wrld)
      (when *vocal* (format t "~A (~A) vs.~%~T~A (~A) ~%" blf1 score1 blf2 score2))
      (if (eq winner arg1)
	  ;; keep blf1 
	  (list wrld blf2)
	  ;; keep blf2
	  (list wrld blf1)))))

(defun belief-depths (blf wrld)
  (let ((q (make-queue))
	(depth-table (make-hash-table)))
    (enqueue q (cons blf 0))
    (loop with itm = nil
	  do (setf itm (dequeue q))
	     (unless (gethash (car itm) depth-table)
	       (setf (gethash (car itm) depth-table) (cdr itm))
	       ;; NOTE: connected-beliefs is not world/agent aware
	       ;; only beliefs in the same world as itm will be
	       ;; returned.
	       (dolist (b (connected-beliefs (car itm) wrld))
		 (enqueue q (cons b (1+ (cdr itm))))))
	  until (empty-queue-p q)
	  finally (return depth-table))))

;; assign beliefs to argument 1, 2, or both based on their depth
;; returns a tuple of both arguments
(defun build-arguments (bht1 bht2 wrld)
  (let ((all-blfs (union (get-facts wrld) (union (hash-table-keys bht1) (hash-table-keys bht2))))
	arg1 arg2 both)
    (dolist (b all-blfs (list arg1 arg2))
      ;; each argument has to account for all the facts
      (cond ;((fact? b wrld)
	    ; (push b arg1) (push b arg2))
	    ((and (gethash b bht1) (gethash b bht2))
	     (cond ((< (gethash b bht1) (gethash b bht2))
		    (push b arg1))
		   ((> (gethash b bht1) (gethash b bht2))
		    (push b arg2))
		   (t
		    (push b arg1) (push b arg2))))
	    ((gethash b bht1)
	     (push b arg1))
	    ((gethash b bht2)
	     (push b arg2))))))
	     

;; evaluates arguments with respect to the world and returns the best one
(defun select-argument (arg1 arg2 wrld)
  (let ((score1 (score-argument arg1 wrld))
	(score2 (score-argument arg2 wrld)))
    (values 
     (cond ((> score1 score2)
	    arg1)
	   ((> score2 score1)
	    arg2)
	   (t
	    (if (heads? (coin-flip))
		arg1
		arg2)))
     score1 score2)))

;; gives a quantitative score to an argument evaluated with respect to
;; the given world.
(defun score-argument (arg wrld)
  (let ((score 0))
    (dolist (b arg)
      (incf score (score-belief-arg b wrld arg)))
   ;; (format t "~A~%"     (/ score (length arg)))
    (/ score (length arg))))

(defun score-belief-arg (b w arg)
  (+ (if (fact? b w) 1 0) 
     ;; only count a justification if all its beliefs are in arg
     ;; XXX: yep. this is just as hacky as the rest of the belief revision code.
     (length (remove-if #'(lambda (j) (> (length (set-difference (mapcar #'second (get-supported-beliefs j w)) arg)) 0))
			(get-support b w)))))

#|
evaluate an argument on how well it explains the facts.

(defun score-belief-arg (b w arg)
  (if (fact? b w)
      (length (remove-if #'(lambda (j) 
;;			     (format t "~%~A~%" (set-difference (mapcar #'second (get-supported-beliefs j w)) arg))
			     (> (length (set-difference (mapcar #'second (get-supported-beliefs j w)) arg)) 0))
			 (get-support b w)))
      0))
|#



;;;;;;
;;;
;;; This approach to argument construction is guided by the rule structure of the knowledge base
;;; arguments do not allow forward chaining. This makes sense in the Monroe domain, where the 
;;; contradictions all happen at the top level. It may not make sense when arguments lack a 
;;; strict hierarchy.
;;;
;;; preliminary results suggest that this doesn't make a difference in scores, but the running
;;; time increases due to the particularly inefficient implementation of antecedent-connected-beliefs.
;;; in at least one case, i improved the accuracy/goal scores by not evaluating the arguments on 
;;; all facts, instead evaluating the arguments on the subset of facts that they account for. this 
;;; was odd and carried over to the other argument building approach. odd.


;; this function cares about the rule organization and only 
;; backchains through the explanation.
(defun backchained-beliefs (blf wrld)
  (let ((q (make-queue))
	(depth-table (make-hash-table)))
    (enqueue q blf)
    (loop with itm = nil
	  do (setf itm (dequeue q))
	     (setf (gethash itm depth-table) t)
	     ;; NOTE: connected-beliefs is not world/agent aware
	     ;; only beliefs in the same world as itm will be
	     ;; returned.
	     (dolist (b (antecedent-connected-beliefs itm wrld))
	       (enqueue q b))
	  until (empty-queue-p q)
	  finally (return depth-table))))

;; assign beliefs to argument 1, 2, or both based on their depth
;; returns a tuple of both arguments
(defun build-backchained-arguments (bht1 bht2 wrld)
  ;; ensure that all facts are in both arguments
  (dolist (b (get-facts wrld) 
	     (list (hash-table-keys bht1) (hash-table-keys bht2)))
    (setf (gethash b bht1) t
	  (gethash b bht2) t)))


(defun reject-backchained-argument (blf1 blf2 wrld)
  (destructuring-bind (arg1 arg2) 
      (build-backchained-arguments (backchained-beliefs blf1 wrld) (backchained-beliefs blf2 wrld) wrld)
    (multiple-value-bind (winner score1 score2) (select-argument arg1 arg2 wrld)
      ;(format t "~A (~A) vs.~%~T~A (~A) ~%" blf1 score1 blf2 score2)
      (if (eq winner arg1)
	  ;; keep blf1 
	  (list wrld blf2)
	  ;; keep blf2
	  (list wrld blf1)))))
