(clearmem)

(create-rules
 (:antecedent ((p ?p) (q ?q))
  :consequent ((x ?p ?q)))

 (:antecedent ((r ?r) (s ?s))
  :consequent ((y ?r ?s)))

 (:antecedent ((x ?x1 ?x2) (y ?y1 ?y2))
  :consequent ((z ?x1 ?y1)))

 (:antecedent ((x ?x1 ?x2) (y ?y1 ?y2))
  :consequent ((w ?x1 ?y1))))

(defevidence (p p1) (q q1) (r r1) (s s1))


(defun test-sm (steps &optional (pb #'pick-belief-fewrules-unattached) (deduction? nil))
  (test-one steps *evidence* *rules* pb deduction?))

(defun inc-test-med (steps  &optional (plot? nil) (pb #'pick-belief-fewrules-unattached) (deduction? nil))
  (inc-test-one steps *evidence* *rules* plot? pb deduction?))
