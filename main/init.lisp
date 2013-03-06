(in-package :abra)

;; when true, candidates will be filtered so that they respect temporal constraints.
;; the filter is turned on when the temporal-filter code is loaded.
(defvar *temporal-filter* nil)


(defconstant +system-name+ 'icarus)

(defvar wm)
(defvar kb)

(defun initialize ()
  (reset-skolem-id)
  (reset-belief-id)
  (reset-justification-id)
  (reset-world-id)
  (reset-agent-id)

  (setf kb (create-kb))
  (setf wm (make-wm)))

(defun test-one-init (rules example)
  (initialize)
  (dolist (r rules) (store-rule r kb))
  (add-facts example (wm-prime wm) wm)
  ;; (output-dot wm :show-worlds? nil)
)

(defun test-one-print ()
  (print-agent (wm-prime wm)))

(defun test-one (steps example rules &optional (pb #'pick-belief-fewrules-unattached) (d? nil) (print? t))
  (test-one-init rules example)
  (dotimes (i steps) (infer wm kb
			    :bc-only? nil
			    :focused? nil :p -1
			    :pick-belief pb
			    :deduction? d?))
  (when print? (test-one-print)))

(defun inc-test-one (steps example rules &optional (plot? nil) (pb #'pick-belief-fewrules-unattached) (d? nil))
  (test-one-init rules (list (first example)))
  (dotimes (i steps) (infer wm kb :bc-only? nil
			    :focused? nil :p -1
			    :pick-belief pb
			    :deduction? d?))
  
  (dolist (f (rest example))
    (add-facts (list f) (wm-prime wm) wm)
    (dotimes (i steps) (infer wm kb :bc-only? nil
			    :focused? nil :p -1
			    :pick-belief pb
			    :deduction? d?))
    (when plot?
      (output-dot wm)
      (sleep 1))))

(defun continue-one (steps facts &optional (pb #'pick-belief-fewrules-unattached) (d? nil))
  (add-facts facts (wm-prime wm) wm)
  (dotimes (i steps) (infer wm kb 
			    :bc-only? nil
			    :focused? nil
			    :p -1 
			    :pick-belief pb
			    :deduction? d?)))

(defun next-cycle-one (blf-id &optional (d? nil))
  (labels ((pb (a b &key world)
	     (declare (ignore a b world))
	     (find blf-id (get-agent-beliefs (wm-prime wm)) 
		   :key #'(lambda (x) (belief-id (second x))))))
    (infer wm kb 
	   :bc-only? nil
	   :focused? nil
	   :p -1 
	   :pick-belief #'pb
	   :deduction? d?))
  (test-one-print))

