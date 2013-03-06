;;;; Created on 2011-03-26 10:56:56

(in-package :tutil)

; *****************************
; ## (list-to-set list);
; *****************************

(defun list-to-set (list)
  (let ((set nil))
    (dolist (X list)
      (setf set (adjoin-equal X set)))
    
    set))

(defun member-equal (x y)
  (member x y :test #'equal))

(defun intersection-equal (x y)
  (intersection x y :test #'equal))

(defun set-difference-equal (x y)
  (set-difference x y :test #'equal))

(defun union-equal (x y)
  (union x y :test #'equal))

(defun adjoin-equal (x y)
  (adjoin x y :test #'equal))

; ## *****************************************

