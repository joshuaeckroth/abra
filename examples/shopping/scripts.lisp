(defun test-ng (steps example sorts? &optional (pb #'pick-belief-fewrules-unattached))
  (clearmem)
  ;; not a good idea to split in this rule set.
  (setf *divide-lookahead?* nil)
  (if sorts?
      (build-shopping-rules t)
      (build-shopping-rules nil))
  (test-one steps example *rules* pb))



(defun inc-test-ng (steps example sorts? &optional (plot? nil) (pb #'pick-belief-fewrules-unattached))
  (clearmem)
  ;; not a good idea to split in this rule set.
  (setf *divide-lookahead?* nil)
  (if sorts?
      (build-shopping-rules t)
      (build-shopping-rules nil))
  (inc-test-one steps example *rules* plot? pb))

;;;;
;; (test-one 0 *e6* *shopping-rules*)
;; (next-cycle-one 'B2)
;; (next-cycle-one 'B12)
