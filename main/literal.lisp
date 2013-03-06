(in-package :abra)

;;;; LITERALS

;; takes a literal and reports whether it is encased in a modal belief
;; operator. this could possibly be more clever.
;;
;; belief modals in rules or justifications will look like
;; (belief ?agent <literal>)
;; this is shorthand for (belief you (belief ?agent <literal>))
;; just like (restaurant-name ?d ?r) is shorthand for 
;; (belief you (restaurant-name ?d ?r))
;;
;; the literal in a belief modal may unpack to be another belief.  the
;; agent in a belief modal may be a variable, which means that the
;; system should search through all the agent worlds that it believes.
;; to represent (belief you (belief ?agent (belief you <literal>)))
;; the rule will use the constant "you" to identify the agent whose
;; world it fires in. this feature is necessary to support perspective
;; shift. otherwise all rules are interpreted as if the system were
;; reasoning from a single, privileged perspective.

(defconstant +belief+ 'belief)
(defconstant +goal+ 'goal)
(defconstant +intention+ 'intention)

(defun belief-modal? (lit)
  (eq (first lit) +belief+))

(defun goal-modal? (lit)
  (eq (first lit) +goal+))

(defun intention-modal? (lit)
  (eq (first lit) +intention+))

;; returns the agent if there is a belief modality on the literal.
;; otherwise it returns nil.
;; (defun modal-agent (lit)
;;   (if (belief-modal? lit)
;;       (second lit)))
;; NOTE: currently entertaining the idea of a syntactic shorthand, where 
;; (goal ?a1 (foo x)) is treated as (belief ?a1 (goal (foo x)))
;; by the system.
(defun modal-agent (lit)
  (when (modal-lit? lit) (second lit)))

;; returns the modality of the literal
(defun modality (lit)
  (when (modal-lit? lit) (first lit)))

;; returns the content of a modal literal, meaning that the outermost
;; modal is removed
;; returns literal if the literal isn't a modal.
(defun modal-content (lit)
  (if (modal-lit? lit)
    (first (last lit))
    lit))

;; returns the core proposition content of a modal literal
(defun modal-literal (x)
  (if (modal-lit? x)
      (modal-literal (modal-content x))
      x))

(defun modal-lit? (x)
  (or (belief-modal? x)
      (goal-modal? x)
      (intention-modal? x)))

(defun remove-goal-modal (lit)
  (modal-content lit))

(defun remove-intention-modal (lit)
  (modal-content lit))

;; returns t when given a negative literal
;; negated literals will look like (not <literal>)
(defun negated? (lit)
  (eq (first lit) 'not))

;; true when x is a literal (positive or negative)
(defun literal? (x)
  (cond ((negated? x)
	 (literal? (second x)))
	((modal-lit? x)
	 (literal? (third x)))
	(t
	 (not (find-if #'consp (cdr x))))))

;; return a negated version of the literal.
(defun negate (lit)
  (list 'not lit))

;; returns the literal with the opposite sign.
;; XXX: 8/11/11 need to push the negation inside all the modals.
(defun flip-negation (lit)
  (if (eq 'not (first lit))
      (second lit)
      (negate lit)))
	  
;; returns the predicate in a negative or positive literal
(defun predicate-name (lit)
  (cond ((negated? lit)
	 (predicate-name (second lit)))
	((modal-lit? lit)
	 (predicate-name (third lit)))
	(t
	 (first lit))))

;; returns t if the literal is fully bound
(defun literal-grounded? (lit)
  (not (find-if #'(lambda (x) (or (skolem? x) (variable? x))) (literal-args lit))))

;; returns the arguments in a literal
(defun literal-args (lit)
  (cond ((negated? lit)
	 (literal-args (second lit)))
	((modal-lit? lit)
	 (literal-args (third lit)))
	(t 
	 (rest lit))))

;; true if a1 and a2 are the same constant or are both skolems.
(defun equivalent-args? (a1 a2)
  (or (eql a1 a2)
      (and (skolem? a1) (skolem? a2))))

;; literals are equal if
;; (a) they have the same sign
;; (b) they have the same predicate
;; (c) they have the same domain constants in the same positions
;; (d) they have the same modal operators
(defun literal-equal? (lit1 lit2 &key (test #'equivalent-args?) (exact-modals? nil))
  (and (literal? lit1) (literal? lit2)
       (match-modals? lit1 lit2 :exact? exact-modals?)
       (if (negated? (modal-literal lit1)) (negated? (modal-literal lit2)) (not (negated? (modal-literal lit2))))
       (eql (predicate-name lit1) (predicate-name lit2))
       (= (length (literal-args lit1)) (length (literal-args lit2)))
       (not (mismatch (literal-args lit1) (literal-args lit2)
		      :test test))))

;; literals contradict each other if 
;; (a) they have the same predicate
;; (b) they have the same constants in the same positions
;; (c) they have opposite valence
;; (d) they have the same modal operators
(defun literal-contradiction? (lit1 lit2 &key (test #'equivalent-args?) (exact-modals? nil))
  (and (literal? lit1) (literal? lit2)
       (match-modals? lit1 lit2 :exact? exact-modals?)
       (eql (predicate-name lit1) (predicate-name lit2))
       (= (length (literal-args lit1)) (length (literal-args lit2)))
       (not (mismatch (literal-args lit1) (literal-args lit2)
		      :test test))
       (if (negated? (modal-literal lit1)) (not (negated? (modal-literal lit2))) (negated? (modal-literal  lit2)))))

;;; match-predicate?
;;;
;;; input: pred - a predicate in icarus format
;;;        lit  - a literal (a positive or negative fact)
;;;
;;; output: t   - if lit is an instance of pred
;;;         nil - otherwise
;;;
;;; example: (match-predicate? '(foo x y) '(not (foo BAR EXAM))) ==> t
;;;          (match-predicate? '(foo x y) '(foo BAR)) ==> nil
;;;
;;; warning: no sanity checks on input
(defun match-predicate? (pred lit)
  (and (eq (predicate-name lit) (predicate-name pred))
       (= (length (literal-args lit)) (length (literal-args pred)))))

;;; strip-modals
;;;
;;; input: lit - a literal
;;; 
;;; output: the same literal with any modals stripped from it
(defun strip-modals (lit)
  (if (modal-lit? lit)
      (strip-modals (first (last lit)))
      lit))

;;; match-modals?
;;;
;;; input: lit1 - a literal
;;;        lit2 - a literal
;;; keyword: exact?
;;;            -- when t treats arguments as-is
;;;            -- otherwise, removes instances of self-reflection
;;;
;;; output: t   - if the modal operators in lit1 and lit2 are identical
(defun match-modals? (lit1 lit2 &key (exact? t))
  (unless exact? (setf lit1 (remove-self-reference lit1)
		       lit2 (remove-self-reference lit2)))
  (and (equal (list-modals lit1) (list-modals lit2))
       (not (mismatch (list-agents lit1) (list-agents lit2) :test #'bindable-args?))))

;;; list-modals
;;;
;;; input: lit - a (modal) literal
;;;
;;; output: a list of modal operators modifying the literal
;;;
;;; example: (list-modals '(belief (goal (belief (intention (foo b c))))))
;;;          => (belief goal belief intention)
(defun list-modals (lit)
  (when (modal-lit? lit)
      (cons (modality lit) (list-modals (modal-content lit)))))

;;; list-modals
;;;
;;; input: lit - a (modal) literal
;;;
;;; output: a list of agents assigned to the modal operators
;;;
;;; example: (list-modals '(belief a (goal a (belief b (intention d (foo b c))))))
;;;          => (a a b d)
(defun list-agents (lit)
  (when (modal-lit? lit)
    (cons (modal-agent lit) (list-agents (modal-content lit)))))

;; input: mlit - a modal literal
;;        lit  - an arbitrary literal
;; 
;; appends the modal/agent wrapper on mlit to lit
;;
;; example: (add-modals '(belief A (goal B (intention C (foo bar baz)))) '(tell me why))
;;          => (BELIEF A (GOAL B (INTENTION C (TELL ME WHY))))
(defun add-equivalent-modals (mlit lit)
  (add-modals-and-agents (list-modals mlit)
			 (list-agents mlit)
			 lit))

(defun add-modals-and-agents (mlst alst lit)
  (if (null mlst)
      lit
      (list (first mlst) (first alst) (add-modals-and-agents (rest mlst) (rest alst) lit))))

;; input: mlit - a modal literal
;;
;; output: the literal with any direct self reference removed.
;;
;; example (remove-self-reference '(belief A (belief A (goal A (goal A (belief A (foo)))))))
;;         => (belief A (goal A (foo)))
;; A can, of course, have a goal for itself to have a goal, but it would have to distinguish
;; itself, A, from its goal self, say A'.
(defun remove-self-reference (mlit)
  (let ((content (modal-content mlit)))
    (cond ((not (modal-lit? content))
	   mlit)
	  ((and (eql (modal-agent mlit) (modal-agent content))
		(eql (modality mlit) (modality content)))
	   (remove-self-reference content))
	  (t
	   (list (modality mlit)  (modal-agent mlit) (remove-self-reference content))))))

;; takes a modal literal and the agent for that literal's top-level modal operator
;; returns a list containing (a) a literal with one layer of modality removed and
;; (b) the next agent in the nested structure.
;; if the modal-content of the literal is not modal, then (b) is agt.
(defun dereference-agent (mlit agt)
  (if (modal-lit? (modal-content mlit))
      (list (modal-content mlit)
	    (find (modal-agent (modal-content mlit)) (world-agents (modal-to-world (modality mlit) agt)) :key #'agent-name))
      (list (modal-content mlit) agt)))
