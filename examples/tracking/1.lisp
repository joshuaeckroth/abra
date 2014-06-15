(clearmem)

(load-problem "tracking/scripts")
(load-problem "tracking/kb")
(load-problem "tracking/cases-anomalies")

;; Usage:
;; (load-problem "tracking/1")
;; (test-all-exp-cases 100 #'pick-belief-random)
;;
;; output is prec, recall
