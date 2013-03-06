(in-package :abra)

;;;; KNOWLEDGE BASE

;;; Rule Structure:
;;;
;;; (5/2/12) 
;;;
;;; In general, AbRA treats all rules as if they have been specified
;;; with modal literals, turning (x ?arg) -> (y ?arg) into
;;; (belief ?a (x ?arg)) -> (belief ?a (y ?arg))
;;;
;;; Asking for rules that mention (y const) will assume that you meant
;;; (belief agt (y const)). You have to search for goals explicitly,
;;; using a structure like (goal agt (y const)) to query.
;;;
;;; Literals that refer to nested agents, such as 
;;;  (belief ?A1 (belief ?A2 (x ?arg)))
;;; are not used as keys for the rules.

;; implementation is always subject to review and modification
(defstruct kb 
  ;; map to modalities, then to valence, then to predicate
  (modemap (make-hash-table :test #'eq))
  ;; versions of the rules with existentials in place
  (rl-to-jst (make-hash-table :test #'eq)))

;; use this to create a new knowledge base to avoid problems when the
;; implementation changes.
(defun create-kb ()
  (let ((kb (make-kb)))
    (setf (gethash +belief+ (kb-modemap kb)) (make-hash-table :test #'eq))
    kb))

;; store a rule in the knowledge base
(defun store-rule (rl kb)
  (mapcar #'(lambda (x) 
	      (if (not (modal-lit? x))
		  (store-rule-by-literal x rl (gethash +belief+ (kb-modemap kb)))
		  (store-rule-by-modal x rl (kb-modemap kb))))
	  (literals rl))
  (setf (gethash rl (kb-rl-to-jst kb)) (instantiate-rule rl)))

;; store's the rule keyed from the given literal.
;; internal function
(defun store-rule-by-modal (lit rl map)
  (let ((mode (modality lit)))
    (unless (gethash mode map)
      (setf (gethash mode map) (make-hash-table :test 'equal)))
    (if (modal-lit? (modal-content lit))
	;; for (<mode> ?agt (<mode> ?agt ?X)) go deeper.
	(store-rule-by-modal (modal-content lit) rl (gethash mode map))
	(if (variable? (modal-content lit))
	    ;; for (<mode> ?agt ?X), store the rule under the correct modality
	    (setf (gethash rl (gethash mode map)) t)
	    (store-rule-by-literal lit rl (gethash mode map))))))

;; store's the rule keyed from the given literal.
;; internal function
(defun store-rule-by-literal (lit rl map)
  (unless (gethash 'neg map)
    (setf (gethash 'neg map) (make-hash-table :test 'eq)))
  (unless (gethash 'pos map)
    (setf (gethash 'pos map) (make-hash-table :test 'eq)))
  (if (negated? lit)
      (store-rule-in-set (predicate-name lit) rl (gethash 'neg map))
      (store-rule-in-set (predicate-name lit) rl (gethash 'pos map))))

;; store a rule by the given predicate name, avoiding duplicates
;; internal function
(defun store-rule-in-set (pname rl ht)
  (unless (gethash pname ht) 
    (setf (gethash pname ht) (make-hash-table :test 'equal)))
  (setf (gethash rl (gethash pname ht)) t))

;; return rules in y that could explain x
(defgeneric get-rules (x y &key no-dialog?))

;; return rules in kb that could explain lit.
(defmethod get-rules ((lit cons) (kb kb) &key (no-dialog? nil))
  (if (modal-lit? lit) 
      (get-rules lit (gethash (modality lit) (kb-modemap kb)) :no-dialog? no-dialog?)
      (get-rules lit (gethash +belief+ (kb-modemap kb)) :no-dialog? no-dialog?)))

;; return rules in kb that could explain lit.
(defmethod get-rules ((lit cons) (map hash-table) &key (no-dialog? nil))
  (filter-dialog-rules 
   no-dialog?
   (cond ((variable? (modal-content lit))
	  (remove-if #'atom (hash-table-keys map)))
	 ((not (modal-lit? (modal-content lit)))
	  (hash-table-keys (gethash (predicate-name lit) 
				    (if (negated? lit)
					(gethash 'neg map)
					(gethash 'pos map)))))
	 ((gethash (modality lit) map)
	  (get-rules (modal-content lit) (gethash (modality lit) map) :no-dialog? no-dialog?)))))
	 
;; return rules in kb that could explain b.
(defmethod get-rules ((b belief) (kb kb) &key (no-dialog? nil))
  (get-rules (belief-content b) kb :no-dialog? no-dialog?))


;; returns the instantiated rules from kb that can bind with lit.
(defun get-inst-rules (lit kb)
  (remove-duplicates 
   (loop for r in (get-rules lit kb)
	 when (gethash r (kb-rl-to-jst kb))
	   collect (gethash r (kb-rl-to-jst kb)))))
