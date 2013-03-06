(in-package :abra)

;;;; VARIABLES
;;
;; Variables only appear in the rules that compose the system's
;; background knowledge. They are represented as symbols that begin
;; with a '?'. Currently all variables are universally quantified.

;; input:
;;   x - a symbol
;;   
;; output:
;;   t - when x is a variable (is a symbol that begins with '?')
(defun variable? (x)
  (and (symbolp x)
       (char= (char (symbol-name x) 0) #\?)))