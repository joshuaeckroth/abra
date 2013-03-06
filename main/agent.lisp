(in-package :abra)

;; generate unique ids for agents
(let ((aid 0)) 
  (defun reset-agent-id () (setf aid 0))
  (defun make-agent-id () 
    (symb "A" (incf aid))))

(defconstant +observation+ 'fact)

;; an agent has an id and contains beliefs, goals, and intentions.
;; the agent also has a list of visible sources. agents cannot inherit
;; beliefs derived directly from observation unless they can see the
;; source. inferred beliefs are inherited directly.
;;
;; carol's model for bob and alice's model of bob would have the same
;; name, but different ids
(defclass agent ()
  ((parent :initform nil :accessor agent-parent)                ;; the world that contains this agent
   (beliefs :reader agent-beliefs)       ;; belief world
   (goals :reader agent-goals)           ;; goal world
   (intentions :reader agent-intentions) ;; intention world
   (sources :initform nil :accessor agent-sources)              ;; list of sources that this agent can see
   (name :initarg :name :accessor agent-name)                   ;; agents may have a name
   (id :initform (make-agent-id) :reader agent-id)))            ;; the unique identifier for this agent model

(defmethod initialize-instance :after ((a agent) &key)
  (let ((name (agent-name a)))
    (setf (slot-value a 'beliefs) (make-world :name (symb name ".B") :parent a)
	  (slot-value a 'goals) (make-world :name (symb name ".G") :parent a)
	  (slot-value a 'intentions) (make-world :name (symb name ".I") :parent a)
	  ;; TODO: temporary solution for eventual support of multiple sources
	  ;;       of information. for dialog, we can assume that there's a single
	  ;;       external agent that is feeding us all our observations.
	  (slot-value a 'sources) (list +observation+))
    a))
  
(defun agent? (a) (typep a 'agent))

(defmethod print-object ((a agent) stream)
  (format stream "#A:~A(~A)" 
	  (agent-id a) 
	  (if (slot-boundp a 'name)
	      (agent-name a)
	      "")))

;; returns a tree of agent models
(defun agent-tree (agt)
  (cons agt (mapcar #'agent-tree (nested-agents agt))))


;; returns a tree of the form
;; (agent (world (agent (world...) agent (world...))...) (world...))
(defun world-tree (agt)
  (list 
   agt
   (cons (agent-beliefs agt) 
	 (mapcar #'world-tree  (world-agents (agent-beliefs agt))))
   (cons (agent-goals agt) 
	 (mapcar #'world-tree  (world-agents (agent-goals agt))))
   (cons (agent-intentions agt) 
	 (mapcar #'world-tree  (world-agents (agent-intentions agt))))))

(defun agent-worlds (agt)
  (list (agent-beliefs agt) (agent-goals agt) (agent-intentions agt)))

(defun nested-agents (agt)
  (mappend #'world-agents (agent-worlds agt)))

;; takes a modal literal and creates the agents if necessary.  returns
;; a list of the agent-models referred to in the literal.
;;
;; essentially a no-op if any of the agents is a skolem.
(defun introduce-agents (lit agt wm)
  (let ((modals (list-modals lit))
	(agent-names (list-agents lit)))
    (unless (or (null agent-names) (find-if #'skolem? agent-names))
      ;; assume that the literal is actually (BELIEF AGT-NAME LIT)
      ;; unless it explicitly begins (GOAL AGT-NAME LIT) or 
      ;; (INTENTION AGT-NAME LIT)
      (if (eq (agent-name agt) (first agent-names))
	  (setf agent-names (rest agent-names))
	  (push +belief+ modals))
      (introduce-agents-h agt modals agent-names wm))))

(defun introduce-agents-h (agt modals agents wm)
  (unless (or (null modals) (null agents))
    (let* ((modal-world (modal-to-world (first modals) agt))
	   (agent-model (find (first agents) (world-agents modal-world) :key #'agent-name)))
      (cond  (agent-model
	      (cons agent-model (introduce-agents-h agent-model (rest modals) (rest agents) wm)))
	     (t
	      (let ((new-agent (make-agent :name (first agents))))
		(nest-agent new-agent modal-world)
		(add-agent new-agent wm)
		(cons new-agent (introduce-agents-h new-agent (rest modals) (rest agents) wm))))))))

;; creates a new agent model with the given name.
(defun make-agent (&key (name 'self))
  (make-instance 'agent :name name))

(defmethod parent-partition ((a agent))
  (agent-parent a))

(defun get-worlds (a)
  (list (agent-beliefs a) (agent-goals a) (agent-intentions a)))	 

;;; nest-agent
;;;
;;; agt - the agent that we're nesting
;;; base - the parent world that will hold the nested agent
;;;
;;; the base world is said to believe that the agent specified by
;;; agt believes its contents. (B base (B agt X))
(defun nest-agent (agt base)
  (push agt (world-agents base))
  (setf (agent-parent agt) base))

;;; fact?
;;;
;;; b - a belief
;;; agt - an agent
;;;
;;; b is a fact with respect to an agent if b comes from one of
;;; agent's sources and b is not locally overridden.
(defmethod fact? (b (agt agent) &optional mode)
  (let (wrld)
    (cond ((eq mode +goal+) (setf wrld (agent-goals agt)))
      ((eq mode +intention+) (setf wrld (agent-intentions agt)))
      (t (setf wrld (agent-beliefs agt))))
    (and (find (belief-source b) (agent-sources agt))
	 (not (overridden-belief b wrld)))))

;;; expand-modals
;;;
;;; takes a belief, an agent, and the home world of the belief
;;; traces the path from agent to belief
;;; returns the content of the belief with the modal information tacked on
(defmethod expand-modals ((b belief) (a agent) (bh world))
  (let* ((cur-agent (world-parent bh))
	 (modal (world-to-modal bh cur-agent))
	 (agt-parent (agent-parent cur-agent)))
    (when modal
      (let ((local-modal (list modal (agent-name cur-agent) (belief-content b))))
	(if (and agt-parent (not (equal a cur-agent)))
	    (expand-modals-recur local-modal a agt-parent)
	    local-modal)))))

(defun world-to-modal (w a)
  (cond ((eq (agent-beliefs a) w) +belief+)
	((eq (agent-goals a) w) +goal+)
	((eq (agent-intentions a) w) +intention+)))

(defun modal-to-world (m a)
  (cond ((eq +belief+ m) (agent-beliefs a))
	((eq +goal+ m) (agent-goals a))
	((eq +intention+ m) (agent-intentions a))))

(defun expand-modals-recur (lit top-agt cur-wrld)
  (unless (null cur-wrld) ;; oops, there wasn't a path
    (let* ((cur-agt (world-parent cur-wrld))
	   (local-modal (list (world-to-modal cur-wrld cur-agt) (agent-name cur-agt) lit)))
      (if (eq top-agt cur-agt) ;; done
	  local-modal
	  (expand-modals-recur local-modal top-agt (agent-parent cur-agt))))))
      


;;; get-justifications
;;;
;;; a - agent
;;;
;;; returns all justifications in an agent's belief world (for now).
(defmethod get-justifications ((a agent))
  (get-justifications (agent-beliefs a)))

(defun get-beliefs (a &optional (recur t))
  (get-local-beliefs (agent-beliefs a)))

(defun get-goals (a &optional (recur t))
  (get-local-beliefs (agent-goals a)))

(defun get-intentions (a &optional (recur t)) 
  (get-local-beliefs (agent-intentions a)))


;;; get the beliefs of the top agent with the world info
;;; look at nested agents and get their beliefs with their world info
;;;   copy each nested belief and replace the world info with each of
;;;   the agents above the current one in the hierarchy so that the 
;;;   belief is viewed from each of their perspectives.
(defun expand-agents (wbs pas)
  (let (new-wbs)
    (dolist (pa pas (append wbs new-wbs))
      (dolist (wb wbs)
	(push (list pa (second wb)) new-wbs)))))

(defun get-nested-beliefs (agt &optional parent-worlds)
  (let ((nested-agents (nested-agents agt)))
    (cond (nested-agents
	   (append (expand-agents (get-agent-beliefs agt) parent-worlds)
		   (mappend #'(lambda (na) (get-nested-beliefs na (cons (agent-parent na) parent-worlds)))
			    nested-agents)))
	  (parent-worlds 
	   (expand-agents (get-agent-beliefs agt) parent-worlds))
	  (t
	   (get-agent-beliefs agt)))))

(defun get-nested-justifications (agt &optional parent-worlds)
  (let ((nested-agents (nested-agents agt)))
    (cond (nested-agents
	   (append (get-agent-justifications agt)
		   (mappend #'(lambda (na) (get-nested-justifications na (cons (agent-parent na) parent-worlds)))
			    nested-agents)))
	  (parent-worlds 
	   (get-agent-justifications agt))
	  (t
	   (get-agent-justifications agt)))))

(defun get-agent-beliefs (agt)
  (funcall #'append 
	   (get-beliefs agt) 
	   (get-goals agt)
	   (get-intentions agt)))

(defun get-agent-justifications (agt)
  (funcall #'append 
	   (get-justifications (agent-beliefs agt))
	   (get-justifications (agent-goals agt))
	   (get-justifications (agent-intentions agt))))

;;;;;
;; Assume: all mentioned agents exist.
;;         no skolemized agents.
;;         modal literals refer to the beliefs of the given agent (or 
;;         parent agent of the given world) unless explicitly given.
;;
;; TODO: create new agents on the fly (see note at resolve-world agt)
(defmethod resolve-world (lit (obj null))
  nil)

;;; resolve-world
;;; 
;;; lit - a literal
;;; wrld - a world
;;;
;;; amodal literals resolve to the world
;;; modal literals punt to their parent agent
(defmethod resolve-world (lit (wrld world))
  (if (not (modal-lit? lit))
      (list wrld)
      (resolve-world lit (world-parent wrld))))

(defmethod resolve-world (lit (agt agent))
  (if (or (not (modal-lit? lit))
	  (not (eql (agent-name agt) (modal-agent lit))))
      ;; if the literal doesn't mention the agent whose perspective
      ;; we're taking, then the default modality in the context of
      ;; that agent is one of belief.
      (resolve-world (list +belief+ (agent-name agt) lit) agt)
      (let ((m-wrld (modal-to-world (modality lit) agt)))
	(if (modal-lit? (modal-content lit))
	    (cons agt (resolve-world (modal-content lit) ;; XXX: this guy will need to create new agents if they don't exist
				     (find (modal-agent (modal-content lit)) (world-agents m-wrld) :key #'agent-name)))
	    (cons agt (resolve-world (modal-content lit) m-wrld))))))

(defun test-rw-1 ()
;; 1 -> 2 -> 4
;; 1 -> 3 -> 4
  (initialize)
  (let ((agt1 (make-agent :name 'agt1))
	(agt2 (make-agent :name 'agt2))
	(agt3 (make-agent :name 'agt3))
	(agt4 (make-agent :name 'agt4))
	(agt4a (make-agent :name 'agt4)))
    (nest-agent agt2 (agent-beliefs agt1))
    (nest-agent agt3 (agent-beliefs agt1))
    (nest-agent agt4 (agent-beliefs agt2))
    (nest-agent agt4a (agent-beliefs agt3))
    
    ;; (#A:A258(AGT1) #A:A259(AGT2) #W:W7(AGT2.B)) 
    ;; (#A:A258(AGT1) #A:A259(AGT2) #A:A261(AGT4) #W:W14(AGT4.G)) 
    ;; (#A:A258(AGT1) #A:A260(AGT3) #A:A262(AGT4) #W:W17(AGT4.G)) 
    (print (resolve-world '(belief agt2 (q a b)) agt1))
    (print (resolve-world `(belief agt2 (goal agt4 (q a b))) agt1))
    (print (resolve-world `(belief agt3 (goal agt4 (q a b))) agt1))))


(defun test-fb-1 ()
;; 1 -> 2 -> 3 -> 2
;; 1 -> 3 -> 2 -> 3
;; 1 -> 2 -> 3 -> 1
  (initialize)
  (let ((agt1 (make-agent :name 'agt1))
	(agt2a (make-agent :name 'agt2))
	(agt3ab (make-agent :name 'agt3))
	(agt2abc (make-agent :name 'agt2))
	(agt3a (make-agent :name 'agt3))
	(agt2ab (make-agent :name 'agt2))
	(agt3abc (make-agent :name 'agt3))
	(agt1abc (make-agent :name 'agt1)))

    (nest-agent agt2a (agent-beliefs agt1))
    (nest-agent agt3a (agent-beliefs agt1))

    (nest-agent agt3ab (agent-beliefs agt2a))
    (nest-agent agt2ab (agent-beliefs agt3a))

    (nest-agent agt2abc (agent-beliefs agt3ab))
    (nest-agent agt3abc (agent-beliefs agt2ab))
    (nest-agent agt1abc (agent-beliefs agt2ab))

    (believe '(P A B) (agent-beliefs agt1) wm)
    (believe '(Q A B) (agent-goals agt1) wm)
    (believe '(R A B) (agent-intentions agt1) wm)
    
    (believe '(not (P A B)) (agent-beliefs agt2ab) wm)
    (believe (strip-modals x) (first (base-worlds (resolve-world x agt1))) wm 'spoken)

    (print (resolve-world '(P A B) agt1))

))

(defun test-ia (lit)
  (initialize)
  (let (agt)
    (format t "TEST INTRODUCTION OF AGENTS~%")
    (format t "-----------------------------------------------~%")
    (format t "LITERAL: ~A~%" lit)
    (setf agt (wm-prime wm)) ;; self
    (format t "TOP AGENT: ~A~%" agt)
    (format t "NEW AGENTS: ~A~%" (introduce-agents lit agt wm))
    (format t "RESOLVE LIT: ~A~%" (resolve-world lit agt))
    (format t "-----------------------------------------------~%"))
)

#|
TEST INTRODUCTION OF AGENTS
-----------------------------------------------
LITERAL: (BELIEF SELF (BELIEF TOM (BELIEF GEORGE (GOAL TEDDY (BELIEF SELF (X ARG))))))
TOP AGENT: #A:A1(SELF)
NEW AGENTS: (#A:A2(TOM) #A:A3(GEORGE) #A:A4(TEDDY) #A:A5(SELF))
RESOLVE LIT: (#A:A1(SELF) #A:A2(TOM) #A:A3(GEORGE) #A:A4(TEDDY) #A:A5(SELF) #W:W13(SELF.B))
-----------------------------------------------
|#
(defun test-ia-1 ()
  (test-ia '(belief self (belief tom (belief george (goal teddy (belief self (x arg))))))))
  