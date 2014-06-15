(in-package :abra)


;; this class stores information about each belief that is a candidate
;; for the focus of attention.
(defclass focus ()
  ((belief :initarg :belief :reader focus-belief)  ;; the belief
   (view :initarg :view :reader focus-view)        ;; the world where we're viewing the belief from
   (home :initarg :home :reader focus-home)        ;; the world where the belief is stored
   (modal :initarg :modal :reader focus-modal)))   ;; a modal expansion of the belief

(defun make-focus (belief view wm)
  (let ((bh (belief-home belief wm)))
    (make-instance 'focus
		   :belief belief
		   :view view
		   :home bh
		   :modal (expand-modals belief view bh))))

;; primarily for testing.
(defun get-all-beliefs ()
  (get-nested-beliefs (wm-prime wm)))

;;;;;
;; get-all-focus-candidates
;;
;; wm = working memory
;; forbidden = a list of predicates that cannot be focused on
;;             (e.g., type predicates that are there for information, but 
;;                    are not selective enough to contribute to the 
;;                    final explanation.
;;
;; return all focus candidates
;; ignore beliefs that belong to the forbidden predicates
(defun get-all-focus-candidates (wm &key forbidden)
  (mapcar #'(lambda (wb) (make-focus (second wb) (first wb) wm)) 
	  (remove-if #'(lambda (x) (member (predicate-name (belief-content (second x))) forbidden))
		     (get-nested-beliefs (wm-prime wm)))))

;; primarily for testing.
(defun expand-all-beliefs ()
  (mapcar #'(lambda (x) (expand-modals (second x) (first x) (belief-home (second x) wm))) (get-all-beliefs)))

;;;;;
;; pick-belief-*
;;
;; beliefs are chosen from the selected agent. only those beliefs
;; owned by that agent can be selected. beliefs available through
;; mental-state ascription can be used to support justifications, but
;; they are not available to be the focus. the reason for this is that
;; one need only explain the differences between one's mental state
;; and that of another agent.

;; selects a random belief that's visible from the given world. if no
;; world is given, assume the primary system world. 
(defun pick-belief-random (wm kb &key (agent (wm-prime wm)))
  (declare (ignore kb)) ;; used to keep the signature identical
  (let* ((blfs (get-nested-beliefs (wm-prime wm)))
	 (blf (pick-random-elt blfs)))
    (make-focus (second blf) (first blf) wm)))

;; mostly for testing. selects a belief given its id.
(defun pick-belief-id (wm kb &key (agent (wm-prime wm)) (id nil))
  (declare (ignore kb)) ;; used to keep the signature identical
  (when id
    (let ((world (bid-home id wm)))
      (make-focus (get-local-belief id world) world wm))))

;;; returns the most recently believed belief in the list.
;;; maximizes belief-start.
(defun get-newest (cfs)
  (loop with newest = (first cfs)
     for cf in (rest cfs)
     when (> (belief-start (focus-belief cf)) (belief-start (focus-belief newest)))
     do (setf newest cf)
     finally (return newest)))

;; selects the most recent belief. if world is specified, then limits
;; its search to beliefs viewable from that world.
(defun pick-belief-recency (wm kb &key (agent (wm-prime wm)))
  (declare (ignore kb)) ;; used to keep the signature identical
  (get-newest (mapcar #'(lambda (wb)
			  (make-focus (second wb) (first wb) wm))
		      (get-nested-beliefs (wm-prime wm)))))

(defun dialog-hack (x)
  (unless (eql (char (symbol-name (car (belief-content x))) 0) #\*) t))

;; returns the belief that can be explained by the fewest possible
;; rules.  favors making obvious inferences so that later inferences
;; so that we can use the new information to guide other inferences.
(defun get-fewest-rules (cfs kb)
  (when cfs
    (let* ((fewest (first cfs))
	   (fewest-score (length (get-rules (focus-modal fewest) kb
					    :no-dialog? 
					    (dialog-hack (focus-belief fewest)))))
	   (tmp-score))
      (dolist (cf (rest cfs) (when (> fewest-score 0) fewest))
	(setf tmp-score (length (get-rules (focus-modal cf) kb
					   :no-dialog? 
					   (dialog-hack (focus-belief cf)))))
	(when (and (> tmp-score 0) 
		   (< tmp-score fewest-score))
	  (setf fewest cf)
	  (setf fewest-score tmp-score))))))

;; b - belief
;; kb - knowledge base
;;
;; true if there are rules that could potentially explain b
(defun attachable-belief? (cf kb)
  (get-rules (focus-modal cf) kb :no-dialog? (dialog-hack (focus-belief cf))))

;; b - belief
;; world - home world of b
;; kb - knowledge base
;;
;; true if the belief is either already explained or if it cannot be
;; explained by the knowledge base.
(defun attached-belief? (cf)
  (or (filter-dialog-justifications 
       (dialog-hack (focus-belief cf))
       (get-support (focus-belief cf) (focus-home cf)))
      (belief-weak-links (focus-belief cf))))

(defun remove-attached-beliefs (cfs kb)
  (remove-if #'(lambda (cf)
		 (when cf
		   (or (attached-belief? cf)
		       (not (attachable-belief? cf kb)))))
	     cfs))

;;; returns the most recent unexplained belief or the most recent belief if
;;; everything's been explained.
;;; HMM: predicates that cannot be explained given the current rule set
;;;      (e.g., (name bill2 bill)) can block progress. we could "dirty" 
;;;      the beliefs, but the current (easy) fix is to ignore beliefs that
;;;      can't be worked into the explanation.
(defun pick-belief-recency-unattached (wm kb &key (agent (wm-prime wm)))
  (let ((cfs (get-all-focus-candidates wm)))
    (or 
     (get-newest (remove-attached-beliefs cfs kb))
     (pick-random-elt cfs))))

;; turns out that this approach is related to earlier work on
;; "essential explanations" see -- Olivier Fischer, Ashok Goel, John
;; R. Svirbely, Jack W. Smith, The role of essential explanation in
;; abduction, Artificial Intelligence in Medicine, Volume 3, Issue 4,
;; August 1991, Pages 181-191, ISSN 0933-3657, DOI:
;; 10.1016/0933-3657(91)90010-9.
(defun pick-belief-fewrules-unattached (wm kb &key (agent (wm-prime wm)))
  (let ((cfs (get-all-focus-candidates wm)))
    (or 
     (get-fewest-rules (remove-attached-beliefs cfs kb) kb)
     (pick-random-elt cfs))))

;;;;;;
;; explained-belief?
;;
;; cf - a focus object
;; scope-fn - a function that determines which part of each justification will be searched
;; no-dialog? - a quick fix for dialog rules
;; 
;; returns true if cf has appeared in a justification
(defun explained-belief? (cf &key (scope-fn #'literals) (no-dialog? nil))
  (or 
   ;; get justifications within world
   (find-if #'(lambda (x) (member (belief-content (focus-belief cf)) (funcall scope-fn x) :test #'literal-equal?))
	     (filter-dialog-justifications no-dialog? (get-support (focus-belief cf) (focus-home cf))))
   ;; get justifications across worlds
   (find-if #'(lambda (x) (member (focus-modal cf) ;; specific to the current perspective, not just a question
				                   ;; of whether the belief was explained in any other modal situation.
				                   ;; somewhat arbitrary.
				  (funcall scope-fn (second x))
				  :test #'literal-equal?))
	    (belief-weak-links (focus-belief cf)))))

;;;;;;
;; antecedent-belief?
;;
;; cf - a focus object
;; 
;; returns true if cf has appeared in the antecedent of a justification
(defun antecedent-belief? (cf &key (no-dialog? nil))
  (explained-belief? cf :scope-fn #'antecedent-literals :no-dialog? no-dialog?))

;;;;;;
;; consequent-belief?
;;
;; cf - a focus object
;; 
;; returns true if cf has appeared in the consequent of a justification
(defun consequent-belief? (cf &key (no-dialog? nil))
  (explained-belief? cf :scope-fn #'consequent-literals :no-dialog? no-dialog?))

;;;;;;
;; count-matching-rules
;;
;; mlit - a modal lit
;; w - a world
;; kb - a knowledge base
;; key - a function that extracts literals from a justification
;;
;; returns the number of instantiated rules in kb where b binds to at
;; least one of the literals extracted by key.
(defun count-matching-rules (cf kb &key (key #'literals))
  (count t (mapcar #'(lambda (j) 
		       (consp (find-bindings-in-list (focus-modal cf) (funcall key j))))
		   ;; XXX: more no-dialog hacks.
		   ;;      argument b is needed solely for this hack
		   ;;
		   ;; XXX: maybe we want to use the non-modal lit in
		   ;; the future, but get-inst-rules goes by predicate
		   ;; name now.
		   (filter-dialog-justifications (dialog-hack (focus-belief cf)) (get-inst-rules (focus-modal cf) kb)))))

;;find either 
;;1. beliefs with no justification
;;2. beliefs with a justification in one direction only

;;sort by number of rules that could justify the belief.
;;pay attention to directionality.

;; this is a modification of pick-belief-fewrules-unattached to treat
;; forward and backward inferences as two separate choices. the idea
;; is that each belief should be supported if possible and should
;; provide support for other beliefs. if a belief appears in two
;; rules, in the head of one and the tail of another, then both should
;; eventually fire if we're to make the most of the knowledgebase.
;; the "uda" stands for "unnattached, direction aware"

;; NOTE: needs a version of attached-belief? that returns true only if the 
;;       belief is attached in both directions.
;;       then needs a version of get-fewest-rules that returns the number
;;       of rules that could match the belief in that unrepresented direction.

;; XXX: initial fix to avoid endless cycles around the same focus.

;; a list of beliefs to ignore when selecting a focus
;; ((cycles-to-ignore belief)(...)...)
(defvar *bad-beliefs* nil)
;; a list containing the last three beliefs
(defvar *last-3-beliefs* nil)

(defun pick-belief-fewrules-uda (wm kb &key (agent (wm-prime wm)))
  (setf *bad-beliefs* (mapcar #'(lambda (x) (list (- (first x) 1) (second x))) *bad-beliefs*))
  (setf *bad-beliefs* (delete-if #'zerop *bad-beliefs* :key #'first))
  (let* ((cfs (get-all-focus-candidates wm))
	 (uablfs (remove-attached-beliefs cfs kb))
	 (retblf (set-difference uablfs (mapcar #'second *bad-beliefs*))))
    (if retblf
	;; first, prefer beliefs that are unexplained.
	(setf retblf (get-fewest-rules retblf kb))
	(setf retblf
	      (or
	       ;; second, prefer beliefs that are unexplained in one direction.
	       (second (first (sort 
			       (remove-if #'zerop ;; drop cases with no potential rules
					  (loop for cf in (set-difference cfs (mapcar #'second *bad-beliefs*))
					     when (not (consequent-belief? cf :no-dialog? (dialog-hack (focus-belief cf))))
					     collect (list (count-matching-rules cf kb :key #'consequent-literals) cf)
					     when (not (antecedent-belief? cf :no-dialog? (dialog-hack (focus-belief cf))))
					     collect (list (count-matching-rules cf kb :key #'antecedent-literals) cf))
					  :key #'first)
			       #'< :key #'first)))
	       (pick-random-elt cfs))))
    (push retblf *last-3-beliefs*)
    (when (> (length *last-3-beliefs*) 3) 
      (setf *last-3-beliefs* (subseq *last-3-beliefs* 0 3)))
    (when (every #'(lambda (x) (equal x (first *last-3-beliefs*))) (rest *last-3-beliefs*))
      (push (list 5 retblf) *bad-beliefs*))
    retblf))
