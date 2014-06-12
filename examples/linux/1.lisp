(clearmem)

(load-problem "linux/scripts")
(load-problem "linux/kb")
(load-problem "linux/evidence")
(load-problem "linux/cases")


;; Usage:
;; (load-problem "linux/1")
;; (test-all-exp-cases 100 #'pick-belief-random)
;;
;; output is the average % groundtruth matched
