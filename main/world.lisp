(in-package :abra)

;;;; WORLDS

;;;; Worlds are complicated creatures. Their primary purpose is to
;;;; store beliefs, but they can also store justifications. Worlds can
;;;; connect with each other in numerous ways.
;;;;
;;;; Importing: Importing world A into world B makes A's beliefs
;;;; visible to B. The relationship is designed to be one level
;;;; deep. An agent world may import a sense world, or a goal world
;;;; may import an agent world. The justifications, if any, are not
;;;; carried over. If the imported world imports other worlds, those
;;;; beliefs are not carried over. As a result, a goal world may need
;;;; to import its agent world and the sense worlds imported by the
;;;; agent. The more effective approach is for the goal world to ask
;;;; the agent world for a snapshot of all its beliefs. (The final
;;;; behavior in this case is to be determined, but one layered
;;;; imports with sensor worlds are well defined.)
;;;; 
;;;; Believing: World A may believe that world B reflects a particular
;;;; agent's beliefs. 
;;;;
;;;; History: When a world "unbelieves" something, it places the
;;;; belief in its history table. If the world owns the belief, then
;;;; the belief is given an end time and stored away. If the belief is
;;;; imported then a copy of the belief (with the same ID) is stored
;;;; away with a time stamp. Whenever the system uses a belief from an
;;;; imported world, it first checks in the history to ensure that the
;;;; belief has not been overridden. (It's too early in the project to
;;;; tell, but this may only occur when there's an explicit negation
;;;; that drives the belief to obsolescence. However, we could build
;;;; support for forgetfulness whereby old, weak beliefs are scrubbed
;;;; away.)

;; generate unique ids for worlds
(let ((wid 0)) 
  (defun reset-world-id () (setf wid 0))
  (defun make-world-id () 
    (symb "W" (incf wid))))


;; a world contains beliefs, the justifications for those beliefs, and
;; an identifier.
(defclass world ()
  ((elmnts :initform (make-ec) :reader world-elmnts)           ;; beliefs
   (bs :initform (make-bs) :reader world-bs)                   ;; justifications
   (agents :initform () :accessor world-agents)                ;; nested models of other agents (to support (B A1 (B A2 X)), etc.)
   (history :initform (make-hash-table) :reader world-history) ;; belief id ==> belief
   (id :initform (make-world-id) :reader world-id)
   (name :initarg :name :accessor world-name)
   (parent :initarg :parent :accessor world-parent)))

