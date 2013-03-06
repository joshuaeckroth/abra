;; accel training case 1

;; jack went to the supermarket.
(defparameter *e1a*
      '((going go1)
	(goer go1 jack1)
	(name jack1 jack)
	(dest-go go1 sm1)
	(smarket sm1)))

;; jack found some milk on the shelf.
(defparameter *e1b*
      '((finding find1)
	(finder find1 jack1)
	(thing-found find1 milk1)
	(milk milk1)
	(on milk1 shf1)
	(shelf shf1)))

;; jack paid for the milk.
(defparameter *e1c*
      '((paying pay1)
	(payer pay1 jack1)
	(thing-paid pay1 milk1)))

;; jack went to the supermarket.
;; jack found some milk on the shelf.
;; jack paid for the milk.
(defparameter *e1*
      (append *e1a* (append *e1b* *e1c*)))

(defparameter *a1*
      '((smarket-shopping ?s)
	(go-step ?s go1)
	(find-step ?s find1)
	(buy-step ?s ?b)
	(pay-step ?b pay1)
	(shopper ?s jack1)
	(store ?s sm1)
	(thing-shopped-for ?s milk1)
	(name jack1 jack)
	(milk milk1)
	(on milk1 shf1)
	(shelf shf1)
	;; (precede go1 find1)
	;; (precede find1 pay1)
))


;; "Bill went to the supermarket.
;;  He paid for some milk."

(defparameter *e2a*
      '((going go2 )
	(goer go2 bill2)
	(name bill2 bill)
	(dest-go go2 sm2)
	(smarket sm2)))

(defparameter *e2b*
      '((paying pay2)
	(payer pay2 bill2)
	(thing-paid pay2 milk2)
	(milk milk2)))

(defparameter *e2* 
      (append *e2a* *e2b*))


;; jack gave the busdriver a token. 
(defparameter *e3a*
      '((giving give3)
	(giver give3 jack3)
	(name jack3 jack)
	(recipient give3 bd3)
	(occupation bd3 busdriver)
	(thing-given give3 tk3)
	(instance-token tk3)))

;; jack got off at the supermarket
(defparameter *e3b*
      '((getting-off getoff3)
	(agent-get-off getoff3 jack3)
	(place-get-off getoff3 sm3)
	(smarket sm3)))

;; jack gave the busdriver a token. 
;; jack got off at the supermarket
(defparameter *e3*
      (append *e3a* *e3b*))


;"Jack got off the bus at the liquor-store.
; He pointed a gun at the owner."
(defparameter *e4a*
      '((getting-off getoff4 )
	(agent-get-off getoff4 jack4)
	(name jack4 jack)
	(patient-get-off getoff4 bus4)
	(bus bus4 )
	(place-get-off getoff4 ls4)
	(liquor-store ls4 )))

(defparameter *e4b*
      '((pointing point4 )
	(agent-point point4 jack4)
	(instr-point point4 gun4)
	(gun gun4 )
	(patient-point point4 o4)
	(own o4 ls4)))

(defparameter *e4*
      (append *e4a* *e4b*))


;"Jack went to the liquor-store.
; He found some bourbon on the shelf."
(defparameter *e5a*
      '((going go5 )
	(goer go5 jack5)
	(name jack5 jack)
	(dest-go go5 ls5)
	(liquor-store ls5)))

(defparameter *e5b*
      '((finding find5 )
	(finder find5 jack5)
	(thing-found find5 bourbon5)
	(bourbon bourbon5 )
	(on bourbon5 shf5)
	(shelf shf5 )))

(defparameter *e5*
      (append *e5a* *e5b*))


;; bill went to a liquor store
(defparameter *e6a*
      '((going go6) 
	(goer go6 bill6) 
	(name bill6 bill) 
	(dest-go go6 ls6) 
	(liquor-store ls6)))
      
;; bill pointed a gun at the owner
(defparameter *e6b*
      '((pointing point6) 
	(agent-point point6 bill6) 
	(instr-point point6 gun6) 
	(gun gun6) 
	(patient-point point6 o6) 
	(own o6 ls6)))

(defparameter *e6*
      (append *e6a* *e6b*))

;; "Bill gave the busdriver a token."
(defparameter *e7*
      '((giving give7 )
	(giver give7 bill7)
	(name bill7 bill)
	(recipient give7 bd7)
	(occupation bd7 busdriver)
	(thing-given give7 tk7)
	(token-instance tk7 )))

;"Fred robbed the liquor-store.
; Fred pointed a gun at the owner."

(defparameter *e8a*
      '((robbing rob8 )
	(robber rob8 fred8)
	(name fred8 fred)
	(place-rob rob8 ls8)
	(liquor-store ls8 )))

(defparameter *e8b*
      '((pointing point8 )
	(agent-point point8 fred8)
	(instr-point point8 gun8)
	(gun gun8 )
	(patient-point point8 o8)
	(own o8 ls8)))

(defparameter *e8* (append *e8a* *e8b*))


;; bill got a gun.
(defparameter *e9a*
       '((getting get9)
	(agent-get get9 bill9)
	(name bill9 bill)
	(patient-get get9 gun9)
	(gun gun9)))

;; bill went to the supermarket
(defparameter *e9b*
      '((going go9)
	(goer go9 bill9)
	(dest-go go9 sm9)
	(smarket sm9)))

;; bill got a gun.
;; bill went to the supermarket.
(defparameter *e9*
      (append *e9a* *e9b*))

;;"Fred went to the supermarket.
;; He pointed a gun at the owner.
;; He packed his bag.
;; He went to the airport."

(defparameter *e10a*
      '((going go10 )
	(goer go10 fred10)
	(name fred10 fred)
	(dest-go go10 sm10)
	(smarket sm10 )))

(defparameter *e10b*
      '((pointing point10 )
	(agent-point point10 fred10)
	(instr-point point10 gun10)
	(gun gun10 )
	(patient-point point10 o10)
	(own o10 sm10)))

(defparameter *e10c*
      '((packing pack10 )
	(agent-pack pack10 fred10)
	(patient-pack pack10 bag10)
	(bag bag10 )))

(defparameter *e10d*
      '((going go10b )
	(goer go10b fred10)
	(dest-go go10b airport10)
	(airport airport10 )))

(defparameter *e10*
      (append *e10a* (append *e10b* (append *e10c* *e10d*))))