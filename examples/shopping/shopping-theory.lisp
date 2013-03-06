;; need to add rules that implement the sorts used throughout the
;; original shopping knowledge base.

;; this knowledge base is broken. for example, the only back-chaining
;; possible off of (liquor-store X) leads to (liqst-shopping
;; Y). there's no equivalent liqst-robbing that would connect the
;; robbing action to the liquor store.
(defun convert-rules (rs)
  (mapcar #'convert-rule rs))

(defun convert-rule (r)
  (format t "(:consequent ~A~% :antecedent ~A~% :constraints ~A~% :context ~A~%)~%~%"
	  (convert-conjunction (third r))
	  (convert-conjunction (second r))
	  (fourth r)
	  (fifth r)))

(defun convert-conjunction (cjn)
  (cond ((eq 'and (first cjn))
	 (rest cjn))
	(t (list cjn))))
	  
(defun build-shopping-rules (sorts?)
  (if sorts?
      (create-rules 
;;; shopping 
(:antecedent ((SHOPPING ?S) (GO-STEP ?S ?G))
 :consequent ((GOING ?G)))

(:antecedent ((SHOPPING ?S) (GO-STEP ?S ?G) (SHOPPER ?S ?P))
 :consequent ((GOER ?G ?P)) )

(:antecedent ((SHOPPING ?S) (GO-STEP ?S ?G) (STORE ?S ?STR))
 :consequent ((DEST-GO ?G ?STR)))

(:antecedent ((SHOPPING ?S) (STORE ?S ?SP))
 :consequent ((SHOPPING-PLACE ?SP)))

(:antecedent ((SHOPPING ?S) (FIND-STEP ?S ?F))
 :consequent ((FINDING ?F)))

(:antecedent ((SHOPPING ?S) (FIND-STEP ?S ?F) (SHOPPER ?S ?A))
 :consequent ((FINDER ?F ?A)))

(:antecedent ((SHOPPING ?S) (FIND-STEP ?S ?F) (THING-SHOPPED-FOR ?S ?TF))
 :consequent ((THING-FOUND ?F ?TF)))

(:antecedent ((SHOPPING ?S) (BUY-STEP ?S ?B))
 :consequent ((BUYING ?B)))

(:antecedent ((SHOPPING ?S) (BUY-STEP ?S ?B) (SHOPPER ?S ?P))
 :consequent ((BUYER ?B ?P)))

(:antecedent ((SHOPPING ?S) (BUY-STEP ?S ?B) (THING-SHOPPED-FOR ?S ?TB))
 :consequent ((THING-BOUGHT ?TB)))

(:antecedent ((BUYING ?B) (PAY-STEP ?B ?P))
 :consequent ((PAYING ?P)))

(:antecedent ((BUYING ?B) (PAY-STEP ?B ?P) (BUYER ?B ?A))
 :consequent ((PAYER ?P ?A)))

(:antecedent ((BUYING ?B) (PAY-STEP ?B ?P) (THING-BOUGHT ?B ?TP))
 :consequent ((THING-PAID ?P ?TP)))

(:antecedent ((SMARKET-SHOPPING ?S) (STORE ?S ?STR))
 :consequent ((SMARKET ?STR)))

(:antecedent ((SMARKET-SHOPPING ?S) (THING-SHOPPED-FOR ?S ?F))
 :consequent ((FOOD ?F)))

(:antecedent ((LIQST-SHOPPING ?S) (STORE ?S ?LS))
 :consequent ((LIQUOR-STORE ?LS)))

(:antecedent ((LIQST-SHOPPING ?S) (THING-SHOPPED-FOR ?S ?L))
 :consequent ((LIQUOR ?L)))

;;; robbing

(:antecedent ((ROBBING ?R) (GET-WEAPON-STEP ?R ?G))
 :consequent ((GETTING ?G)))

(:antecedent ((ROBBING ?R) (GET-WEAPON-STEP ?R ?G) (ROBBER ?R ?A))
 :consequent ((AGENT-GET ?G ?A)))

(:antecedent ((ROBBING ?R) (GET-WEAPON-STEP ?R ?G) (WEAPON-ROB ?R ?W))
 :consequent ((PATIENT-GET ?G ?W)))

(:antecedent ((ROBBING ?R) (GO-STEP ?R ?G))
 :consequent ((GOING ?G)))

(:antecedent ((ROBBING ?R) (GO-STEP ?R ?G) (ROBBER ?R ?A))
 :consequent ((GOER ?G ?A)))

(:antecedent ((ROBBING ?R) (GO-STEP ?R ?G) (PLACE-ROB ?R ?P))
 :consequent ((DEST-GO ?G ?P)))

(:antecedent ((ROBBING ?R) (POINT-WEAPON-STEP ?R ?P))
 :consequent ((POINTING ?P)))

(:antecedent ((ROBBING ?R) (POINT-WEAPON-STEP ?R ?P) (ROBBER ?R ?A))
 :consequent ((AGENT-POINT ?P ?A)))

(:antecedent ((ROBBING ?R) (POINT-WEAPON-STEP ?R ?P) (VICTIM-ROB ?R ?A))
 :consequent ((PATIENT-POINT ?P ?A)))

(:antecedent ((ROBBING ?R) (POINT-WEAPON-STEP ?R ?P) (WEAPON-ROB ?R ?I))
 :consequent ((INSTR-POINT ?P ?I)))

(:antecedent ((ROBBING ?R) (WEAPON-ROB ?R ?I))
 :consequent ((WEAPON ?I)))

(:antecedent ((ROBBING ?R) (GET-VALUABLE-STEP ?R ?G))
 :consequent ((GETTING ?G)))

(:antecedent ((ROBBING ?R) (GET-VALUABLE-STEP ?R ?G) (ROBBER ?R ?A))
 :consequent ((AGENT-GET ?G ?A)))

(:antecedent ((ROBBING ?R) (GET-VALUABLE-STEP ?R ?G) (THING-ROBBED ?R ?T))
 :consequent ((PATIENT-GET ?G ?T)))

(:antecedent ((ROBBING ?R) (GET-VALUABLE-STEP ?R ?G) (VICTIM-ROB ?R ?A))
 :consequent ((FROM-GET ?G ?A)))

(:antecedent ((ROBBING ?R) (THING-ROBBED ?R ?T))
 :consequent ((VALUABLE ?T)))

;;; rest-dining

(:antecedent ((REST-DINING ?D) (GO-STEP ?D ?G))
 :consequent ((GOING ?G)))

(:antecedent ((REST-DINING ?D) (GO-STEP ?D ?G) (DINER ?D ?A))
 :consequent ((GOER ?G ?A)))

(:antecedent ((REST-DINING ?D) (GO-STEP ?D ?G) (RESTAURANT-NAME ?D ?R))
 :consequent ((DEST-GO ?G ?R)))

(:antecedent ((REST-DINING ?D) (RESTAURANT-NAME ?D ?R))
 :consequent ((RESTAURANT ?R)))

(:antecedent ((REST-DINING ?D) (ORDER-STEP ?D ?O))
 :consequent ((ORDERING ?O)))

(:antecedent ((REST-DINING ?D) (ORDER-STEP ?D ?O) (DINER ?D ?A))
 :consequent ((AGENT-ORDER ?O ?A)))

(:antecedent ((REST-DINING ?D) (ORDER-STEP ?D ?O)
              (REST-THING-ORDERED ?D ?P))
 :consequent ((PATIENT-ORDER ?O ?P)))

(:antecedent ((REST-DINING ?D) (DRINK-STEP ?D ?O))
 :consequent ((DRINKING ?O)))

(:antecedent ((REST-DINING ?D) (DRINK-STEP ?D ?O) (DINER ?D ?A))
 :consequent ((DRINKER ?O ?A)))

(:antecedent ((REST-DINING ?D) (DRINK-STEP ?D ?O) (REST-THING-DRUNK ?D ?P))
 :consequent ((PATIENT-DRINK ?O ?P)))

(:antecedent ((REST-DINING ?D) (DRINK-STEP ?D ?O) (REST-DRINK-STRAW ?D ?P))
 :consequent ((INSTR-DRINK ?O ?P)))

(:antecedent ((REST-DINING ?D) (PAY-STEP ?D ?O))
 :consequent ((PAYING ?O)))

(:antecedent ((REST-DINING ?D) (PAY-STEP ?D ?O) (DINER ?D ?A))
 :consequent ((PAYER ?O ?A)))

(:antecedent ((REST-DINING ?D) (PAY-STEP ?D ?O) (REST-THING-ORDERED ?D ?P))
 :consequent ((THING-PAID ?O ?P)))

;;; drinking

(:antecedent ((DRINKING ?D) (GET-STRAW-STEP ?D ?G))
 :consequent ((GETTING ?G)))

(:antecedent ((DRINKING ?D) (GET-STRAW-STEP ?D ?G) (DRINKER ?D ?A))
 :consequent ((AGENT-GET ?G ?A)))

(:antecedent ((DRINKING ?D) (GET-STRAW-STEP ?D ?G) (INSTR-DRINK ?D ?P))
 :consequent ((PATIENT-GET ?G ?P)))

(:antecedent ((DRINKING ?D) (PUT-STRAW-STEP ?D ?P))
 :consequent ((PUTTING ?P)))

(:antecedent ((DRINKING ?D) (PUT-STRAW-STEP ?D ?P) (DRINKER ?D ?A))
 :consequent ((AGENT-PUT ?P ?A)))

(:antecedent ((DRINKING ?D) (PUT-STRAW-STEP ?D ?P) (INSTR-DRINK ?D ?A))
 :consequent ((PATIENT-PUT ?P ?A)))

(:antecedent ((DRINKING ?D) (INSTR-DRINK ?D ?A))
 :consequent ((STRAW ?A)))

(:antecedent ((DRINKING ?D) (PUT-STRAW-STEP ?D ?P) (PATIENT-DRINK ?D ?A))
 :consequent ((PLACE-PUT ?P ?A)))

(:antecedent ((DRINKING ?D) (INGEST-STEP ?D ?I))
 :consequent ((INGESTING ?I)))

(:antecedent ((DRINKING ?D) (INGEST-STEP ?D ?I) (DRINKER ?D ?A))
 :consequent ((AGENT-INGEST ?I ?A)))

(:antecedent ((DRINKING ?D) (INGEST-STEP ?D ?I) (PATIENT-DRINK ?D ?P))
 :consequent ((PATIENT-INGEST ?I ?P)))

(:antecedent ((DRINKING ?D) (INGEST-STEP ?D ?I) (INSTR-DRINK ?D ?P))
 :consequent ((INSTR-INGEST ?I ?P)))

;;; going-by-X

(:antecedent ((GOING-BY-VEHICLE ?V) (GO-STEP ?V ?G))
 :consequent ((GOING ?G)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GO-STEP ?V ?G) (GOER ?V ?A))
 :consequent ((GOER ?G ?A)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GO-STEP ?V ?G) (SOURCE-GO ?V ?S))
 :consequent ((DEST-GO ?G ?S)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-ON-STEP ?V ?O))
 :consequent ((GETTING-ON ?O)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-ON-STEP ?V ?O) (GOER ?V ?A))
 :consequent ((AGENT-GET-ON ?O ?A)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-ON-STEP ?V ?O) (VEHICLE ?V ?W))
 :consequent ((PATIENT-GET-ON ?O ?W)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-ON-STEP ?V ?O) (SOURCE-GO ?V ?P))
 :consequent ((PLACE-GET-ON ?O ?P)))

