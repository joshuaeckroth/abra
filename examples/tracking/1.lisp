(clearmem)

(load-problem "tracking/scripts")
(load-problem "tracking/kb")
(load-problem "tracking/cases-easy-single")


;; Usage:
;; (load-problem "tracking/1")
;; (test-all-exp-cases 100 #'pick-belief-random)
;;
;; output is the average % groundtruth matched
