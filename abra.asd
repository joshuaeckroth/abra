;; abra.asd
;;
;; Defines the AbRA system and package.

;; CL-Graph provides graph data structures that support graph
;; manipulation and analysis. It also provides methods that export to
;; DOT files for use with GraphViz.
;; 
;; Installing CL-Graph:
;;   install quicklisp as directed at http://www.quicklisp.org/beta/
;;   (ql:quickload "cl-graph")

;; 
;; There may be some initial problems related to GPG keys as the
;; software is installed, but subsequent uses should be asymptomatic.
;;
;; http://common-lisp.net/project/cl-graph/
;; (require :cl-graph)

;; A set of locally available utilities that Tolga Konik provided.
(require :tutil)


(defpackage :abra
  (:use :cl 
        :asdf 
	:tutil))

(in-package :abra)

(defsystem :abra
    :name "AbRA"
    :version "0.2"
    :depends-on ()
    :pathname ""
    :components ((:module "main"
			  :serial t
			  :components ((:file "general")
				       (:file "gfs")
				       (:file "queue")
				       (:file "ec")
				       (:file "skolem")
				       (:file "variable")
				       (:file "rule")
				       (:file "literal")
				       (:file "belief")
				       (:file "justification")
				       (:file "knowledge-base")
				       (:file "working-memory")
				       (:file "world")
				       (:file "support")
				       (:file "agent")
				       (:file "deduction")
				       (:file "lookahead")
				       (:file "focus")
				       (:file "heuristics")
				       (:file "contradiction")
				       (:file "belief-revision")
				       (:file "inference")
				       (:file "display")
				       (:file "init")))
		 (:module "interface"
			  :serial t
			  :depends-on ("main")
			  :components ((:file "tinterface")
				       (:file "path")
				       (:file "kb-transformation")))
		 (:module "constraints"
			  :serial t
			  :depends-on ("interface")
			  :components ((:file "constraints")))))