(:antecedent ((GOING-BY-VEHICLE ?V) (VEHICLE ?V ?W))
 :consequent ((INSTANCE-VEHICLE ?W)))

(:antecedent ((GOING-BY-VEHICLE ?V) (SIT-STEP ?V ?S))
 :consequent ((SITTING ?S)))

(:antecedent ((GOING-BY-VEHICLE ?V) (SIT-STEP ?V ?S) (GOER ?V ?A))
 :consequent ((AGENT-SIT ?S ?A)))

(:antecedent ((GOING-BY-VEHICLE ?V) (SIT-STEP ?V ?S) (VEHICLE-SEAT ?V ?P))
 :consequent ((PATIENT-SIT ?S ?P)))

(:antecedent ((GOING-BY-VEHICLE ?V) (VEHICLE-SEAT ?V ?P))
 :consequent ((SEAT ?P)))

(:antecedent ((GOING-BY-VEHICLE ?V) (VEHICLE-SEAT ?V ?P) (VEHICLE ?V ?W))
 :consequent ((IN ?P ?W)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-OFF-STEP ?V ?O))
 :consequent ((GETTING-OFF ?O)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-OFF-STEP ?V ?O) (GOER ?V ?A))
 :consequent ((AGENT-GET-OFF ?O ?A)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-OFF-STEP ?V ?O) (VEHICLE ?V ?W))
 :consequent ((PATIENT-GET-OFF ?O ?W)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-OFF-STEP ?V ?O) (DEST-GO ?V ?P))
 :consequent ((PLACE-GET-OFF ?O ?P)))

