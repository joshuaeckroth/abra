(clearmem)

(load-problem "tracking/scripts")
(load-problem "tracking/kb")
(load-problem "tracking/cases-gray50")

(defun test-tracking (repetitions)
  (format t "Cases,PickBelief,Steps,Precision,Recall~%")
  (dolist (cases '("cases-easy" "cases-gray50"))
    (dolist (pb '("pick-belief-random" "pick-belief-fewrules-unattached" "pick-belief-recency-unattached"))
      (dolist (steps '(100 250 500 1000 1500 2000))
        (loop for i from 1 to repetitions
           do (clearmem)
             (load-problem "tracking/scripts")
             (load-problem "tracking/kb")
             (load-problem (format nil "tracking/~A" cases))
             (destructuring-bind (prec recall)
                 (test-all-exp-cases steps (symbol-function (find-symbol (string-upcase pb) :abra)))
               (format t "~A,~A,~A,~A,~A~%" cases pb steps prec recall)))))))

;; Usage:
;; (load-problem "tracking/1")
;; (test-all-exp-cases 100 #'pick-belief-random)
;;
;; output is prec, recall
