;;;; Created on 2011-03-26 10:55:37

(in-package :tutil)

(import 'unify:variable-p)

(defun fire-rules (state rules &optional (rule-headfn #'car)(rule-bodyfn #'cdr))
  "returns a new state which is deductive closure of the input state. rule= (head body*)"
  
  (let ((nstate state) ; new state
        (oldl (length state)) ; old length 
        (newl 0))             ; new length
    
    
    (loop 
     
     (if (equal oldl newl)  (return nstate))
     ; apply all rules once
     (mapcar (lambda (rule)
               (let ((head (funcall rule-headfn rule))
                     (body (funcall rule-bodyfn rule)))
                 
                 (setf nstate 
                       (union nstate 
                              (fire-rule head body nstate)
                              :test #'equal))
;               (format t "nstate ~s~%" nstate)
;               (format t "head: ~s~%" head)
;               (format t "body: ~s~%" body)
               
               ))
             rules)
          
     (setf oldl newl)
     (setf newl (length nstate)))))




; *****************************
; collect-vars(tree)
; *****************************

(defun collect-vars (tree)
  (let ((vars nil))
    (mapc-tree  
     (lambda (ITEM)
       (when (variable-p ITEM)
         (setf vars (adjoin ITEM vars))))
     tree)
    vars))


; *****************************
; match-state (lit state)
; *****************************
; lit is a literal and state is a list of literals
; match-state returns the first matching literal. It doesn't backtrack.

(defun match-state (lit state &optional (bindings no-bindings))
  "match lit against state. Returns first instantantiated lit"
  
  (let ((mlit (car (member lit state :test
                           (lambda (X Y) (unify X Y bindings))))))
    (if (null mlit)
        nil
        (subst-bindings (unify lit mlit) lit ))))



(defun unify-all (list1 list2 &optional (bindings no-bindings))
  (cond ((null list1) 
         bindings)
    ((listp list1)
     (unify (cdr list1) (cdr list2) 
            ; get bindings from unification of the first elements
            (unify (car list1) (car list2) bindings)))))


; *****************************
; fire-rule
; *****************************


(defun fire-rule  (head body conds)
  
  "Unifies the body of a rule against a set of conditions. Returns head of the rule"
  
  (let* ((bindings-list (match-conditions body conds)))
    
    (mapcar 
     (lambda (bindings)
       (subst-bindings bindings head))
     bindings-list)))   

; *****************************
; match-conditions (conds state bindings) --> newbindings
; *****************************
; currently it calculates all matches
; we could have a version that calculates the first one 
; or a random one

;(defun test-match-conditions
;  (match-conditions '((p ?x)(q ?x ?y)(r ?y)) 
;                    '((p 1)(p 2) (q 1 a)(q 1 b)(q 1 c)(q 2 d)(q 2 e) (r e) (r c))
;                    ))

(defun match-conditions (conds state &optional (bindings no-bindings))
  (if (not bindings) (setf bindings unify::no-bindings))
  "return list of bindings that match conds to state. return nil if no match"
  (if (null conds)
      (list bindings)
      (mapcan (lambda (BINDING-AFTER-FIRST)
                (match-conditions (cdr conds) state BINDING-AFTER-FIRST))
              ; generate list of bindings that match with the first one              
              
              (match-condition (car conds) state bindings)
              ; set of bindings for the first one
              )))

(defun match-condition (cond state &optional (bindings no-bindings))
  "return list of bindings that match cond to state. return nil if no match"
  (mapcan (lambda (STATELIT)
            (let ((matchingbindings (unify cond STATELIT bindings)))
              (if (null matchingbindings)
                  nil
                  (list matchingbindings)
                  ; must be list of bindings because we are mapcanning them
                  )))
          state))

; *****************************
;;;; <VARIABLIZATION>
; *****************************

; this is a hacky way of variablizing a list of condition lists. 
; basically, replace each symbol with a gensym variable. 
; this should be replaced with a unification based scheme. 

(defvar deground-db* nil)
(defvar deground-counter* 0)

(defun deground-reset ()
  (setf deground-db* nil)
  (setf deground-counter* 0))

(defun deground-conds-list (CondsList)
  (mapcar #'deground-conds CondsList))

(defun deground-conds (Conds)
  (mapcar #'deground-cond Conds))

(defun deground-cond (Cond)
  (cons (car Cond)
        (mapcar #'deground-arg (cdr Cond))))

(defun deground-arg (Arg)
  (let ((var (cdr (assoc Arg deground-db*))))
    
    (when (null var)
      (incf deground-counter*)
      (setf var 
            (intern (concatenate 
                     'string
                     "?X"
                     (write-to-string deground-counter*))))
      (push (cons Arg var) deground-db*))
    
    ; RETURN
    var))

; *****************************
;;;;<FRESHENING VARIABLES>
; *****************************

(defvar fresh-counter* 0)
(defvar fresh-bindings-db* no-bindings)

(defun fresh-reset ()
  (setf fresh-counter* 0)
  (setf fresh-bindings-db* no-bindings))

(defun fresh (tree &optional (varstr "?X"))
  (mapcar-tree (lambda (X) (fresh-item X varstr))
               tree))

(defun fresh-item(item &optional (varstr "?X"))
  (when (variable-p item)
    ; add a binding for item if none exists
    (when (null (assoc item fresh-bindings-db*))
      (push (cons item (intern (fresh-newvar varstr)))
            fresh-bindings-db*)))
  
  (subst-bindings fresh-bindings-db* item ))

(defun fresh-newvar (rootStr)
  (incf fresh-counter*)
  (concatenate 'string rootStr 
               ( write-to-string fresh-counter*)))