(:antecedent ((GOING-BY-BUS ?B) (VEHICLE ?B ?V))
 :consequent ((BUS ?V)))

(:antecedent ((GOING-BY-TAXI ?T) (VEHICLE ?T ?V))
 :consequent ((TAXI ?V)))

(:antecedent ((GOING-BY-PLANE ?P) (VEHICLE ?P ?V))
 :consequent ((PLANE ?V)))

(:antecedent ((GOING-BY-BUS ?V) (SOURCE-GO ?V ?S))
 :consequent ((BUS-STATION ?S)))

(:antecedent ((GOING-BY-BUS ?B) (GIVE-TOKEN-STEP ?B ?G))
 :consequent ((GIVING ?G)))

(:antecedent ((GOING-BY-BUS ?B) (GIVE-TOKEN-STEP ?B ?G) (GOER ?B ?A))
 :consequent ((GIVER ?G ?A)))

(:antecedent ((GOING-BY-BUS ?B) (GIVE-TOKEN-STEP ?B ?G) (BUS-DRIVER ?B ?A))
 :consequent ((RECIPIENT ?G ?A)))

(:antecedent ((GOING-BY-BUS ?B) (BUS-DRIVER ?B ?A))
 :consequent ((OCCUPATION ?A BUSDRIVER)))

(:antecedent ((GOING-BY-BUS ?B) (GIVE-TOKEN-STEP ?B ?G) (TOKEN ?B ?T))
 :consequent ((THING-GIVEN ?G ?T)))

(:antecedent ((GOING-BY-BUS ?B) (TOKEN ?B ?T))
 :consequent ((INSTANCE-TOKEN ?T)))

(:antecedent ((GOING-BY-TAXI ?B) (PAY-STEP ?B ?P))
 :consequent ((PAYING ?P)))

(:antecedent ((GOING-BY-TAXI ?B) (PAY-STEP ?B ?P) (GOER ?B ?A))
 :consequent ((PAYER ?P ?A)))

