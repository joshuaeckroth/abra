(clearmem)

(create-rules 
(:consequent ((PROJECT ?PROJECT))
 :antecedent ((MEMBER-OF ?PERSON1 ?PROJECT) (PAID-FROM ?PERSON1 ?PROJECT)
              (AT-MEETINGS ?PERSON1 ?MEETING)))

(:consequent ((HAS-FLU ?PERSON))
 :antecedent ((HAS-SYMPTOM ?PERSON ?S1) (FEVER ?S1)
              (HAS-SYMPTOM ?PERSON ?S2) (COUGH ?S2)))

(:consequent ((HAS-FOOD-POISONING ?PERSON))
 :antecedent ((HAS-SYMPTOM ?PERSON ?S1) (FEVER ?S1)
              (HAS-SYMPTOM ?PERSON ?S2) (VOMITING ?S2)))

(:consequent ((HAS-LUNG-CANCER ?PERSON))
 :antecedent ((HAS-SYMPTOM ?PERSON ?S1) (COUGH ?S1)
              (HAS-SYMPTOM ?PERSON ?S2) (YELLOW-TEETH ?S2)))

(:consequent ((CAUGHT-FLU ?PERSON1 ?PERSON2))
 :antecedent ((AT-MEETINGS ?PERSON1 ?PROJECT)
              (AT-MEETINGS ?PERSON2 ?PROJECT) (HAS-FLU ?PERSON1)
              (HAS-FLU ?PERSON2))))

(defevidence 
(member-of Abe muri-project)
(member-of Bob muri-project)
(has-symptom Abe s1)
(fever s1)
(has-symptom Bob s2)
(cough s2))

(defun test-flu (steps &optional (pb #'pick-belief-fewrules-unattached))
  (test-one steps *evidence* *rules* pb))

(defun inc-test-flu (steps  &optional (plot? nil) (pb #'pick-belief-fewrules-unattached))
  (inc-test-one steps *evidence* *rules* plot? pb))
