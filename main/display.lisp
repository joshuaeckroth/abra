(in-package :abra)

;;;;; 
;;;;; Display code
;;;;; 

;;; General display code for presenting the beliefs and justifications
;;; associated with particular agents.



(defun print-agent (agent)
  (format t "Agent ~A:~%" (agent-name agent))
  (format t "Observations:~%")
  (dolist (i (get-beliefs agent))
    (when (fact? (second i) agent)
      (format t "~T~A~%" (second i))))
  
  (format t "Assumptions:~%")
  (dolist (i (get-beliefs agent))
    (unless (fact? (second i) agent)
      (format t "~T~A~%" (second i))))
  
  (format t "Goals:~%")
  (dolist (i (get-goals agent))
    (format t "~T~A~%" (second i)))
  
  (format t "Intentions:~%")
  (dolist (i (get-intentions agent))
    (format t "~T~A~%" (second i)))
  
  (dolist (i (get-justifications agent))
    (format t "~%~%~A supports: ~A" (justification-id i) 
	    (sort (mapcar #'(lambda (x) (belief-id (second x))) (get-supported-beliefs i (agent-beliefs agent)))
		  #'string< :key #'symbol-name))
    (pprint  i)))


;;; Generate a DOT file for use with Graphviz or other DOT interpreters.

(defun output-dot (wm &key (file-name "foo.dot") (show-worlds? t))
  (with-open-file (str (make-pathname :name file-name)
			 :direction :output :if-exists :supersede)
    (format str (build-dot-string wm show-worlds?))))

(defun dot-header (&optional (show-worlds? nil))
  (let ((base "digraph G {~%size=\"10,10\";concentrate=true;rankdir=LR;edge[dir=none];ranksep=\"0.9\";~%"))
    (if show-worlds?
	(concatenate 'string base "clusterrank=local;~%")
	(concatenate 'string base "clusterrank=global;~%"))))

(defun dot-tail (&optional show-worlds?) "}~%")

(defun dot-start-world (name &optional show-worlds?)
  (format nil "subgraph cluster~A {~%label = \"~A\"; color=black;~% edge[dir=none];~%" 
	  (remove #\. (symbol-name name)) name))

(defun dot-end-world (&optional show-worlds?) "}~%")

(defun dot-edge (src-id tgt-id)
  (format nil "~A -> ~A;~%" src-id tgt-id))

(defun dot-belief (blf)
  (format nil "~A [label=\"~A\"];~%" (belief-id blf) (belief-content blf)))

(defun build-dot-string (wm show-worlds?)
  (let ((s (dot-header show-worlds?)))
    (concatenate 'string 
		 (concatenate 'string s (beliefs-to-dot wm show-worlds?))
		 (dot-tail))))

(defun beliefs-to-dot (wm &optional (show-worlds? nil))
  (let ((s (make-string 0))
	(lnks '())
	(ht (make-hash-table)))
    ;; build the string that describes each world subgraph
    (loop for w being the hash-values of (wm-worlds wm)
       do (multiple-value-bind (x y) (world-to-dot w)
	    (setf lnks (append y lnks)) ;; fresh with side effects!!
	    (setf s (concatenate 'string s x))))

    ;; build cross-world links
    (dolist (k lnks)
      (unless (or (member (first k) (gethash (second k) ht))
		  (member (second k) (gethash (first k) ht)))
	(push (second k) (gethash (first k) ht))))
    
    ;; build the string for the cross-world links
    (loop for k being the hash-keys of ht
	 do 
	 (dolist (x (gethash k ht))
	   (setf s (concatenate 'string s (dot-edge k x)))))
    s))

(defun world-to-dot (w)
  ;; map justifications in wrld to beliefs in wrld
  ;; ignore beliefs in other worlds
  (let ((local (make-hash-table)) distant s)
    (dolist (j (get-justifications w))
      (let ((bfs (get-supported-beliefs j w)))
	(dolist (b1 bfs)
	  (dolist (b2 bfs)
	    (if (and (eql (car b1) w) (eql (car b2) w))
		(unless (or (eql (second b1) (second b2))
			    (member (second b2) (gethash (second b1) local))
			    (member (second b1) (gethash (second b2) local)))
		  (push (second b2) (gethash (second b1) local)))
		(unless (eql (second b1) (second b2))
		  (push (list (belief-id (second b1)) (belief-id (second b2))) distant)))))))
    (setf s (dot-start-world (world-name w)))
    (dolist (k (hash-table-keys local))
      (dolist (x (gethash k local))
	(setf s (concatenate 'string s (dot-edge (belief-id k) (belief-id x))))))
    (dolist (wb (get-local-beliefs w))
      (setf s (concatenate 'string s (dot-belief (second wb)))))
    (values (concatenate 'string s (dot-end-world)) distant)))
    

(defun output-rls (rls &key (file-name "foor.dot"))
  (with-open-file (str (make-pathname :name file-name)
			 :direction :output :if-exists :supersede)
    (format str (rules-to-dot rls))))

;; XXX: ignores modals and negation
(defun rules-to-dot (rls)
  (let ((s (format nil
		   "digraph G {~%size=\"10,10\";concentrate=true;rankdir=LR;edge[dir=none];ranksep=\"0.9\";~%"))
	(ht (make-hash-table)))
    ;; build a triangular adjacency matrix based on the predicates that appear in each rule.
    (dolist (r rls)
      (let ((pds (list-predicates r)))
	(dolist (p1 pds)
	  (dolist (p2 pds)
	    (unless (or (eql (first p1) (first p2))
			(member (first p2) (gethash (first p1) ht))
			(member (first p1) (gethash (first p2) ht)))
	      (push (first p2) (gethash (first p1) ht)))))))

    ;; print the connections.
    (dolist (k (hash-table-keys ht))
      (dolist (x (gethash k ht))
	(setf s (concatenate 'string s (format nil "\"~A\" -> \"~A\";~%" k x)))))

    ;; close the string.
    (concatenate 'string s (format nil "}~%"))))


;;; Generate a GML file for graph viewers like Cytoscape

(defun gml-header (&optional show-worlds?) "graph [~%")

(defun gml-tail (&optional show-worlds?) "]~%")

(defun output-gml (wm &key (file-name "foo.gml"))
  (with-open-file (str (make-pathname :name file-name)
			 :direction :output :if-exists :supersede)
    (format str (beliefs-to-gml wm))))


(defun beliefs-to-gml (wm)
  (let ((s (format nil "graph [~%"))
	(lnks '())
	(ht (make-hash-table)))

    ;; build the string that describes each world subgraph
    (loop for w being the hash-values of (wm-worlds wm)
       do (multiple-value-bind (x y) (world-to-gml w)
	    (setf lnks (append y lnks)) ;; fresh with side effects!!
	    (setf s (concatenate 'string s x))))

    ;; build cross-world links
    (dolist (k lnks)
      (unless (or (member (first k) (gethash (second k) ht))
		  (member (second k) (gethash (first k) ht)))
	(push (second k) (gethash (first k) ht))))
    
    ;; build the string for the cross-world links
    (loop for k being the hash-keys of ht
	 do 
	 (dolist (x (gethash k ht))
	   (setf s (concatenate 'string s (gen-gml-edge-string k x)))))
    (concatenate 'string s (format nil "]~%"))))

(defun world-to-gml (w)
  ;; map justifications in wrld to beliefs in wrld
  ;; ignore beliefs in other worlds
  (let ((local (make-hash-table)) distant s)
    (dolist (wb (get-local-beliefs w))
      (setf s (concatenate 'string s (gen-gml-node-string wb))))
    (dolist (j (get-justifications w))
      (let ((bfs (get-supported-beliefs j w)))
	(dolist (b1 bfs)
	  (dolist (b2 bfs)
	    (if (and (eql (car b1) w) (eql (car b2) w))
		(unless (or (eql (second b1) (second b2))
			    (member (second b2) (gethash (second b1) local))
			    (member (second b1) (gethash (second b2) local)))
		  (push (second b2) (gethash (second b1) local)))
		(unless (eql (second b1) (second b2))
		  (push (list (belief-id (second b1)) (belief-id (second b2))) distant)))))))
    (dolist (k (hash-table-keys local))
      (dolist (x (gethash k local))
	(setf s (concatenate 'string s (gen-gml-edge-string (belief-id k) (belief-id x))))))
    (values s distant)))

(defun gen-gml-edge-string (id1 id2) 
  (format nil "~Tedge [~%~T~Tsource ~A~%~T~Ttarget ~A~%~T]~%"  (string-trim "B" (symbol-name id1))  (string-trim "B" (symbol-name id2))))

(defun gen-gml-node-string (wb)
  (format nil "~Tnode [~%~T~Tid ~A~%~T~Tlabel \"~A\"~%~T~Tcontent \"~A\"~%~T~Tobservation \"~A\"~%~T~Tmode \"~A\"~%~T~TtopAgent \"~A\"~%~T]~%" 
	  (string-trim "B" (symbol-name (belief-id (second wb)))) ;; id -- cytoscape needs integers
	  (belief-id (second wb)) ;; label
	  (belief-content (second wb)) ;; content -- in case this isn't unique
	  (if (member (first wb) (mapcar #'second (world-obs-worlds (wm-prime  wm)))) "true" "false") ;; observation
	  (let ((mode (char (symbol-name (predicate-name (belief-content (second wb)))) 0)))
	    (cond ((member (first wb) (mapcar #'second (world-obs-worlds (wm-prime  wm)))) "observation") 
		  ;; treat all observations as actions for network display purposes. 
		  ((eql mode #\B) "belief")
		  ((eql mode #\G) "goal")
		  ((eql mode #\I) "intention")
		  ;;((eql mode #\*) "action")
		  (t "unknown"))) ;; top level modality
	  (first (literal-args (belief-content (second wb)))) ;; the top level agent
	  ))