(defun world? (w) (typep w 'world))

(defmethod print-object ((w world) stream)
  (format stream "#W:~A(~A)" (world-id w) (world-name w)))

(defun make-world (&key (name nil) (parent nil))
  (make-instance 'world :name name :parent parent))

(defmethod parent-partition ((w world))
  (world-parent w))
 
(defmethod fact? (b (w world) &optional mode)
  (fact? b (world-parent w) mode))

;;; expand-modals
;;;
;;; takes a belief, a world, and the home world of the belief
;;; traces the path from world to belief
;;; returns the content of the belief with the modal information tacked on
(defmethod expand-modals ((b belief) (w world) (bh world))
  (expand-modals b (world-parent w) bh))
	
;;; get-support
;;;
;;; b - a belief
;;; world - a world
;;;
;;; get the justifications that support b in world. this does not
;;; return justifications from any other worlds.
(defun get-support (b world)
  (bs-supporting-justifications b (world-bs world)))

;;; get-supported-beliefs
;;;
;;; j - a justification
;;; world - a world
;;;
;;; get the world--belief tuples for the beliefs supported by j.
(defun get-supported-beliefs (j world)
  (bs-supported-beliefs j (world-bs world)))

;;; NOTE: only grabs beliefs within the same world as b
;;; b - a belief
;;; world - b's home world
(defun connected-beliefs (b world)
  (remove-duplicates (mapcar #'second (mappend #'(lambda (j) (get-supported-beliefs j world)) (get-support b world)))))

;; returns antecedent beliefs from justifications that have b as a consequent
(defun antecedent-connected-beliefs (b world)
  (remove-duplicates 
   (mappend #'(lambda (j) 
		(remove-if-not #'(lambda (tmpb) 
				   (member (belief-content tmpb) 
					   (mapcar #'strip-modals (antecedent-literals j)) 
					   :test #'literal-equal?))
			       (mapcar #'second (get-supported-beliefs j world)))) 
		    (get-support b world))))



;;; add-if-no-contradiction
;;;
;;; b - a belief
;;; ht - a hash table that maps predicates to beliefs
;;;
;;; adds a belief to the hash table if (a) it isn't already in the
;;; hash table and (b) it's contradiction isn't already in the hash
;;; table.
(defun add-if-no-contradiction (b ht)
  (unless (find-if #'(lambda (y) (or (eq b y) (belief-contradiction? b y)))
		   (gethash (predicate-name (belief-content b)) ht))
    (push b (gethash (predicate-name (belief-content b)) ht))))

;;; get-observed-beliefs
;;;
;;; w - a world
;;;
;;; returns a list of world--belief tuples containing all the beliefs in
;;; worlds observed by w that do not
;;;   (a) appear in the history of w as items no longer believed
;;;   (b) appear explicitly negated in w as items where the contradiction is believed
(defun get-observed-beliefs (w)
  (remove-if #'(lambda (ob) (overridden-belief (second ob) w))
	     (mappend #'(lambda (o) 
			  (mapcar #'(lambda (x) (list (second o) x))
				  (ec-get-all (world-elmnts (second o)))))
		      (world-obs-worlds w))))

;; returns all beliefs tagged as a fact in the specified world.
(defun get-facts (w)
  (filter #'(lambda (b) (fact? b w)) (ec-get-all (world-elmnts w))))

;;; overridden-belief 
;;;
;;; w - a world
;;; b - a belief
;;;
;;; a belief is overridden if it appears in the history of a world or
;;; if its negation appears in the world.
(defun overridden-belief (b w)
  (or (gethash (belief-id b) (world-history w))
      (find-local-belief (belief-content b) w t)))

;;; get-local-belief
;;; 
;;; id - a belief identifier
;;; wrld - the world to search
;;;
;;; returns the belief with specified by id if it is housed within
;;; wrld. does not follow links to other worlds.
(defun get-local-belief (id wrld)
  (ec-get-element id (world-elmnts wrld)))

;;; get-local-beliefs
;;;
;;; wrld - a world
;;; 
;;; returns a list of world--belief tuples containing the beliefs that
;;; exist within wrld. does not follow links to other worlds.
(defun get-local-beliefs (wrld)
  (mapcar #'(lambda (x) (list wrld x)) (ec-get-all (world-elmnts wrld))))

;;; get-justification
;;;
;;; jid - the identifier for a justification
;;; wrld - a world
;;;
;;; returns the justification specified jid if it appears in
;;; wrld. this function searches locally and will not track down
;;; justifications in other worlds.
(defun get-justification (jid wrld)
  (bs-get-justification jid (world-bs wrld)))

;;; get-justifications
;;;
;;; wrld - a world
;;;
;;; returns all justifications in wrld.
(defmethod get-justifications ((wrld world))
  (bs-get-all-justifications (world-bs wrld)))

;;; get-justifications
;;;
;;; wrld - a world
;;;
;;; returns all justifications in wrld with the same predicate and
;;; negation status as the literal.
(defun get-lit-justifications (lit wrld)
  (bs-get-justifications lit (world-bs wrld)))

;;; uses-predicate?
;;;
;;; p - predicate name
;;; neg? - negation state
;;; wrld - a world
;;;
;;; returns true if the predicate appears as some belief within the world.
(defun uses-predicate? (p neg? wrld)
  (not (null (get-beliefs-by-predicate p neg? wrld))))

;;; get-beliefs-by-predicate
;;;
;;; p - predicate name
;;; neg? - negation state
;;; wrld - a world
;;;
;;; returns the beliefs that use the given predicate.
(defun get-beliefs-by-predicate (p neg? wrld)
  (if neg? 
      (gethash p (ec-neg-pred (world-elmnts wrld)))
      (gethash p (ec-pos-pred (world-elmnts wrld)))))

;;; insert-element
;;;
;;; lit - a literal
;;; wrld - a world 
;;; 
;;; creates a belief that contains lit and adds it to wrld. the belief
;;; is given an id and a start time in the process.  
;;;
;;; returns the new belief.
(defun insert-element (lit wrld &optional (source nil))
  (let ((b (make-belief :content lit :source source :start (get-universal-time))))
    (ec-add-element b #'belief-content #'belief-id (world-elmnts wrld))))

;;; believe
;;;
;;; lit - a literal
;;; x - an agent model or a world
;;; 
;;; creates a belief that contains lit and adds it to the appropriate
;;; world using agt as the starting point. the belief is given an id
;;; and a start time in the process.
;;;
;;; returns a list containing the relevant world and the new belief.
;;; assumes all agents specified in lit are grounded.
(defun believe (lit x wm &optional (source nil))
  (if (agent? x) 
      (introduce-agents lit x wm)
      (introduce-agents lit (world-parent x) wm))
  (let ((target-world (first (base-worlds (resolve-world lit x)))))
    (list target-world (insert-element (strip-modals lit) target-world source))))

;;; get-belief-content
;;;
;;; bid - a belief identifier
;;; wrld - a world
;;;
;;; returns the belief associated with bid if it appears in wrld.
(defun get-belief-content (bid wrld)
  (when bid
    (belief-content (ec-get-element bid (world-elmnts wrld)))))

;;; find-justification
;;;
;;; j - a justification
;;; wrld - a world
;;;
;;; searches for a justification in wrld that is equivalent to j and
;;; returns the result.
(defun find-justification (j wrld)
  (bs-get-justification (find-justification-id j wrld) (world-bs wrld)))

;;; find-subsumed-justification
;;;
;;; j - a justification
;;; wrld - a world
;;;
;;; searches for a justification in wrld that is directly more
;;; specific than j and returns the result.
(defun find-subsumed-justification (j wrld)
  (bs-get-justification (find-subsumed-justification-id j wrld) (world-bs wrld)))

;;; find-justification-id
;;;
;;; j - a justification
;;; wrld - a world
;;;
;;; searches for the identifier of a justification in wrld that is
;;; equivalent to j and returns the result.
(defun find-justification-id (j wrld)
  (bs-find-justification-id j (world-bs wrld)))

;;; find-subsumed-justification-id
;;;
;;; j - a justification
;;; wrld - a world
;;;
;;; searches for the identifier of a justification in wrld that is
;;; directly more specific than j and returns the result.
(defun find-subsumed-justification-id (j wrld)
  (bs-find-subsumed-justification-id j (world-bs wrld)))

;;; register-support
;;;
;;; j - a justification
;;; jw - the intended justification world
;;; b - a belief
;;; bw - the world that contains b
;;;
;;; register j as support for b in jw.
(defun register-support (j jw b bw)
  ;; update the justification
  (setf (gethash (justification-id j) (bs-supports (world-bs jw)))
	(append (gethash (justification-id j) (bs-supports (world-bs jw))) (list (list bw b))))
  ;; update the belief
  (if (eql bw jw)
      ;; within-world belief
      (setf (gethash (belief-id b) (bs-supported-by (world-bs jw)))
	    (append (gethash (belief-id b) (bs-supported-by (world-bs jw))) (list j)))
      ;; outside-world belief
      (setf (belief-weak-links b)
	    (append (belief-weak-links b) (list (list jw j))))))

;;; unbelieve
;;;
;;; b - a belief
;;; wrld - a world
;;; wm - working memory
;;;
;;; stores that wrld no longer believes b. if wrld is the home to b,
;;; then b is stashed away. otherwise, b is overridden by a local
;;; historical belief.
;;;
;;; does not check for justifications that refer to b either within
;;; wrld or in worlds connected to wrld.
(defun unbelieve (b wrld wm)
  ;; trash all the weak links
  ;; this kills the associated justifications, which may remove other beliefs
  ;; (caveat: i think this is too harsh and that it will lead to forests of 
  ;; assumptions that don't relate to any facts.)
  (dolist (lnk (belief-weak-links b))
    (dolist (b (remove-justification (second lnk) (first lnk)))
      (unbelieve b (first lnk) wm)))
  ;; if wrld isn't b's home, then copy b.
  (unless (eql wrld (belief-home b wm))
    (setq b (make-belief :id (belief-id b) :content (belief-content b)
			 :start (belief-start b))))
  ;; give b (or its copy) an end time and store it in the history.
  (setf (belief-end b) (get-universal-time))
  (setf (gethash (belief-id b) (world-history wrld)) b)
  ;; if wrld is b's home, then remove b from the list of elements.
  (when (eql (belief-home b wm) wrld)
    (ec-remove-element b #'belief-content #'belief-id (world-elmnts wrld))))

;;; fire-justification
;;;
;;; j - a justification that's not yet in this wrld
;;; jwrld - a world
;;; wm - working memory
;;;
;;; links beliefs in wrld to the literals in j, creating new beliefs
;;; if necessary. returns j and a list of world/belief pairs for any
;;; newly created beliefs.
;;
;; NOTE: Sometimes b can match multiple positions
;;       in a single justification. Superficially, 
;;       this seems bad, especially if the skolems in
;;       b enable the matches. in the rule
;;          (a sk1 sk2) => (a sk2 sk1)
;;       we should really note that these are different groundings
;;       for now, these might both bind to an existing belief
;;          (a sk3 sk4)
;;       which would lead to uninteresting consequences once
;;       domain constants enter the picture.
(defun fire-justification (j jwrld wm)
  (bs-store-justification j (world-bs jwrld))
  (let (wb belief-wb new-beliefs)
    (dolist (lit (literals j) j)
      (unless (setf wb (find-belief lit jwrld))
	(setf belief-wb (believe lit jwrld wm))
	(setf wb (list (first (base-worlds (resolve-world lit jwrld))) (second belief-wb)))
      ;;; NOTE: taking the first of the base worlds is dangerous when
      ;;;       there are multiple base worlds. that can happen when a
      ;;;       modal has a skolemized agent. "Does anyone believe x?"
      ;;;       Here we would pick the first believer that we found
      ;;;       and attach the justification to that one. The current
      ;;;       approach to handling Skolemized agents makes this a
      ;;;       non-issue (10/24/12)
	(push belief-wb new-beliefs))
      (register-support j jwrld (second wb) (first wb)))
    (values j new-beliefs)))

;;; remove-justification
;;;
;;; j - justification
;;; w - the world containing the justification
;;;  
;;; returns ids of beliefs that are no longer supported by any rules
;;; due to the removal of jid.
(defun remove-justification (j w)
  ;; drop the justification from its world
;; (print j)
  ;; XXX: the belief support doesn't know anything about worlds, so we pass it a 
  ;; predicate to let it figure out if a belief is local or not. This should 
  ;; be a temporary patch!!
  ;; beliefs may appear multiple times, but we should only return them once.
  (remove-duplicates (bs-remove-justification (justification-id j) #'(lambda (x) (eq (first x) w)) (world-bs w))))

(defun mode-of (w)
  (let ((a (parent-partition w)))
    (cond ((eq w (agent-goals a))
	   +goal+)
	  ((eq w (agent-intentions a))
	   +intention+)
	  ((eq w (agent-beliefs a))
	   +belief+))))

(defun mode-world (agt mode)
  (cond ((eq mode +belief+) (agent-beliefs agt))
	((eq mode +goal+) (agent-goals agt))
	((eq mode +intention+) (agent-intentions agt))))

;;; inheritable-worlds
;;;
;;; given a world, returns an ordered (by priority) list of
;;; all the worlds whose beliefs it can inherit.
;;;
;;; we implement two inheritance rules, both pertaining to belief.
;;; 
;; B_a1(B_a2(P)) <- B_a1(P)
;; B_a1(B_a2(G(P))) <- B_a1(G(P))
;;;
;;; the system also supports reasoning about one's goals for another
;;; agent's mental state, but these are not inherited. That is,
;; B_a1(G(B_a2(G(P)))) <- B_a1(G(P))
;;; does not hold.
(defun inheritance-chain (w)
  (when w
    (let ((upw (parent-partition (parent-partition w))))
      (cond ((null upw)
	     (cons w '()))
	    ((and (eq (mode-of upw) +belief+) ;; only inherit up the belief chain
		  (find (mode-of w) (list +belief+ +goal+))) ;; only inherit goals and beliefs
	     (cons w (inheritance-chain (mode-world (parent-partition upw) (mode-of w)))))
	    (t
	     (cons w '()))))))

;; takes the results of resolve-world and returns all the mentioned worlds.
(defun base-worlds (wtree)
  (cond ((null wtree)
	 '())
	((world? (first wtree))
	 (cons (first wtree) (base-worlds (rest wtree))))
	((agent? (first wtree))
	 (base-worlds (rest wtree)))
	((consp (first wtree))
	 (append (base-worlds (first wtree)) (base-worlds (rest wtree))))))


;;; find-belief-id
;;;
;;; finds the identifier for a belief containing the given literal
;;; that is accessible from the current world. follows import and
;;; belief relationships between worlds.
(defun find-belief-id (l x)
  (let ((b (find-belief l x)))
    (when b (belief-id b))))

;;; find-belief
;;;
;;; l - literal
;;; x - agent or world
;;; inherit? - try to inherit the belief
;;; negate? - negate the internal proposition (not the modals) before
;;;           searching.
;;;
;;; returns two values
;;; (1) the world--belief tuple if found or nil
;;; (2) t if the belief or its negation was found
;;;     nil if the belief does not exist
(defun find-belief (l x &key (inherit? t) (flip-negation? nil))
  (find-belief-h 
   (if flip-negation? (flip-negation (strip-modals l)) (strip-modals l))
   (if inherit?
       (inheritance-chain (first (base-worlds (resolve-world l x))))
       (list (first (base-worlds (resolve-world l x)))))))

;;; finds a belief in wrld that contains the given literal. if
;;; flip-sign? is true, this function looks for the negation of the
;;; literal. returns a list of the form (world belief).
(defun find-belief-h (l wlst)
  (let (wb)
    (cond ((null wlst)
	   (values nil nil))
	  ((setf wb (find-local-belief l (first wlst) nil))
	   (values wb t))
	  ((find-local-belief l (first wlst) t)
	   (values nil t))
	  (t
	   (find-belief-h l (rest wlst))))))

(defun find-local-belief (l wrld flip-sign?)
  (when flip-sign? (setq l (flip-negation l)))
  (let ((b (find-if #'(lambda (b) (literal-equal? (belief-content b) l))
		    (ec-get-elements (predicate-name l) (negated? l) (world-elmnts wrld)))))
    (when b (list wrld b))))
