;;;; Created on 2011-03-26 10:52:42
(in-package :tutil)

; *****************************
; ## ensure condition &rest message-items
; *****************************
; ideally, this should be rewritten as a macro 
; where condition is only evaluated in debug mode.

(defvar *error-action '(break))

(defun ensure-write (input)
  (cond ((stringp input)
         (write-string input))
    (t (write input))))

(defun ensure (condition &rest error)
  (if (not condition)
      (progn (write-string "ERROR: ")
        (dolist (X error) (ensure-write X))
        (write-line "")
        (eval *error-action))
      t))