(:antecedent ((GOING-BY-TAXI ?B) (PAY-STEP ?B ?P) (TAXI-DRIVER ?B ?A))
 :consequent ((PAYEE ?P ?A)))

(:antecedent ((GOING-BY-TAXI ?B) (TAXI-DRIVER ?B ?A))
 :consequent ((OCCUPATION ?A TAXIDRIVER)))

(:antecedent ((GOING-BY-PLANE ?V) (SOURCE-GO ?V ?S))
 :consequent ((AIRPORT ?S)))

(:antecedent ((GOING-BY-PLANE ?P) (PACK-STEP ?P ?S))
 :consequent ((PACKING ?S)))

(:antecedent ((GOING-BY-PLANE ?P) (PACK-STEP ?P ?S) (GOER ?P ?A))
 :consequent ((AGENT-PACK ?S ?A)))

(:antecedent ((GOING-BY-PLANE ?P) (PACK-STEP ?P ?S) (PLANE-LUGGAGE ?P ?L))
 :consequent ((PATIENT-PACK ?S ?L)))

(:antecedent ((GOING-BY-PLANE ?P) (PLANE-LUGGAGE ?P ?L))
 :consequent ((BAG ?L)))

(:antecedent ((GOING-BY-PLANE ?S) (BUY-TICKET-STEP ?S ?B))
 :consequent ((BUYING ?B)))

(:antecedent ((GOING-BY-PLANE ?S) (BUY-TICKET-STEP ?S ?B) (GOER ?S ?A))
 :consequent ((BUYER ?B ?A)))

(:antecedent ((GOING-BY-PLANE ?S) (BUY-TICKET-STEP ?S ?B)
              (PLANE-TICKET ?S ?T))
 :consequent ((THING-BOUGHT ?B ?T)))

(:antecedent ((GOING-BY-PLANE ?S) (PLANE-TICKET ?S ?T))
 :consequent ((TICKET ?T)))

;;; jogging

(:antecedent ((JOGGING ?J) (DRINK-STEP ?J ?D))
 :consequent ((DRINKING ?D)))

(:antecedent ((JOGGING ?J) (DRINK-STEP ?J ?D) (JOGGER ?J ?A))
 :consequent ((DRINKER ?D ?A)))

(:antecedent ((JOGGING ?J) (DRINK-STEP ?J ?D) (JOG-THING-DRUNK ?J ?A))
 :consequent ((PATIENT-DRINK ?D ?A)))

(:antecedent ((JOGGING ?J) (DRINK-STEP ?J ?D) (JOG-DRINK-STRAW ?J ?A))
 :consequent ((INSTR-DRINK ?D ?A)))

;;; partying

(:antecedent ((PARTYING ?P) (DRINK-STEP ?P ?D))
 :consequent ((DRINKING ?D)))

(:antecedent ((PARTYING ?P) (DRINK-STEP ?P ?D) (AGENT-PARTY ?P ?A))
 :consequent ((DRINKER ?D ?A)))

(:antecedent ((PARTYING ?P) (DRINK-STEP ?P ?D) (PARTY-THING-DRUNK ?P ?A))
 :consequent ((PATIENT-DRINK ?D ?A)))

(:antecedent ((PARTYING ?P) (DRINK-STEP ?P ?D) (PARTY-DRINK-STRAW ?P ?A))
 :consequent ((INSTR-DRINK ?D ?A)))

;; sorts
(:antecedent ((PHYSICAL ?X)) :consequent ((ANY ?X)))
(:antecedent ((ACTION ?X)) :consequent ((ANY ?X)))

