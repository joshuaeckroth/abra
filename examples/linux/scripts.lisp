
(defvar *cases* nil)

(defun test-ng (steps &optional (pb #'pick-belief-fewrules-unattached))
  (test-one steps *evidence* *rules* pb))

(defun inc-test-ng (steps &optional (plot? nil) (pb #'pick-belief-fewrules-unattached))
  ;; not a good idea to split in this rule set.
  (inc-test-one steps *evidence* *rules* plot? pb))

(defun test-all-exp-cases (steps &optional (pb #'pick-belief-fewrules-unattached) (print? nil))
  (test-exp-cases steps *cases* *rules* pb nil print?))

(defun test-linux (repetitions)
  (format t "PickBelief,Steps,Precision,Recall,PartialAccuracy~%")
  (dolist (pb '("pick-belief-random" "pick-belief-fewrules-unattached" "pick-belief-recency-unattached"))
    (dolist (steps '(100 250 500 1000 1500 2000))
      (loop for i from 1 to repetitions
         do (clearmem)
           (load-problem "linux/scripts")
           (load-problem "linux/kb")
           (load-problem "linux/evidence")
           (load-problem "linux/cases")
           (destructuring-bind (prec recall gt-pm-overall)
               (test-all-exp-cases steps (symbol-function (find-symbol (string-upcase pb) :abra)))
             (format t "~A,~A,~A,~A,~A~%" pb steps prec recall gt-pm-overall))))))
