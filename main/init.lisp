(in-package :abra)

;; when true, candidates will be filtered so that they respect temporal constraints.
;; the filter is turned on when the temporal-filter code is loaded.
(defvar *temporal-filter* nil)


(defconstant +system-name+ 'icarus)

(defvar wm)
(defvar kb)

(defvar *groundtruth* nil)

(defmacro deftruth (&rest facts)
  `(dolist (fact (quote ,facts))
     (push fact *groundtruth*)))

(defstruct (exp-case (:conc-name exp-case-))
  (groundtruth nil)
  (evidence nil))

(defun initialize ()
  (reset-skolem-id)
  (reset-belief-id)
  (reset-justification-id)
  (reset-world-id)
  (reset-agent-id)

  (setf kb (create-kb))
  (setf wm (make-wm)))

(defun compute-groundtruth-matches (agent)
  (let* ((belief-test #'(lambda (b1 b2) (equal (belief-content b1)
                                               (belief-content b2))))
         (agent-beliefs (remove-duplicates (mapcar #'second (get-beliefs agent))
                                           :test belief-test))
         (gt-preds (remove-duplicates (mapcar #'first *groundtruth*)))
         (gt-matches (filter #'(lambda (b)
                                 (and (not (fact? b agent))
                                      (member (belief-content b) *groundtruth*
                                              :test #'equal)))
                             agent-beliefs))
         (gt-mismatches (filter #'(lambda (b)
                                    (and (not (fact? b agent))
                                         (notany #'(lambda (arg) (skolem? arg)) (rest (belief-content b)))
                                         (member (first (belief-content b)) gt-preds)
                                         (not (member (belief-content b) *groundtruth*
                                                      :test #'equal))))
                                agent-beliefs))
         (tp (length gt-matches))
         (fp (length gt-mismatches))
         (fn (- (length *groundtruth*) tp))
         (prec (if (= 0 (+ tp fp)) 0.0 (float (/ tp (+ tp fp)))))
         (recall (if (= 0 (+ tp fn)) 0.0 (float (/ tp (+ tp fn)))))
         
         ;; count matching groundings (literals inside a belief) for
         ;; those beliefs that match groundtruth but might have
         ;; existentials

         ;; first, collect matching beliefs; pair with the matching groundtruth literal(s)
         (gt-partial-matches
          (filter #'(lambda (pair)
                      (and (not (fact? (first pair) agent)))
                      (not (null (second pair))))
                  (mapcar #'(lambda (b)
                              (let ((gts (filter #'(lambda (g)
                                                     (literal-equal? (belief-content b) g :test #'agreeable-args?))
                                                 *groundtruth*)))
                                (list b gts)))
                          agent-beliefs)))
         ;; now compute the fraction of matches for each matching belief/groundtruth literal pair
         (gt-partial-matches-fractions
          (mappend #'(lambda (pair)
                       (let ((b (first pair))
                             (gts (second pair)))
                         (mapcar #'(lambda (g)
                                     ;; count the predicate matches as well;
                                     ;; this lets us handle 0-arg predicates (and avoid dividing by 0)
                                     (let ((matched-args (filter #'(lambda (pair) (equal (first pair) (second pair)))
                                                                 (mapcar #'(lambda (arg1 arg2) (list arg1 arg2))
                                                                         (belief-content b) g))))
                                       (/ (length matched-args) (length g))))
                                 gts)))
                   gt-partial-matches))
         (gt-partial-matches-avg (if (null gt-partial-matches-fractions) 0.0
                                     (float (/ (reduce #'+ gt-partial-matches-fractions)
                                               (length gt-partial-matches-fractions))))))
    (list gt-matches tp fp fn prec recall
          gt-partial-matches gt-partial-matches-fractions gt-partial-matches-avg)))

(defun test-one-init (rules example)
  (initialize)
  (dolist (r rules) (store-rule r kb))
  (add-facts example (wm-prime wm) wm)
  ;; (output-dot wm :show-worlds? t)
)

(defun test-one-print ()
  (let* ((agent (wm-prime wm))
         (supported-beliefs (mappend #'(lambda (j) (mapcar #'(lambda (b) (belief-id (second b)))
                                                           (get-supported-beliefs j (agent-beliefs agent))))
                                     (get-justifications agent))))
    (print-agent agent)
    (format t "~%~%Supported beliefs: ~A~%" supported-beliefs)
    (format t "~%Unexplained:~%")
    (dolist (b (mapcar #'second (get-beliefs agent)))
      (when (not (member (belief-id b) supported-beliefs))
        (format t "~T~A: ~A~%" (belief-id b) (belief-content b))))
    (when *groundtruth*
      (destructuring-bind
            (gt-matches tp fp fn prec recall
                        gt-partial-matches gt-partial-matches-fractions gt-partial-matches-avg)
          (compute-groundtruth-matches agent)
        (format t "~%~%Groundtruth: ~A~%~%" *groundtruth*)
        (format t "Groundtruth matches: (tp=~A fp=~A fn=~A prec=~A recall=~A)~%~T~A~%~%"
                tp fp fn prec recall gt-matches)
        (format t "Partial matches: ~A~%" gt-partial-matches)
        (format t "Partial match fractions: ~A~%" gt-partial-matches-fractions)
        (format t "Partial matches avg: ~A~%" gt-partial-matches-avg)))))

(defun test-one (steps example rules &optional (pb #'pick-belief-fewrules-unattached) (d? nil) (print? t))
  (test-one-init rules example)
  (dotimes (i steps) (infer wm kb
			    :bc-only? nil
			    :focused? nil :p -1
			    :pick-belief pb
			    :deduction? d?))
  (when print? (test-one-print))
  wm)

(defun test-exp-cases (steps cases rules &optional (pb #'pick-belief-fewrules-unattached) (d? nil) (print? t))
  (let ((tp-sum 0)
        (fp-sum 0)
        (fn-sum 0)
        (gt-pm-avg 0.0))
    (dolist (c cases)
      (clearmem)
      (dolist (fact (exp-case-groundtruth c))
        (push fact *groundtruth*))
      (let ((wm (test-one steps (exp-case-evidence c) rules pb d? print?)))
        (destructuring-bind (gt-matches tp fp fn prec recall
                                        gt-partial-matches gt-partial-matches-fractions gt-partial-matches-avg)
            (compute-groundtruth-matches (wm-prime wm))
          (declare (ignore gt-matches)
                   (ignore prec)
                   (ignore recall)
                   (ignore gt-partial-matches)
                   (ignore gt-partial-matches-fractions))
          (setq tp-sum (+ tp-sum tp))
          (setq fp-sum (+ fp-sum fp))
          (setq fn-sum (+ fn-sum fn))
          (setq gt-pm-avg (+ gt-pm-avg gt-partial-matches-avg)))))
    (let ((prec (if (= 0 (+ tp-sum fp-sum)) 0.0
                    (float (/ tp-sum (+ tp-sum fp-sum)))))
          (recall (if (= 0 (+ tp-sum fn-sum)) 0.0
                      (float (/ tp-sum (+ tp-sum fn-sum)))))
          (gt-pm-avg-overall (if (null cases) 0.0
                                 (/ gt-pm-avg (length cases)))))
      (list prec recall gt-pm-avg-overall))))

(defun inc-test-one (steps example rules &optional (plot? nil) (pb #'pick-belief-fewrules-unattached) (d? nil))
  (test-one-init rules (list (first example)))
  (dotimes (i steps) (infer wm kb :bc-only? nil
			    :focused? nil :p -1
			    :pick-belief pb
			    :deduction? d?))
  
  (dolist (f (rest example))
    (add-facts (list f) (wm-prime wm) wm)
    (dotimes (i steps) (infer wm kb :bc-only? nil
			    :focused? nil :p -1
			    :pick-belief pb
			    :deduction? d?))
    (when plot?
      (output-dot wm)
      (sleep 1))))

(defun continue-one (steps facts &optional (pb #'pick-belief-fewrules-unattached) (d? nil))
  (add-facts facts (wm-prime wm) wm)
  (dotimes (i steps) (infer wm kb 
			    :bc-only? nil
			    :focused? nil
			    :p -1 
			    :pick-belief pb
			    :deduction? d?)))

(defun next-cycle-one (blf-id &optional (d? nil))
  (labels ((pb (a b &key world)
	     (declare (ignore a b world))
	     (find blf-id (get-agent-beliefs (wm-prime wm)) 
		   :key #'(lambda (x) (belief-id (second x))))))
    (infer wm kb 
	   :bc-only? nil
	   :focused? nil
	   :p -1 
	   :pick-belief #'pb
	   :deduction? d?))
  (test-one-print))
