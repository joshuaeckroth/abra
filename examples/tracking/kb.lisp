(create-rules

 (:antecedent
  ((mov ?x1 ?y1 ?x2 ?y2 ?time1 ?color))
  :consequent
  ((det-a ?x1 ?y1 ?time1)
   (det-b ?x2 ?y2 ?time2)
   (obj-color ?x1 ?y1 ?time1 ?color)
   (obj-color ?x2 ?y2 ?time2 ?color))
  :constraints
  ((next-time-step ?time1 ?time2)))

 (:antecedent
  ((next-time-step ?time1 ?time2))
  :consequent
  ((next-time-step ?time1 ?time2))))


