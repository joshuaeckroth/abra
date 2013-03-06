(in-package :abra)

;;;; RULES
;;
;; Rules encode the system's knowledge. They are represented as
;; if--then relationships where the antecedent is a conjunction of
;; positive or negative literals and the consequent takes the same
;; form. Example:
;;    (=> (AND (p1 ?x ?y) (p2 ?y ?z)) (AND (p3 ?x) (p3 ?z)))

(defstruct rule
  antecedent  ;; list - implied conjunction of literals
  consequent  ;; list - implied conjunction of literals
  constraints ;; list
  contexts    ;; list
)

(defun rule-as-list (rule)
        "converts a rule structure to list. (apply #'make-rule \
         (rule-as-list (make-rule))) == (make-rule) "
        ; there may be a more general way of doing this for all structures but I don't know how.
  (list
   :antecedent (rule-antecedent rule)
   :consequent (rule-consequent rule)
   :constraints (rule-constraints rule)
   :contexts (rule-contexts rule)))

;; maprules
;;
;; fn -- function
;; rules -- list of rules
;;
;; maps fn to each field in each element of rules
(defun maprules (fn rules)
  (mapcar #'(lambda (rule) (maprule fn rule))
	  rules))

;; maprule
;;
;; fn -- function
;; rl -- rule
;;
;; maps fn to each field in rl and returns a modified rule.
;; fn side effects will damage rl.
(defun maprule (fn rl)
  "maps each rule field, to (fn field)"
  (make-rule :antecedent  (funcall fn (rule-antecedent rl))
	     :consequent  (funcall fn (rule-consequent rl))
	     :constraints (funcall fn (rule-constraints rl))
	     :contexts    (funcall fn (rule-contexts rl))))

;; literals
;; 
;; r -- rule
;;
;; returns all the literals in a rule
(defmethod literals ((r rule))
  (copy-list (append (rule-antecedent r) (rule-consequent r))))

;; consequent-literals
;;
;; r - a rule
;;
;; return the literals in the consequent of rl
(defmethod consequent-literals ((r rule))
  (copy-list (rule-consequent r)))

;; antecedent-literals
;;
;; r - a rule
;;
;; return the literals in the antecedent of rl
(defmethod antecedent-literals ((r rule))
  (copy-list (rule-antecedent r)))

;; modal-rule?
;;
;; rl -- rule
;;
;; true when the rule contains at least one modal literal. generally,
;; a modal rule will contain only modal literals, so this should be
;; fairly quick to evaluate.
(defun modal-rule? (rl)
  (and (find-if #'modal-lit? (literals rl))))