(:antecedent ((APPAREL ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((BAG ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((FOOD ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((GIFT ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((LIQUOR ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((PLACE ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((SEAT ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((SHELF ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((STRAW ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((TICKET ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((INSTANCE-TOKEN ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((VALUABLE ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((INSTANCE-VEHICLE ?X)) :consequent ((PHYSICAL ?X)))
(:antecedent ((WEAPON ?X)) :consequent ((PHYSICAL ?X)))

(:antecedent ((BUYING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((COURTING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((DRINKING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((FINDING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((GETTING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((GETTING-OFF ?X)) :consequent ((ACTION ?X)))
(:antecedent ((GETTING-ON ?X)) :consequent ((ACTION ?X)))
(:antecedent ((GIVING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((GOING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((INGESTING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((JOGGING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((ORDERING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((PACKING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((PARTYING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((PAYING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((POINTING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((PUTTING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((REST-DINING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((ROBBING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((SHOPPING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((SITTING ?X)) :consequent ((ACTION ?X)))
(:antecedent ((WORKING ?X)) :consequent ((ACTION ?X)))

(:antecedent ((SHIRT ?X)) :consequent ((APPAREL ?X)))
(:antecedent ((SKIRT ?X)) :consequent ((APPAREL ?X)))
(:antecedent ((TROUSERS ?X)) :consequent ((APPAREL ?X)))
(:antecedent ((UNIFORM ?X)) :consequent ((APPAREL ?X)))

(:antecedent ((SUITCASE ?X)) :consequent ((BAG ?X)))

(:antecedent ((BREAD ?X)) :consequent ((FOOD ?X)))
(:antecedent ((MILK ?X)) :consequent ((FOOD ?X)))
(:antecedent ((MILKSHAKE ?X)) :consequent ((FOOD ?X)))

(:antecedent ((FLOWER ?X)) :consequent ((GIFT ?X)))
(:antecedent ((JEWELRY ?X)) :consequent ((GIFT ?X)))

(:antecedent ((BOURBON ?X)) :consequent ((LIQUOR ?X)))

(:antecedent ((AIRPORT ?X)) :consequent ((PLACE ?X)))
(:antecedent ((BUS-STATION ?X)) :consequent ((PLACE ?X)))
(:antecedent ((PARK ?X)) :consequent ((PLACE ?X)))
(:antecedent ((PRISON ?X)) :consequent ((PLACE ?X)))
(:antecedent ((RESTAURANT ?X)) :consequent ((PLACE ?X)))
(:antecedent ((SCHOOL ?X)) :consequent ((PLACE ?X)))
(:antecedent ((SHOPPING-PLACE ?X)) :consequent ((PLACE ?X)))

(:antecedent ((MONEY ?X)) :consequent ((VALUABLE ?X)))

(:antecedent ((BUS ?X)) :consequent ((INSTANCE-VEHICLE ?X)))
(:antecedent ((PLANE ?X)) :consequent ((INSTANCE-VEHICLE ?X)))
(:antecedent ((TAXI ?X)) :consequent ((INSTANCE-VEHICLE ?X)))

(:antecedent ((GUN ?X)) :consequent ((WEAPON ?X)))
(:antecedent ((KNIFE ?X)) :consequent ((WEAPON ?X)))

(:antecedent ((GOING-BY-VEHICLE ?X)) :consequent ((GOING ?X)))

(:antecedent ((LIQST-SHOPPING ?X)) :consequent ((SHOPPING ?X)))
(:antecedent ((SMARKET-SHOPPING ?X)) :consequent ((SHOPPING ?X)))

(:antecedent ((LIQUOR-STORE ?X)) :consequent ((SHOPPING-PLACE ?X)))
(:antecedent ((SMARKET ?X)) :consequent ((SHOPPING-PLACE ?X)))

(:antecedent ((GOING-BY-BUS ?X)) :consequent ((GOING-BY-VEHICLE ?X)))
(:antecedent ((GOING-BY-PLANE ?X)) :consequent ((GOING-BY-VEHICLE ?X)))
(:antecedent ((GOING-BY-TAXI ?X)) :consequent ((GOING-BY-VEHICLE ?X))))

;;;; else

      (create-rules 
;;; shopping 

(:antecedent ((SHOPPING ?S) (GO-STEP ?S ?G))
 :consequent ((GOING ?G)))

(:antecedent ((SHOPPING ?S) (GO-STEP ?S ?G) (SHOPPER ?S ?P))
 :consequent ((GOER ?G ?P)) )

(:antecedent ((SHOPPING ?S) (GO-STEP ?S ?G) (STORE ?S ?STR))
 :consequent ((DEST-GO ?G ?STR)))

(:antecedent ((SHOPPING ?S) (STORE ?S ?SP))
 :consequent ((SHOPPING-PLACE ?SP)))

(:antecedent ((SHOPPING ?S) (FIND-STEP ?S ?F))
 :consequent ((FINDING ?F)))

(:antecedent ((SHOPPING ?S) (FIND-STEP ?S ?F) (SHOPPER ?S ?A))
 :consequent ((FINDER ?F ?A)))

(:antecedent ((SHOPPING ?S) (FIND-STEP ?S ?F) (THING-SHOPPED-FOR ?S ?TF))
 :consequent ((THING-FOUND ?F ?TF)))

(:antecedent ((SHOPPING ?S) (BUY-STEP ?S ?B))
 :consequent ((BUYING ?B)))

(:antecedent ((SHOPPING ?S) (BUY-STEP ?S ?B) (SHOPPER ?S ?P))
 :consequent ((BUYER ?B ?P)))

(:antecedent ((SHOPPING ?S) (BUY-STEP ?S ?B) (THING-SHOPPED-FOR ?S ?TB))
 :consequent ((THING-BOUGHT ?TB)))

(:antecedent ((BUYING ?B) (PAY-STEP ?B ?P))
 :consequent ((PAYING ?P)))

(:antecedent ((BUYING ?B) (PAY-STEP ?B ?P) (BUYER ?B ?A))
 :consequent ((PAYER ?P ?A)))

(:antecedent ((BUYING ?B) (PAY-STEP ?B ?P) (THING-BOUGHT ?B ?TP))
 :consequent ((THING-PAID ?P ?TP)))

(:antecedent ((SMARKET-SHOPPING ?S) (STORE ?S ?STR))
 :consequent ((SMARKET ?STR)))

(:antecedent ((SMARKET-SHOPPING ?S) (THING-SHOPPED-FOR ?S ?F))
 :consequent ((FOOD ?F)))

(:antecedent ((LIQST-SHOPPING ?S) (STORE ?S ?LS))
 :consequent ((LIQUOR-STORE ?LS)))

(:antecedent ((LIQST-SHOPPING ?S) (THING-SHOPPED-FOR ?S ?L))
 :consequent ((LIQUOR ?L)))

;;; robbing

(:antecedent ((ROBBING ?R) (GET-WEAPON-STEP ?R ?G))
 :consequent ((GETTING ?G)))

(:antecedent ((ROBBING ?R) (GET-WEAPON-STEP ?R ?G) (ROBBER ?R ?A))
 :consequent ((AGENT-GET ?G ?A)))

(:antecedent ((ROBBING ?R) (GET-WEAPON-STEP ?R ?G) (WEAPON-ROB ?R ?W))
 :consequent ((PATIENT-GET ?G ?W)))

(:antecedent ((ROBBING ?R) (GO-STEP ?R ?G))
 :consequent ((GOING ?G)))

(:antecedent ((ROBBING ?R) (GO-STEP ?R ?G) (ROBBER ?R ?A))
 :consequent ((GOER ?G ?A)))

(:antecedent ((ROBBING ?R) (GO-STEP ?R ?G) (PLACE-ROB ?R ?P))
 :consequent ((DEST-GO ?G ?P)))

(:antecedent ((ROBBING ?R) (POINT-WEAPON-STEP ?R ?P))
 :consequent ((POINTING ?P)))

(:antecedent ((ROBBING ?R) (POINT-WEAPON-STEP ?R ?P) (ROBBER ?R ?A))
 :consequent ((AGENT-POINT ?P ?A)))

(:antecedent ((ROBBING ?R) (POINT-WEAPON-STEP ?R ?P) (VICTIM-ROB ?R ?A))
 :consequent ((PATIENT-POINT ?P ?A)))

(:antecedent ((ROBBING ?R) (POINT-WEAPON-STEP ?R ?P) (WEAPON-ROB ?R ?I))
 :consequent ((INSTR-POINT ?P ?I)))

(:antecedent ((ROBBING ?R) (WEAPON-ROB ?R ?I))
 :consequent ((WEAPON ?I)))

(:antecedent ((ROBBING ?R) (GET-VALUABLE-STEP ?R ?G))
 :consequent ((GETTING ?G)))

(:antecedent ((ROBBING ?R) (GET-VALUABLE-STEP ?R ?G) (ROBBER ?R ?A))
 :consequent ((AGENT-GET ?G ?A)))

(:antecedent ((ROBBING ?R) (GET-VALUABLE-STEP ?R ?G) (THING-ROBBED ?R ?T))
 :consequent ((PATIENT-GET ?G ?T)))

(:antecedent ((ROBBING ?R) (GET-VALUABLE-STEP ?R ?G) (VICTIM-ROB ?R ?A))
 :consequent ((FROM-GET ?G ?A)))

(:antecedent ((ROBBING ?R) (THING-ROBBED ?R ?T))
 :consequent ((VALUABLE ?T)))

;;; rest-dining

(:antecedent ((REST-DINING ?D) (GO-STEP ?D ?G))
 :consequent ((GOING ?G)))

(:antecedent ((REST-DINING ?D) (GO-STEP ?D ?G) (DINER ?D ?A))
 :consequent ((GOER ?G ?A)))

(:antecedent ((REST-DINING ?D) (GO-STEP ?D ?G) (RESTAURANT-NAME ?D ?R))
 :consequent ((DEST-GO ?G ?R)))

(:antecedent ((REST-DINING ?D) (RESTAURANT-NAME ?D ?R))
 :consequent ((RESTAURANT ?R)))

(:antecedent ((REST-DINING ?D) (ORDER-STEP ?D ?O))
 :consequent ((ORDERING ?O)))

(:antecedent ((REST-DINING ?D) (ORDER-STEP ?D ?O) (DINER ?D ?A))
 :consequent ((AGENT-ORDER ?O ?A)))

(:antecedent ((REST-DINING ?D) (ORDER-STEP ?D ?O)
              (REST-THING-ORDERED ?D ?P))
 :consequent ((PATIENT-ORDER ?O ?P)))

(:antecedent ((REST-DINING ?D) (DRINK-STEP ?D ?O))
 :consequent ((DRINKING ?O)))

(:antecedent ((REST-DINING ?D) (DRINK-STEP ?D ?O) (DINER ?D ?A))
 :consequent ((DRINKER ?O ?A)))

(:antecedent ((REST-DINING ?D) (DRINK-STEP ?D ?O) (REST-THING-DRUNK ?D ?P))
 :consequent ((PATIENT-DRINK ?O ?P)))

(:antecedent ((REST-DINING ?D) (DRINK-STEP ?D ?O) (REST-DRINK-STRAW ?D ?P))
 :consequent ((INSTR-DRINK ?O ?P)))

(:antecedent ((REST-DINING ?D) (PAY-STEP ?D ?O))
 :consequent ((PAYING ?O)))

(:antecedent ((REST-DINING ?D) (PAY-STEP ?D ?O) (DINER ?D ?A))
 :consequent ((PAYER ?O ?A)))

(:antecedent ((REST-DINING ?D) (PAY-STEP ?D ?O) (REST-THING-ORDERED ?D ?P))
 :consequent ((THING-PAID ?O ?P)))

;;; drinking

(:antecedent ((DRINKING ?D) (GET-STRAW-STEP ?D ?G))
 :consequent ((GETTING ?G)))

(:antecedent ((DRINKING ?D) (GET-STRAW-STEP ?D ?G) (DRINKER ?D ?A))
 :consequent ((AGENT-GET ?G ?A)))

(:antecedent ((DRINKING ?D) (GET-STRAW-STEP ?D ?G) (INSTR-DRINK ?D ?P))
 :consequent ((PATIENT-GET ?G ?P)))

(:antecedent ((DRINKING ?D) (PUT-STRAW-STEP ?D ?P))
 :consequent ((PUTTING ?P)))

(:antecedent ((DRINKING ?D) (PUT-STRAW-STEP ?D ?P) (DRINKER ?D ?A))
 :consequent ((AGENT-PUT ?P ?A)))

(:antecedent ((DRINKING ?D) (PUT-STRAW-STEP ?D ?P) (INSTR-DRINK ?D ?A))
 :consequent ((PATIENT-PUT ?P ?A)))

(:antecedent ((DRINKING ?D) (INSTR-DRINK ?D ?A))
 :consequent ((STRAW ?A)))

(:antecedent ((DRINKING ?D) (PUT-STRAW-STEP ?D ?P) (PATIENT-DRINK ?D ?A))
 :consequent ((PLACE-PUT ?P ?A)))

(:antecedent ((DRINKING ?D) (INGEST-STEP ?D ?I))
 :consequent ((INGESTING ?I)))

(:antecedent ((DRINKING ?D) (INGEST-STEP ?D ?I) (DRINKER ?D ?A))
 :consequent ((AGENT-INGEST ?I ?A)))

(:antecedent ((DRINKING ?D) (INGEST-STEP ?D ?I) (PATIENT-DRINK ?D ?P))
 :consequent ((PATIENT-INGEST ?I ?P)))

(:antecedent ((DRINKING ?D) (INGEST-STEP ?D ?I) (INSTR-DRINK ?D ?P))
 :consequent ((INSTR-INGEST ?I ?P)))

;;; going-by-X

(:antecedent ((GOING-BY-VEHICLE ?V) (GO-STEP ?V ?G))
 :consequent ((GOING ?G)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GO-STEP ?V ?G) (GOER ?V ?A))
 :consequent ((GOER ?G ?A)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GO-STEP ?V ?G) (SOURCE-GO ?V ?S))
 :consequent ((DEST-GO ?G ?S)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-ON-STEP ?V ?O))
 :consequent ((GETTING-ON ?O)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-ON-STEP ?V ?O) (GOER ?V ?A))
 :consequent ((AGENT-GET-ON ?O ?A)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-ON-STEP ?V ?O) (VEHICLE ?V ?W))
 :consequent ((PATIENT-GET-ON ?O ?W)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-ON-STEP ?V ?O) (SOURCE-GO ?V ?P))
 :consequent ((PLACE-GET-ON ?O ?P)))

(:antecedent ((GOING-BY-VEHICLE ?V) (VEHICLE ?V ?W))
 :consequent ((INSTANCE-VEHICLE ?W)))

(:antecedent ((GOING-BY-VEHICLE ?V) (SIT-STEP ?V ?S))
 :consequent ((SITTING ?S)))

(:antecedent ((GOING-BY-VEHICLE ?V) (SIT-STEP ?V ?S) (GOER ?V ?A))
 :consequent ((AGENT-SIT ?S ?A)))

(:antecedent ((GOING-BY-VEHICLE ?V) (SIT-STEP ?V ?S) (VEHICLE-SEAT ?V ?P))
 :consequent ((PATIENT-SIT ?S ?P)))

(:antecedent ((GOING-BY-VEHICLE ?V) (VEHICLE-SEAT ?V ?P))
 :consequent ((SEAT ?P)))

(:antecedent ((GOING-BY-VEHICLE ?V) (VEHICLE-SEAT ?V ?P) (VEHICLE ?V ?W))
 :consequent ((IN ?P ?W)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-OFF-STEP ?V ?O))
 :consequent ((GETTING-OFF ?O)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-OFF-STEP ?V ?O) (GOER ?V ?A))
 :consequent ((AGENT-GET-OFF ?O ?A)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-OFF-STEP ?V ?O) (VEHICLE ?V ?W))
 :consequent ((PATIENT-GET-OFF ?O ?W)))

(:antecedent ((GOING-BY-VEHICLE ?V) (GET-OFF-STEP ?V ?O) (DEST-GO ?V ?P))
 :consequent ((PLACE-GET-OFF ?O ?P)))

(:antecedent ((GOING-BY-BUS ?B) (VEHICLE ?B ?V))
 :consequent ((BUS ?V)))

(:antecedent ((GOING-BY-TAXI ?T) (VEHICLE ?T ?V))
 :consequent ((TAXI ?V)))

(:antecedent ((GOING-BY-PLANE ?P) (VEHICLE ?P ?V))
 :consequent ((PLANE ?V)))

(:antecedent ((GOING-BY-BUS ?V) (SOURCE-GO ?V ?S))
 :consequent ((BUS-STATION ?S)))

(:antecedent ((GOING-BY-BUS ?B) (GIVE-TOKEN-STEP ?B ?G))
 :consequent ((GIVING ?G)))

(:antecedent ((GOING-BY-BUS ?B) (GIVE-TOKEN-STEP ?B ?G) (GOER ?B ?A))
 :consequent ((GIVER ?G ?A)))

(:antecedent ((GOING-BY-BUS ?B) (GIVE-TOKEN-STEP ?B ?G) (BUS-DRIVER ?B ?A))
 :consequent ((RECIPIENT ?G ?A)))

(:antecedent ((GOING-BY-BUS ?B) (BUS-DRIVER ?B ?A))
 :consequent ((OCCUPATION ?A BUSDRIVER)))

(:antecedent ((GOING-BY-BUS ?B) (GIVE-TOKEN-STEP ?B ?G) (TOKEN ?B ?T))
 :consequent ((THING-GIVEN ?G ?T)))

(:antecedent ((GOING-BY-BUS ?B) (TOKEN ?B ?T))
 :consequent ((INSTANCE-TOKEN ?T)))

(:antecedent ((GOING-BY-TAXI ?B) (PAY-STEP ?B ?P))
 :consequent ((PAYING ?P)))

(:antecedent ((GOING-BY-TAXI ?B) (PAY-STEP ?B ?P) (GOER ?B ?A))
 :consequent ((PAYER ?P ?A)))

(:antecedent ((GOING-BY-TAXI ?B) (PAY-STEP ?B ?P) (TAXI-DRIVER ?B ?A))
 :consequent ((PAYEE ?P ?A)))

(:antecedent ((GOING-BY-TAXI ?B) (TAXI-DRIVER ?B ?A))
 :consequent ((OCCUPATION ?A TAXIDRIVER)))

(:antecedent ((GOING-BY-PLANE ?V) (SOURCE-GO ?V ?S))
 :consequent ((AIRPORT ?S)))

(:antecedent ((GOING-BY-PLANE ?P) (PACK-STEP ?P ?S))
 :consequent ((PACKING ?S)))

(:antecedent ((GOING-BY-PLANE ?P) (PACK-STEP ?P ?S) (GOER ?P ?A))
 :consequent ((AGENT-PACK ?S ?A)))

(:antecedent ((GOING-BY-PLANE ?P) (PACK-STEP ?P ?S) (PLANE-LUGGAGE ?P ?L))
 :consequent ((PATIENT-PACK ?S ?L)))

(:antecedent ((GOING-BY-PLANE ?P) (PLANE-LUGGAGE ?P ?L))
 :consequent ((BAG ?L)))

(:antecedent ((GOING-BY-PLANE ?S) (BUY-TICKET-STEP ?S ?B))
 :consequent ((BUYING ?B)))

(:antecedent ((GOING-BY-PLANE ?S) (BUY-TICKET-STEP ?S ?B) (GOER ?S ?A))
 :consequent ((BUYER ?B ?A)))

(:antecedent ((GOING-BY-PLANE ?S) (BUY-TICKET-STEP ?S ?B)
              (PLANE-TICKET ?S ?T))
 :consequent ((THING-BOUGHT ?B ?T)))

(:antecedent ((GOING-BY-PLANE ?S) (PLANE-TICKET ?S ?T))
 :consequent ((TICKET ?T)))

;;; jogging

(:antecedent ((JOGGING ?J) (DRINK-STEP ?J ?D))
 :consequent ((DRINKING ?D)))

(:antecedent ((JOGGING ?J) (DRINK-STEP ?J ?D) (JOGGER ?J ?A))
 :consequent ((DRINKER ?D ?A)))

(:antecedent ((JOGGING ?J) (DRINK-STEP ?J ?D) (JOG-THING-DRUNK ?J ?A))
 :consequent ((PATIENT-DRINK ?D ?A)))

(:antecedent ((JOGGING ?J) (DRINK-STEP ?J ?D) (JOG-DRINK-STRAW ?J ?A))
 :consequent ((INSTR-DRINK ?D ?A)))

;;; partying

(:antecedent ((PARTYING ?P) (DRINK-STEP ?P ?D))
 :consequent ((DRINKING ?D)))

(:antecedent ((PARTYING ?P) (DRINK-STEP ?P ?D) (AGENT-PARTY ?P ?A))
 :consequent ((DRINKER ?D ?A)))

(:antecedent ((PARTYING ?P) (DRINK-STEP ?P ?D) (PARTY-THING-DRUNK ?P ?A))
 :consequent ((PATIENT-DRINK ?D ?A)))

(:antecedent ((PARTYING ?P) (DRINK-STEP ?P ?D) (PARTY-DRINK-STRAW ?P ?A))
 :consequent ((INSTR-DRINK ?D ?A)))

#|

;;; top level operators used to evaluate BALP and MLN performance in Raghavan's PhD thesis.

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
			       (party-drink-straw ?p ?instrument1)))
|#


)))