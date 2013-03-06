;;;; 2011-03-22 21:07:44
;;;;
;;;; Think of this as your project file.
;;;; Keep it up to date, and you can reload your project easily
;;;;  by right-clicking on it and selecting "Load Project"

(require "unify")

(defpackage :tutil
  (:use :cl :asdf)
  (:use :cl :unify)
  (:export 
    ; Structures
    :split
    :bagof
    :traverse-tree
    :mapcar-tree
    :mapc-tree
    :substitute-tree
    :random-n-subset 
    
    ;Logical
    :fire-rules
    :fire-rule
    :constraints-violated
    :unify
    :collect-vars
    :match-condition
    :match-conditions
    :match-state
    :unify-all
    
    
    ;Files
    :replace-file
    :to-file
    :append-file
    :match-conditions
    :fire-rule
    
    ;Sets 
    :list-to-set
    ))

(in-package :tutil)

(defsystem tutil
  :name "Tolga's Utilities"
  :version "1.0"
  :serial t
  :components ((:file "debugging")
               (:file "file-io")
               (:file "sets")
               (:file "structures")               
               (:file "logical")
               (:file "icarus")
               (:file "others")))