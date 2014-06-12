(in-package :abra)

;;;;<1. Parameters and Variables>
(defvar *current-problem*)
(defvar *examples-folder*)
(defvar *rules* nil)
        ; set of conjunctions the state should not violate.
(defvar *constraints* nil)
(defvar *integrity-constraints* nil)
(defvar *evidence* nil)

(defun clearmem ()
  (setf *rules* nil)
  (setf *constraints* nil)
  (setf *integrity-constraints* nil)
  (setf *evidence* nil)
  (setf *groundtruth* nil))


;;;;<2. Paths>

(defun load-problem (problem)
  (setf *current-problem* problem)
  (tutil:replace-file (file-component-log) (format t "Starting Component Log...~%"))
  (tutil:replace-file (file-constraints-log) (format t "Starting Constraints Log...~%"))
  (load-kb problem))

(defun file-problem (&optional (problem *current-problem*))
    (merge-pathnames (pathname (concatenate  'string problem ".lisp")) 
                     (pathname *examples-folder*)))

(defun folder-problem (&optional (problem *current-problem*))
       (make-pathname :directory (pathname-directory (file-problem problem))))

(defun file-constraints-log (&optional (problem *current-problem*))
   (merge-pathnames (pathname "constraints.log") (folder-problem problem)))

(defun file-component-log (&optional (problem *current-problem*))
   (merge-pathnames (pathname "component.log") (folder-problem problem)))

; TODO: broken?
(defun file-problem-internal(&optional (problem *current-problem*))
  (make-pathname 
   :directory *examples-folder*
   :name (concatenate 'string problem "-internal")
   :type "lisp"))

; TODO: broken?
(defun file-problem-output (&optional (problem *current-problem*))
  (make-pathname 
   :directory *examples-folder*
   :name problem
   :type "output"))


;;;;<3. Command Interface>


;(defun  defevidence (state)
;  (setf *evidence* 
;        (flatten-time-models state)))


(defun clear-rules ()
  (setf *rules* nil))

(defmacro defevidence (&rest facts)
  `(add-evidence (quote ,facts)))


(defmacro create-constraints (&rest rules)
  `(createconstraints (quote ,rules)))

(defmacro create-rules (&rest rules)
  (let ((grl (gensym)))
    `(dolist (,grl (quote ,rules))
       (push (apply #'make-rule ,grl) *rules*))))

(defmacro run-current (&optional (steps 100))
  `(test-one ,steps *evidence* *rules* #'pick-belief-fewrules-unattached nil))

; ============  
(defvar *current-folder* nil)

;;;;<5. Main Commands>
(defun load-kb (problem)
    (load (file-problem problem)))

(defun convert-kb (problem)
  (load-kb problem)
  (tutil:replace-file (file-problem-internal problem)
                      (write-internal-problem)))

(defun run-problem (problem &optional (steps 100))
  (load (file-problem problem))
  
  (tutil:replace-file (file-problem-internal problem) 
                      (write-internal-problem))
  (run-current steps))



(defun logrun (problem)
  (load (file-problem problem))
  
  (tutil:to-file 
   (file-problem-output problem) 
   (eval (macroexpand '(run-current)))))



;;;;<4. Rest>


(defun add-evidence (facts)                   
  (dolist (fact facts) 
    (push fact *evidence*)))

; TODO: add memberchk
; flatten-time-models 

(defun  createconstraints (rules)
  (dolist (rule rules) (createconstraint rule)))

;(defvar tmprule)
(defun createconstraint (rule1)
  
  (let ((rule (get-int-rule rule1)))
    
    
       (if (equal (rule-consequent rule) nil) ; cond -> nil
        (push (rule-antecedent rule) *integrity-constraints*)
          
        (push rule *constraints*))))


(defun write-internal-problem ()
  (format t "(setf *rules* (quote ~A))~%~%" *rules*)
  (format t "(setf *evidence* (quote ~A))~%~%" *evidence*)
  (format t "~A~%" (macroexpand '(run-current))))


