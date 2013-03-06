;;;; 2011-03-22 21:07:44
;;;;
;;;; Think of this as your project file.
;;;; Keep it up to date, and you can reload your project easily
;;;;  by right-clicking on it and selecting "Load Project"

(defpackage :unify
  (:use :cl :asdf)
  (:export
   :no-bindings 
   :subst-bindings 
   :unify 
   :variable-p))

(in-package :unify)

(defsystem unify
  :name "unify"
  :version "1.0"
  :serial t
  :components ((:file "auxfns-min")
               ;(:file "patmatch")
               (:file "unify")))
