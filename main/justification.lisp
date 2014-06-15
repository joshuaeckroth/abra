(in-package :abra)

;;;; JUSTIFICATIONS

(let ((jid 0)) 
  (defun reset-justification-id () (setf jid 0))
  (defun make-justification-id () 
    (symb "J" (incf jid))))


(defstruct (justification (:conc-name justification-)
		   (:print-function print-justification)
		   (:predicate justification?))
  (id (make-justification-id) :type symbol :read-only t)
  ;; NEW: save prior version of the justification when copying
  (prior nil :read-only t)
  antecedent
  consequent
  constraints
  contexts)

(defun print-justification  (j str d)
  (declare (ignore d))
  (if (justification-constraints j)
      (format str "(~A: ~A => ~A) {~A} (Prior: ~A)" (justification-id j) 
	      (justification-antecedent j) 
	      (justification-consequent j)
	      (justification-constraints j)
              (if (null (justification-prior j)) nil
                  (justification-id (justification-prior j))))
      (format str "(~A: ~A => ~A) (Prior: ~A)" (justification-id j) 
	      (justification-antecedent j) 
	      (justification-consequent j)
              (if (null (justification-prior j)) nil
                  (justification-id (justification-prior j))))))

(defun skolemize (rl &optional (ht (make-hash-table :test #'eq)))
  (cond ((variable? rl)
	 (if (gethash rl ht) 
	     (gethash rl ht)
	     (setf (gethash rl ht) (make-skolem))))
	((atom rl)
	 rl)
	(t 
	 (cons (skolemize (car rl) ht)
	       (skolemize (cdr rl) ht)))))

;; bind variables to skolem constants
(defun instantiate-rule (r)
  (let ((skolem-hash (make-hash-table :test #'eq)))
    (make-justification 
     :antecedent (skolemize (rule-antecedent r) skolem-hash)
     :consequent (skolemize (rule-consequent r) skolem-hash)
     :constraints (skolemize (rule-constraints r) skolem-hash)
     :contexts (rule-contexts r))))

;; returns the internals of the justification as a list of lists
;; guarantees literal order: antecedent, consequent, constraints
(defun justification-content (j)
  (list (justification-antecedent j)
	(justification-consequent j)
	(justification-constraints j)))

;; given a literal retaining structure, return those literals
(defgeneric literals (obj))

;; returns all the literals in a justification
(defmethod literals ((j justification))
  (copy-list (append (justification-antecedent j) (justification-consequent j))))

(defun contradictory-justification (j)
  ;; when detecting contradictions within a justification, it's important to
  ;; match skolems. otherwise, (p sk1) and (not (p sk2)) would inaccurately
  ;; trigger a contradiction.
  (detect-contradiction (literals j)))

(defun detect-contradiction (lts)
  (unless (null lts)
    (or (member-if #'(lambda (x) (literal-contradiction? (first lts) x :test #'eql))
		   (rest lts))
	(detect-contradiction (rest lts)))))

(defun fully-grounded? (j)
  (null (find-if-not #'literal-grounded? (literals j))))

;;; list-predicates
;;;
;;; input: a rule
;;; output: a list of the predicates in that rule.
;;;  predicates are consed with not if they're negated otherwise, they're
;;;  consed with nil.
(defun list-predicates (r)
  (mapcar #'(lambda (lt) 
	      (if (negated? lt) 
		  (list (predicate-name lt) 'not)
		  (list (predicate-name lt))))
	  (literals r)))

;;; input: a rule
;;; output: a list of the names of the predicates in that rule
(defun predicate-names (r)
  (mapcar #'predicate-name (literals r)))

;; takes a predicate and a justification or rule
;; returns each use of the predicate in a rule
(defun find-predicate-in-rule (pred rl)
  (find-predicate pred (literals rl)))
  

;; takes a predicate and a list of literals
;; returns each literal that matches the predicate
;; ignores modals and negations.
(defun find-predicate (pred lit-list)
  (delete-if-not #'(lambda (x) (eql (predicate-name pred) (predicate-name x)))
		 lit-list))

(let ((skhash (make-hash-table :test 'equal)))
  ;; we keep a hash table around for efficiency, although this 
  ;; prohibits parallel execution.
  
  ;; tests whether two rule instantiations are equivalent.
  ;;
  ;; returns t if r1 and r2 are equivalent.
  ;; all domain constants are identical.
  ;; all skolems are equivalent. here that means that they preserve 
  ;; rule structure. the following is an example where skolems are 
  ;; not equivalent:
  ;; (=> (and (p1 "SK1" "SK2") (p2 "SK2" "SK3")) (p3 "SK1" "SK3"))
  ;; (=> (and (p1 "SK1" "SK2") (p2 "SK2" "SK3")) (p3 "SK1" "SK2"))
  (defun justification-equal? (r1 r2)
    (clrhash skhash)
    (or (eq r1 r2)
	(justification-equal-help 
	 (list (justification-antecedent r1) (justification-consequent r1))
	 (list (justification-antecedent r2) (justification-consequent r2)))))

  ;; tests whether r1 subsumes r2
  ;; t when the domain constants in r2 either equal those in r1 or
  ;;   match to equivalent skolems in r1.
  ;; very similar to justification-equal?
  ;; true if r2 specializes r1
  (defun justification-subsumes? (r1 r2)
    (clrhash skhash)
    (or (eq r1 r2)
	(justification-equal-help 
	 (list (justification-antecedent r1) (justification-consequent r1))
	 (list (justification-antecedent r2) (justification-consequent r2))
	 t)))

  ;; this is not intended as a public function.
  (defun justification-equal-help (r1 r2 &optional subsume?)
    (cond ((skolem? r1) 
	   (and (skolem? r2)
		;; this ensures the skolems are used in a structurally
		;; equivalent way. the initial matching of two skolems
		;; binds them so that if sk1 ~= sk2 in the second rule 
		;; then sk1 ~/= sk3.
		(if (gethash r1 skhash)
		    ;; here's the subsumption part...
		    (or (skolem-equal? r2 (gethash r1 skhash))
			(and subsume? (eql r2 (gethash r1 skhash))))
		    (setf (gethash r1 skhash) r2))))
	  ((atom r1) (eql r1 r2))
	  (t 
	   ;; the consp here is for paranoia. we know that r1 is a cons, but
	   ;; we don't know anything about r2.
	   (and (consp r2)
		(justification-equal-help (car r1) (car r2))
		(justification-equal-help (cdr r1) (cdr r2))))))
)

;;;;;
;; clone-literal
;;
;; QUESTION: does this implementation have any advantages or disadvantages compared to 
;;           calling subst on the literal for each pairing in the map?
(defun clone-literal (lit map)
  (cond ((negated? lit)
	 (list 'not (clone-literal (second lit) map)))
	((modal-lit? lit) 
	 (list (modality lit) (gethash (modal-agent lit) map (modal-agent lit)) (clone-literal (modal-content lit) map)))
	(t
	 (cons (predicate-name lit) (mapcar #'(lambda (x) (gethash x map x)) (literal-args lit))))))

;;;;;
;; clone-justification
;;
;; creates a copy of the justification. if map is provided, replaces
;; the constants in the key field of the map with those in the value
;; field.
;;
;; r - a justification
;; map - a hash table containing substitution instructions
;; full? - indicates whether a new justification structure should be created
;; 
;; when full? is true:  returns a new justification
;; otherwise:        returns the content for a new justification
(defun clone-justification (j &optional (map (make-hash-table)) (id nil))
  (labels ((clone-help (lts)
	     (mapcar #'(lambda (x) (clone-literal x map)) lts)))
    (make-justification :id (if id id (make-justification-id))
                        :antecedent (clone-help (justification-antecedent j))
                        :consequent (clone-help (justification-consequent j))
                        :constraints (clone-help (justification-constraints j))
                        :contexts (copy-list (justification-contexts j))
                        :prior (if (and *refire-justifications*
                                        (not (equal 'JNEW (justification-id j))))
                                   j nil))))

;;; copy the internals of the justification to a new justification structure
(defun copy-justification (j)
  (make-justification 
   :antecedent (justification-antecedent j)
   :consequent (justification-consequent j)
   :constraints (justification-constraints j)
   :contexts (justification-contexts j)
   :prior (justification-prior j)))


;; consequent-literals
;;
;; j - a justification
;;
;; return the literals in the consequent of j
(defmethod consequent-literals ((j justification))
  (copy-list (justification-consequent j)))

;; antecedent-literals
;;
;; j - a justification
;;
;; return the literals in the antecedent of j
(defmethod antecedent-literals ((j justification))
  (copy-list (justification-antecedent j)))

;; if any literal in a justification is modal, then all of them must be modal.
(defun modal? (j) 
  (modal-lit? (first (antecedent-literals j))))

(defun make-agent-map (tgt src)
  (let ((map (make-hash-table)))
    (loop for k in (list-agents src) and v in (list-agents tgt) 
	  do (setf (gethash k map) v))
    map))
 
;;;;;;;
;; make-modal
;;
;; input: mblf - modal belief
;;        j    - justification *assumed to be fresh and fully skolemized
;; output: one or more modal interpretations of the rule
;;
;; there are several special cases that would lead to reasonable
;; interpretations of the creation of a modal rule. this function only
;; handles the case where j is not modal and case (1) mentioned below.
;;
;; look for the content of mblf within the rule.
;; use that to create a map between the modals in mblf and
;; the modals in the matching literal.
;; remember that some agents could be duplicated in the
;; justification or the belief, so remove duplicates, but retain the order.
;; count the number of modals
;; case (1): the number of agents in j matches the number in mblf
;;           create a direct mapping
;; case (2): the number of agents in j is larger than the number in mblf
;;           no valid match. return nil.
;; case (3): the number of agents in j is smaller than the number in mblf
;;           after replacing skolems as in case (1), append the top 
;;           (extra) agents and modals in mblf to the front of each of 
;;           the literal in the rule.
;; if there are multiple potential matches due to duplicate uses of the
;; same predicate, return multiple instances of the rule.
;;
;; normal cases: 
;;   case (1) above
;;   case (3) above
;; special cases: (none handled)
;;   nested repeated modal agents as in BaBaGbX
;;     can sometimes ignore duplicates.
;;     this is a policy decision, and we opt for the strictest case above.
;;   nested agents like BaGbBaX
;;     if this appears in j, then the modals and agents must match
;;     if this appears in mblf, then the second 'a' is a legitimate match to a skolem
(defun make-modal (mblf j)
  (if (modal? j)
      ;; the top modal agent in the rule, which must be unique, is
      ;; assigned to the modal closest to the content in mblf. the
      ;; literals are then expanded with the other modals in the
      ;; belief up to the top agent. any lower level agents are left
      ;; to be filled in by another function.
      (let ((exact-matches (filter #'(lambda (x) (modal-bindable? mblf x)) (literals j))))
	(mapcar #'(lambda (map) (clone-justification j map 'JNEW)) 
		(mapcar #'(lambda (x) (make-agent-map mblf x)) exact-matches)))

      ;; all literals get the same modals as the belief
      (list (make-justification
	     :id 'JNEW
	     :antecedent (mapcar #'(lambda (x) (add-equivalent-modals mblf x)) (justification-antecedent j))
	     :consequent (mapcar #'(lambda (x) (add-equivalent-modals mblf x)) (justification-consequent j))
	     :constraints (justification-constraints j)
	     :contexts (justification-contexts j)))))


#|
if we ever handle case 3, we'll want to use something similar to this   
(mapcar #'(lambda (x) (add-modals-and-agents upper-modals upper-agents x)) (justification-antecedent newj)) 
|#
