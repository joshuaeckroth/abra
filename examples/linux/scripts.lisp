
(defvar *cases* nil)

(defun test-ng (steps &optional (pb #'pick-belief-fewrules-unattached))
  (test-one steps *evidence* *rules* pb))

(defun inc-test-ng (steps &optional (plot? nil) (pb #'pick-belief-fewrules-unattached))
  ;; not a good idea to split in this rule set.
  (inc-test-one steps *evidence* *rules* plot? pb))

(defun test-all-exp-cases (steps &optional (pb #'pick-belief-fewrules-unattached) (print? nil))
  (test-exp-cases steps *cases* *rules* pb nil print?))

