(in-package :abra)

;;;; WORKING MEMORY

;;; working memory contains a table of worlds mapped to their
;;; identifiers, a reference to the world that the system believes, a
;;; reference to the world containing observations, a reference to the
;;; world that was home to the last inference,
(defclass wm ()
  ((worlds :initform (make-hash-table :test #'eq) :reader wm-worlds)
   (agents :initform (make-hash-table :test #'eq) :reader wm-agents)
   (prime :accessor wm-prime)
   (current :accessor wm-current)))

(defmethod initialize-instance :after ((wm wm) &key)
  (setf (wm-prime wm) (make-agent :name 'self)
	(wm-current wm) (wm-prime wm))
  (add-agent (wm-prime wm) wm))

;; add an agent model to the working memory.
;; doesn't connect the agent to wm-prime. 
;; nesting the agent must be handled separately.
(defun add-agent (agt wm)
  (setf (gethash (agent-id agt) (wm-agents wm)) agt)
  (mapcar #'(lambda (x) (setf (gethash (world-id x) (wm-worlds wm)) x))
	  (get-worlds agt)))

;; build, initialize, and return a new working memory.
(defun make-wm ()
  (make-instance 'wm))

;; get the agent model with the given id.
(defun get-agent (an wm)
  (gethash an (wm-agents wm)))

;; get the world with the given name
(defun get-world (wn wm)
  (gethash wn (wm-worlds wm)))

;; get the world where the belief is housed
(defun belief-home (b wm)
  (bid-home (belief-id b) wm))

;; returns the world where the belief appears
(defun bid-home (bid wm)
  (loop for w being the hash-values of (wm-worlds wm)
     when (get-local-belief bid w)
     return w))

;; returns a list of worlds where the belief appears
(defun bid-homes (bid wm)
  (loop for w being the hash-values of (wm-worlds wm)
     when (get-local-belief bid w)
     collect w))

;; get the world that holds the justification
(defun justification-home (j wm)
  (jid-home (justification-id j) wm))

(defun jid-home (jid wm)
  (find-if #'(lambda (w) (get-justification jid w)) (hash-table-values (wm-worlds wm))))

(defun print-bid (id wm) 
  (when (get-local-belief id (wm-prime wm))
    (format t "~%~A SUPPORT: ~A~%" id (get-support (get-local-belief id (wm-prime wm)) (wm-prime wm)))))

(defun print-jid (id wm)
  (when (get-justification id (wm-prime wm))
    (format t "~%~A SUPPORTED-BY: ~A~%" id (get-supported-beliefs (get-justification id (wm-prime wm)) (wm-prime wm)))))