;;;; Created on 2011-04-14 12:10:57

(in-package :abra)

;;; Split skolems into constants when they violate constraints (under the assumption 
;;; that all skolems are equivalent)

; Just before a new justification j is added to the memory, 
;  if j and memory violates constraints under the assumption that all skolems
;     are equivalent.
;     detect the first constraint that fires, detect skolems that should split.
;     detect memory elements that should be split (on the lhs of the rule)



; *****************************
;;;;<Init>
; *****************************
(defvar *sconsts* nil)
(defvar *ineqs* nil)
(defvar *split-bindings* nil)
(defvar *integrity-constraints* nil)

; *****************************
;;;;<Consistency Constraints>
; *****************************

(defun filter-inconsistent-justifications-on ()
  (setf *filter-inconsistent-justifications* t))


(defun filter-inconsistent-jcandidates (cs)
  "filter inconsistent justification candidates. Nondestructive."
  
  (let ((newcs nil))
    
    (tutil:append-file 
     
     (file-constraints-log)
     
     (format t "~%~%")
     (format t "*******************************~%")
     (format t "filter-inconsistent-jcandidates~%")
     (format t "*******************************~%~%"))
    
    
    (setf newcs 
          (mapcan (lambda (c)
                    (let ((j (candidate-justification c)))
                      
                      (tutil:append-file
                       (file-constraints-log)
                       (format t "Justification: ~s ~%" j))
                      
                      
                      
                      (if (inconsistent-justification j)
                          ()
                          (list (copy-candidate c)))))
                  cs))
    
     
    (tutil:append-file  (file-constraints-log)
                        
                        (if (equal (length cs)(length newcs)) 
                            t
                            (format t "Candidate Eliminated ~%"))
                        
                        (format t "(~s) ==> ~s~%" (length cs) (length newcs))
                        (format t "*******************************~%~%")
                        )
    
    newcs))

#|
(defun filter-inconsistent-justifications (js)
(mapcan (lambda (j)     
(unless (inconsistent-justification j) (list j)))
js))
|#



(defun inconsistent-justification (j)
  (let ((state (union ;(literals j)
                      ;(jstate)
                      (justification-literals-with-sconsts j)
                      (jstate-with-sconsts))
               )) ;TODO: FIXED? shouldn't this use jstate-with-sconsts instead?
    
;    (tutil:append-file  (file-component-log)
;                        
;                       (format t "~%~%---------------------------~%")
;                        (format t "Jstate~%")
;                        
;                        (format t "~s~%" state)
;                        (format t "---------------------------~%~%"))

    (some 
     (lambda (constraint) 

       (let* ((matched-bindings (tutil:match-conditions constraint state))
              (inconsistent-instance (tutil::subst-bindings 
                                      (car matched-bindings)
                                      constraint)))
         
            (when inconsistent-instance
              ; log
              (tutil:append-file  
               (file-component-log)
              
               
               (format t "~%~%---------------------------~%")
               (format t "Jstate~%")
               (format t "~s~%" state)
               (format t "---------------------------~%~%")
                  
               (format t "~%~%---------------------------~%")
               (format t "New Justification: ~%")
               (format t "~s~%" j)
               (format t "---------------------------~%~%")
               
               (format t "~%~%Constraint Violated: ~%~%") 
               (format t "~s ~%" inconsistent-instance)    
               (format t "~%~%---------------------------~%~%"))
              t)))
          
     *integrity-constraints*)))




; *****************************
;;;;<Split Skolems>
; *****************************


