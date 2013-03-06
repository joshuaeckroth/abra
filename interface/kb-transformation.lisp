(in-package :abra)

;;;; Created on 2011-05-25 15:42:13

(defvar *flatten-bgi-translate-simple-name* nil)

(defvar *modal-shortcuts*
  (if *flatten-bgi-translate-simple-name*
      (setf *modal-shortcuts*  
            '((intention . /I) 
              (goal . /G)
              (believes . /B)
              (^i . /I) 
              (^g . /G)
              (^b . /B)
              (*states . *S)
              (*requests . *R)
              (*queries . *Q)))
      
      (setf *modal-shortcuts*  
            '((intention . "I.") 
              (goal . "G.")
              (believes . "B.")
              (^i . "I.") 
              (^g . "G.")
              (^b . "B.")
              (*states . "*S.")
              (*requests . "*R.")
              (*queries . "*Q.")))))

      
(defun deduce-from-evidence (&optional (evidence *evidence*) (rules *rules*))
  "deductive closure of rules from evidence. assumes single head"
   (tutil:fire-rules evidence rules 
               (lambda (rule)  (car (rule-consequent rule))) 
               #'rule-antecedent))

;i.e. (intention ?agent (P)) --> (i-P ?agent)

(defun expand-evidence-deductive ()
  (setf *evidence* (deduce-from-evidence)))

(defun expand-all-rule-heads ()
  (setf *rules* 
        (mapcan (lambda (rule)
                  (rule-consequent rule)
                  (expand-heads-rule rule))
                *rules*)))

(defun expand-heads-rule (rule)
        (mapcar (lambda (head)
                  (let ((newrule (copy-rule rule)))
                    
                    
                    (setf (rule-consequent newrule) 
                          (list head))
                    
                    newrule))
                (rule-consequent rule)))
                  
                  
  
  

(defun flatten-bgi ()
  
  
  
  (setf *rules* (maprules #'flatten-bgi-translate *rules*))
  (setf *evidence* (flatten-bgi-translate *evidence*))
  (setf *integrity-constraints* (flatten-bgi-translate *integrity-constraints*))
  
  ;TODO: flatten constraints?
)

        
     
     
(defun flatten-bgi-translate (input)
  ; Does not flattens negations yet.
  (if (listp input)
      
      (let* ((input-head (car input))
             (mode (cdr (assoc input-head *modal-shortcuts*)))
             (pred nil)
             (args (butlast (cdr input))))
        
        ; if input root is a node definition
        (if mode     
            (progn
              (setf pred (flatten-bgi-translate (car (last input)))) 
              
              (if *flatten-bgi-translate-simple-name*
                  (append (list (car pred)) 
                     ;     (list mode) 
                          (cond
                            ((equal (length args) 2)
                             (list (first args) mode (second args)))
                            
                            ((equal (length args) 1)
                             (list  (first args) mode))
                            
                            (t (list mode '< args '>)))
                          
                          (cdr pred))
                  (append 
                   (list (intern 
                          (concatenate 'string
                                       mode
                                       (symbol-name (car pred)))))
                   args
                   (cdr pred))))
            
            ; if input is another list
            (mapcar #'flatten-bgi-translate input)))
      
      ; If not a list
      input))

(defun expand-kb-templates (var values)
      ; converts rules and constraints to lists first, proccesses them as lists,
      ; and converts them back to rule structures.
  
  (setf *rules* (expand-rule-templates var values *rules*))
      
  (setf *constraints* (expand-rule-templates var values *constraints*))
   
  (setf *integrity-constraints* 
        (expand-templates var values *integrity-constraints*))
  (setf *evidence* 
        (expand-templates var values *evidence*)))


(defun  expand-rule-templates (var values rules)
        (mapcar (lambda (rule-args) 
                  (apply #'make-rule rule-args))
                  
                  (expand-templates var values 
                          (mapcar #'rule-as-list rules))))

 
           
(defun expand-templates (var values structures)
  (mapcan (lambda (structure)
            (expand-template var values structure))
          structures))



(defvar *reserved-rule-words*
  '(and not => <= believes intention goal ^b ^i ^g))

(defun collect-domain-lits (tree)
  (let ((preds nil))
    
    (tutil:traverse-tree 
     
     (lambda (x)
       (when (and (listp x)
                  (not (listp (car x)))
                  (not (member (car x) *reserved-rule-words*))
                  (not (equal (length (cdr x)) 0)))
              (push (cons(car x)
                         (generic-args (length (cdr x))))
                    preds)
                ;(format t "~a <- ~a ~%" (car x) x)
         ))
     tree)
    (tutil:list-to-set preds)))

;;;;<Util> 
(defun generic-args (n)
  (let ((args nil))
    (loop for i from 1 to n do 
          (push (intern (format nil "?~a" i)) args))
    
    (reverse args)))
  
  
(defun expand-template (var values structure)  
  (tutil:list-to-set
        (mapcan (lambda (value)
            (list (tutil:substitute-tree value var structure)))
          values)))


;;;;<Broken>
(defun flatten-time-models (literals)
  (mapcar #'flatten-time-model literals))

; flatten-time-model


(defun flatten-time-model (literal)
  (if (symbolp literal)
      literal   
      (if (eq (first literal) 'time)
          (let* ((content (second literal))
                 (t1 (third literal))
                 (t2 (fourth literal))
                 (contentname (car content)))
            
            ; if time modal
            (if (eq contentname 'not)
                ; if negation
                (let* ((pred (second content))
                       (predname (car pred))
                       (args (cdr pred)))
                  (list 'not (list* predname t1 t2 args)))
                
                ; if no negation
                (list* (car content) t1 t2 (cdr content))))
          
          ; if not time modal
          literal)))
