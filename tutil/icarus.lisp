;;;; Created on 2011-03-26 10:37:34
;; splitting from tutil

(in-package :tutil)

(defmacro defconcept (&rest concept)
  `(create-concepts ,concept))

(defmacro defskill (&rest concept)
  `(create-skills ,concept))


(defun unify-concepts (inconcept1 inconcept2 &optional (inbindings no-bindings))
  (let* ((bindings inbindings)
         (concept1 (copy-concept inconcept1))
         (concept2 (copy-concept inconcept2))
         (subconcepts1 (concept-relations concept1))
         (subconcepts2 (concept-relations concept2)))
    ; unify heads
    (setf bindings 
          (unify (concept-head concept1) (concept-head concept2) bindings))
    ; FAIL if the sizes are different
    (when (or (not (eq (length subconcepts1) 
                       (length subconcepts2))))
      (setf bindings nil))
    ; start comparing start conditions
    (when (and (not (null bindings))
               (not (null subconcepts1)) 
               (not (null subconcepts2)))
      ;unify start conditions
      (setf bindings (match-conditions subconcepts1 subconcepts2 bindings)));))
    bindings))
; WARNING: unify-sclauses doesn't detect equivalence of primitive skills

(defun unify-sclauses (inskill1 inskill2 &optional (inbindings no-bindings))
  (let* ((bindings inbindings)
         (skill1 (fresh-sclause (copy-sclause inskill1) "?x"))
         (skill2 (fresh-sclause  (copy-sclause inskill2) "?y"))
         (start1 (sclause-start skill1))
         (start2 (sclause-start skill2))
         (subgoals1 (sclause-subgoals skill1))
         (subgoals2 (sclause-subgoals skill2))
         (actions1 (sclause-subgoals skill1))
         (actions2 (sclause-subgoals skill2)))
    
    (when (or (null actions1)(null actions2))
      ; UNIMPLEMENTED FEATURE: 
      ; don't detect the equivalence if one of them is primitive.
      (setf bindings nil))
    
    (setf bindings 
          (unify (sclause-head skill1) (sclause-head skill2) bindings))
    
    ; FAIL if the sizes are different
    (when (or (not (eq (length subgoals1) 
                       (length subgoals2)))
              (not (eq (length start1) 
                       (length start2))))
      (setf bindings nil))
    ; start comparing subgoals
    (when (and (not (null bindings))
               (not (null subgoals1)) 
               (not (null subgoals2)))
      ;(step (progn 
      ; unify subgoals
      ; (step (progn 
      (setf bindings
            (mapcar (lambda (a b) (unify a b bindings)) 
                    subgoals1 subgoals2 ))
      ; merge subgoal bindings
      (if (member nil bindings)
          (setf bindings nil)
          (setf bindings 
                (mapcan (lambda (X) X)  bindings)))    
      
      ; start comparing start conditions
      (when (and (not (null bindings))
                 (not (null start1)) 
                 (not (null start2)))
        ;unify start conditions  
        (setf bindings (match-conditions start1 start2 bindings)));))
      
      (when (not (null bindings))
        (terpri)
        (write-string "equivalent:")
        (terpri)
        (terpri)
        (write (sclause-id inskill1))(write": ")(write (sclause-head inskill1))
        (write (sclause-id inskill2))(write": ")(write (sclause-head inskill2))
        (terpri)
        (write skill1)
        (terpri)
        (write skill2)
        (terpri)
        (terpri))
      
      bindings)))

(defun find-cclauses (goal &optional (cclauses cltm*))
  "returns a concept clause matching the goal head. Uses unification but might not work 
because it doesn't fresh the clause variables"
  (mapcan (lambda (CCLAUSE) 
            (if (unify (concept-head CCLAUSE) goal)
                (list CCLAUSE)
                nil))
          cclauses))

(defun find-csubgoals (goal &optional (state nil) (cclauses cltm*))
  (declare (ignore state))
  "returns subgoals of a goal, given a goal instance. The bindings between the instance and subgoals are applied to the subgoals. It uses unification but might not work with goal variables since the goal clauses are not freshened. Subgoals are instantiated "
  (mapcar  
   (lambda (CCLAUSE)
     (subst-bindings  
      (unify (concept-head CCLAUSE) goal)
      (concept-relations CCLAUSE)))        
   (find-cclauses goal cclauses)))

(defun collect-vars-sclauses (sclauses)
  
  (reduce #'union 
          (mapcar #'collect-vars-sclause sclauses)))

(defun collect-vars-sclause (sclause)
  (let ((vars nil))
    (funcall-sclause-conds 
     (lambda(COND)
       (dolist (var (collect-vars COND))
         (setf vars
               (adjoin var vars))))
     sclause)
    vars))

(defun subst-bindings-sclauses (bindings sclauses)
  (mapcar
   (lambda (SCLAUSE) (subst-bindings-sclause bindings SCLAUSE))
   sclauses))

(defun subst-bindings-sclause (bindings sclause)
  (mapslot-sclause
   (lambda (FIELD) (subst-bindings bindings FIELD)) sclause))

(defun mapslot-sclause (func &rest sclauses)
  "creates new sclause such that slot <-- (func sclause1-slot sclause2-slot ...)"
  ; can this be written for an arbitrary structure.
  ; the clause is initialized with the first sclause on the list
  
  (let ((new (copy-sclause (car sclauses))))
    (setf (sclause-start new)
          (apply func (mapcar #'sclause-start sclauses)))
    (setf (sclause-head new)
          (apply func (mapcar #'sclause-head sclauses)))
    (setf (sclause-subgoals new)
          (apply func (mapcar #'sclause-subgoals sclauses)))
    (setf (sclause-actions new)
          (apply func (mapcar #'sclause-actions sclauses)))
    (setf (sclause-requires new)
          (apply func (mapcar #'sclause-requires sclauses)))
    (setf (sclause-effects new)
          (apply func (mapcar #'sclause-effects sclauses)))
    (setf (sclause-percepts new)
          (apply func (mapcar #'sclause-percepts sclauses)))
    
    ; return
    new))


(defun funcall-sclause-conds(func sclause)
  "applies func on the logical fields of sclause"
  (funcall func (sclause-start sclause))
  (funcall func (sclause-head sclause))
  (funcall func (sclause-subgoals sclause))
  (funcall func (sclause-actions sclause))
  (funcall func (sclause-requires sclause))
  (funcall func (sclause-effects sclause))
  (funcall func (sclause-percepts sclause)))





#|  
(defun test-unify-sclauses ()
(setf sltm* nil)

(create-skills 
((p ?x ?y)

:start ((a ?x)(b ?y)(s ?x ?y))
:subgoals ((c ?x)(d ?z)))

((p ?a ?b)
:start ((b ?b)  (a ?a) (s ?a ?b))
:subgoals ((c ?a) (d ?s))))

(unify-sclauses (first sltm*) (second sltm*)))
|#


; WARNING: unify-concepts is quickly adapted from  unify-sclauses but it has not been tested yet.


(defun fresh-sclauses (sclauses &optional (varstr "?X"))
  (fresh-reset)
  (mapcar (lambda (CLAUSE)
            (fresh-sclause CLAUSE varstr))
          sclauses))

(defun fresh-sclause (inskill &optional (varstr "?X"))
  
  (let ((sclause 
         (copy-sclause inskill)))
    (setf fresh-bindings-db* no-bindings)
    (setf (sclause-start sclause) (fresh (sclause-start sclause) varstr))
    (setf (sclause-head sclause) (fresh (sclause-head sclause) varstr))
    (setf (sclause-subgoals sclause) (fresh (sclause-subgoals sclause) varstr))
    (setf (sclause-requires sclause) (fresh (sclause-requires sclause) varstr))
    (setf (sclause-actions sclause) (fresh (sclause-actions sclause) varstr))
    
    ;(mapslot-sclause 
    ;  (lambda (SLOT) (fresh SLOT varstr))
    ;  sclause)
    sclause))