(defun split-skolem (c)
  ""
  (let* ((justifications 
          (union (list (candidate-justification c)) 
                 (get-justifications (wm-prime wm))))
         (newcandidate (copy-candidate c)))
    (setf *ineqs*
          (union *ineqs* (first ; TODO: hack. not sure why
			  (justification-ineqs justifications)) :test #'equal))
    (setf *sconsts*
          (ss-sconsts *ineqs*))
    
    (setf (candidate-justification newcandidate) 
          (justification-subst-sconsts (candidate-justification c))) 
    newcandidate))

(defun justification-sconsts (j sconsts)
  (mapcan (lambda (sconst)
	    (when (equal (sconst-jid sconst) (justification-id j))
	      (list (cons (sconst-sid sconst) (sconst-id sconst)))))
	  sconsts))


(defun justification-subst-sconsts (j &optional (sconsts *sconsts*))
  "In justification j, replaces skolems with constants as in sconsts mapping"
  (let ((bindings (justification-sconsts j sconsts)))
    (destructuring-bind (ant cq cnt)
	(mapcar (lambda (item)
		  (or (item-subst (rest (assoc item bindings))) item))
		(justification-content j))
      (make-justification :antecedent ant
			  :consequent cq
			  :constraints cnt
			  :contexts (copy-list (justification-contexts j))))))

(defun ss-sconsts (ineqs)
  (mapcan (lambda (x)
	    (when (and (sconst? (second x)) (sconst? (third x))) 
	      (list (second x) (third x))))
	  ineqs))

(defun split-skolem-on ()
  (setf *split-skolem-hook* t))


;TODO: undefined collect-literals
(defun justification-ineqs (justifications)
  (let* ((jstate (jstate  justifications))
         (constraint (first *constraints*))
         (head (collect-literals (third constraint)))
         (body (collect-literals (second constraint))))
    ; TODO: hack. I use only the first constraints
    (tutil:fire-rule  head body jstate)))


(defun sconst-symbol-if-skolem (item jid)
  (if (skolem? item)
      (sconst-id (make-sconst jid item))
      item))


;; Defines a Skolem constant as a specific type.
(defstruct ( sconst
            (:constructor make-sconst (jid sid))         
            (:predicate sconst?)
            (:type list) :named)
  sid 
  jid
  (id (symb 'sconst '- jid '- sid)))


;(defun sconst? (sconst)
;  (equal (car sconst) 'sconst))


(defun get-state ()
  (let ((observations 
         (mapcar #'second (get-observed-beliefs (wm-prime wm))))
        (beliefs
         (mapcar #'second (get-local-beliefs (wm-prime wm))))
        (goals
         (mapcar #'second (get-goals (wm-prime wm))))
        (intentions
         (mapcar #'second (get-intentions (wm-prime wm))))
        (justifications 
         (get-justifications (wm-prime wm))))
    
    (list observations beliefs goals intentions justifications)))


(defun system-constant (sk jid)
  "creates a system constant from a skolem sk and justification id jid"
  (intern 
   (concatenate 'string 
                "SCONST-"
                (symbol-name jid)
                "-"
                (symbol-name (sk-id sk)))))


; *****************************
;;;;<Util>
; *****************************


(defun jstate (&optional (js (get-justifications (wm-prime wm))))
  (let* ((jstate 
          (mapcan #'literals js)))
    
    ;(format t "~%Jstate: ~%~%~a~%~%" jstate)    
    ;(format t "~%Constraints: ~%~%~a~%~%" *constraints*)
    
    (append *evidence* jstate)
    ; TODO: this is hacky because Will's code may not be using *evidence* variable
    ; use observation structure instead. 
    ))

(defun jstate-with-sconsts (&optional (js (get-justifications (wm-prime wm))))
  (let* ((jstate 
          (mapcan #'justification-literals-with-sconsts js)))
    
    ;(format t "~%Jstate: ~%~%~a~%~%" jstate)    
    ;(format t "~%Constraints: ~%~%~a~%~%" *constraints*)
    
    (append *evidence* jstate)
    ; TODO: this is hacky because Will's code may not be using *evidence* variable
    ; use observation structure instead. 
    ))

(defun justification-literals-with-sconsts (justification)
  
"replaces local skolem constants with unique functions"
  
  
  ;TODO: bug. Shouldn't create structure if not in split mode
  (tutil:mapcar-tree
   (lambda (item)
     (sconst-symbol-if-skolem item (justification-id justification)))
   (literals justification)))

(defun  pprintj ()
  ""
  ; TODO: hack. this substitution should happen in all cycles
  (mapcar (lambda (j) 
            (justification-subst-sconsts j))
          
          (get-justifications (wm-prime wm))))


