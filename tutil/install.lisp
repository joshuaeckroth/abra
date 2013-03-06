;;;; Created on 2011-03-23 13:47:38

(in-package :cl)

(write "Registering Tolga Util Folder")(terpri)
(require :asdf)

(push (make-pathname 
       :directory (pathname-directory *load-truename*)) 
      asdf:*central-registry*)

(load
 (make-pathname :name "install"
                :type "lisp"
                :directory (append (pathname-directory *load-truename*)
                                   (list "unify"))   
                :defaults *load-truename*))