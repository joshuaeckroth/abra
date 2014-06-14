(in-package :abra)

;; when true, candidates will be filtered so that they respect temporal constraints.
;; the filter is turned on when the temporal-filter code is loaded.
(defvar *temporal-filter* nil)


(defconstant +system-name+ 'icarus)

(defvar wm)
(defvar kb)

(defvar *groundtruth* nil)

(defmacro deftruth (&rest facts)
  `(dolist (fact (quote ,facts))
     (push fact *groundtruth*)))

(defstruct (exp-case (:conc-name exp-case-))
  (groundtruth nil)
  (evidence nil))

(defun initialize ()
  (reset-skolem-id)
  (reset-belief-id)
  (reset-justification-id)
  (reset-world-id)
  (reset-agent-id)

  (setf kb (create-kb))
  (setf wm (make-wm)))

(defun compute-groundtruth-matches (agent)
  (let* ((agent-beliefs (mapcar #'second (get-beliefs agent)))
         (belief-test #'(lambda (b1 b2) (equal (belief-content b1)
                                               (belief-content b2))))
         (gt-preds (remove-duplicates (mapcar #'first *groundtruth*)))
         (gt-matches (remove-duplicates
                      (filter #'(lambda (b)
                                  (and (not (fact? b agent))
                                       (member (belief-content b) *groundtruth*
                                               :test #'equal)))
                              agent-beliefs)
                      :test belief-test))
         (gt-mismatches (remove-duplicates
                         (filter #'(lambda (b)
                                     (and (not (fact? b agent))
                                          (notany #'(lambda (arg) (skolem? arg)) (rest (belief-content b)))
                                          (member (first (belief-content b)) gt-preds)
                                          (not (member (belief-content b) *groundtruth*
                                                       :test #'equal))))
                                 agent-beliefs)
                         :test belief-test))
         (tp (length gt-matches))
         (fp (length gt-mismatches))
         (fn (- (length *groundtruth*) tp))
         (prec (if (= 0 (+ tp fp)) 0.0 (float (/ tp (+ tp fp)))))
         (recall (if (= 0 (+ tp fn)) 0.0 (float (/ tp (+ tp fn))))))
    (list gt-matches tp fp fn prec recall)))

(defun test-one-init (rules example)
  (initialize)
  (dolist (r rules) (store-rule r kb))
  (add-facts example (wm-prime wm) wm)
  ;; (output-dot wm :show-worlds? t)
)

(defun test-one-print ()
  (let* ((agent (wm-prime wm))
         (supported-beliefs (mappend #'(lambda (j) (mapcar #'(lambda (b) (belief-id (second b)))
                                                           (get-supported-beliefs j (agent-beliefs agent))))
                                     (get-justifications agent))))
    (print-agent agent)
    (format t "~%~%Supported beliefs: ~A~%" supported-beliefs)
    (format t "~%Unexplained:~%")
    (dolist (b (mapcar #'second (get-beliefs agent)))
      (when (not (member (belief-id b) supported-beliefs))
        (format t "~T~A: ~A~%" (belief-id b) (belief-content b))))
    (when *groundtruth*
      (destructuring-bind (gt-matches tp fp fn prec recall) (compute-groundtruth-matches agent)
        (format t "~%~%Groundtruth: ~A~%~%" *groundtruth*)
        (format t "Groundtruth matches: (tp=~A fp=~A fn=~A prec=~A recall=~A)~%~T~A~%~%"
                tp fp fn prec recall gt-matches)))))

(defun test-one (steps example rules &optional (pb #'pick-belief-fewrules-unattached) (d? nil) (print? t))
  (test-one-init rules example)
  (dotimes (i steps) (infer wm kb
			    :bc-only? nil
			    :focused? nil :p -1
			    :pick-belief pb
			    :deduction? d?))
  (when print? (test-one-print))
  wm)

(defun test-exp-cases (steps cases rules &optional (pb #'pick-belief-fewrules-unattached) (d? nil) (print? t))
  (let ((tp-sum 0)
        (fp-sum 0)
        (fn-sum 0))
    (dolist (c cases)
      (clearmem)
      (dolist (fact (exp-case-groundtruth c))
        (push fact *groundtruth*))
      (let ((wm (test-one steps (exp-case-evidence c) rules pb d? print?)))
        (destructuring-bind (gt-matches tp fp fn prec recall)
            (compute-groundtruth-matches (wm-prime wm))
          (declare (ignore gt-matches)
                   (ignore prec)
                   (ignore recall))
          (setq tp-sum (+ tp-sum tp))
          (setq fp-sum (+ fp-sum fp))
          (setq fn-sum (+ fn-sum fn)))))
    (let ((prec (if (= 0 (+ tp-sum fp-sum)) 0.0
                    (float (/ tp-sum (+ tp-sum fp-sum)))))
          (recall (if (= 0 (+ tp-sum fn-sum)) 0.0
                      (float (/ tp-sum (+ tp-sum fn-sum))))))
      (list prec recall))))

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
