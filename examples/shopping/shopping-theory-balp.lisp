(defun build-shopping-rules (sorts?)
  (create-rules 

   (:antecedent ((plan-shopping ?s ?person1 ?thing1 ?place1))
    :consequent ((smarket-shopping ?s) (shopper ?s ?person1) (thing-shopped-for ?s ?thing1) 
				       (store ?s ?place1)))

   (:antecedent ((plan-shopping ?s ?person1 ?thing1 ?place1))
    :consequent ((liqst-shopping ?s) (shopper ?s ?person1) (thing-shopped-for ?s ?thing1) 
				     (store ?s ?place1)))

   (:antecedent ((plan-shopping ?s ?person1 ?thing1 ?place1))
    :consequent ((shopping ?s) (shopper ?s ?person1) (thing-shopped-for ?s ?thing1) 
			       (store ?s ?place1)))

   (:antecedent ((plan-robbing ?r ?person1 ?place1 ?victim1 ?weapon1 ?thing1))
    :consequent	((robbing ?r) (robber ?r ?person1) (place-rob ?r ?place1)
			      (victim-rob ?r ?victim1)
			      (weapon-rob ?r ?weapon1)
			      (thing-robbed ?r ?thing1)))

   (:antecedent ((plan-air-travel ?p ?person1 ?luggage1 ?place1 ?tkt1 ?plane1))
    :consequent ((going-by-plane ?p) (goer ?p ?person1) (plane-luggage ?p ?luggage1)
				     (source-go ?p ?place1)
				     (plane-ticket ?p ?tkt1)
				     (vehicle ?p ?plane1)))

   (:antecedent ((plan-bus-travel ?b ?person1 ?bus1 ?source1 ?dest1 ?driver1 ?tkn1))
    :consequent	((going-by-bus ?b) (goer ?b ?person1) (vehicle ?b ?bus1)
				   (source-go ?b ?source1)
				   (dest-go ?b ?dest1)
				   (bus-driver ?b ?driver1)
				   (token ?b ?tkn1)))

   (:antecedent ((plan-rest-dining ?d ?person1 ?rest1 ?thing1 ?drink1 ?instrument1))
    :consequent ((rest-dining ?d) (diner ?d ?person1) (restaurant ?d ?rest1)
				  (rest-thing-ordered ?d ?thing1)
				  (rest-thing-drunk ?d ?drink1)
				  (rest-drink-straw ?d ?instrument1)))

   (:antecedent ((plan-drinking ?d ?person1 ?drink1 ?instrument1))
    :consequent ((drinking ?d) (drinker ?d ?person1) (patient-drink ?d ?drink1)
			       (instr-drink ?d ?instrument1)))

   (:antecedent ((plan-taxi-travel ?b ?person1 ?taxi1 ?source1 ?dest1 ?td1))
    :consequent ((going-by-taxi ?b) (goer ?b ?person1) (vehicle ?b ?taxi1) (source-go ?b ?source1)
				    (dest-go ?b ?dest1) (taxi-driver ?b ?td1)))

   (:antecedent ((plan-paying ?p ?person1 ?thing1))
    :consequent ((paying ?p) (payer ?p ?person1) (thing-paid ?p ?thing1)))

   (:antecedent ((plan-jogging ?j ?person1 ?drink1 ?instrument1))
    :consequent	((jogging ?j) (jogger ?j ?person1) (jog-thing-drunk ?j ?drink1)
			      (jog-drink-straw ?j ?instrument1)))

   (:antecedent ((plan-partying ?p ?person1 ?drink1 ?instrument1))
    :consequent ((partying ?p) (agent-party ?p ?person1) (party-thing-drunk ?p ?drink1)
			       (party-drink-straw ?p ?instrument1)))))