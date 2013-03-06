(clearmem)

(create-rules
 (:antecedent ((belief ?a1 (x ?p)))
  :consequent ((goal ?a1 (y ?p))))

 (:antecedent ((goal ?a1 (y ?p)))
  :consequent ((goal ?a1 (z1 ?p)) (goal ?a1 (z2 ?p))))

 (:antecedent ((belief ?a1 (belief ?a2 (z2 ?p))))
  :consequent ((goal ?a1 (z1 ?p))))

 (:antecedent ((belief ?a1 (x ?p)))
  :consequent ((belief ?a1 (belief ?a2 (not (x ?p)))))))

(defevidence (x arg))


(defun test-sm (steps &optional (pb #'pick-belief-fewrules-unattached) (deduction? nil))
  (test-one steps *evidence* *rules* pb deduction?))

(defun inc-test-med (steps  &optional (plot? nil) (pb #'pick-belief-fewrules-unattached) (deduction? nil))
  (inc-test-one steps *evidence* *rules* plot? pb deduction?))
