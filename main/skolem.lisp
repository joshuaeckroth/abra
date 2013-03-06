(in-package :abra)

;;;; SKOLEM CONSTANTS
;;
;; Skolems are unique identifiers for objects not yet attached to 
;; an item, event, relationship, etc. from the world. They act as
;; placeholders in justifications and may be replaced by domain
;; constants when possible.

;; Generate the unique identifier for a Skolem.
(let ((skid 0))
  (defun reset-skolem-id () (setf skid 0))
  (defun get-skolem-id () (symb "SK" (incf skid))))

;; input:
;;   sk - a Skolem
;;   str - a format stream
;;   d - depth
;;
;; Prints the name of the Skolem to the stream.
(defun print-skolem (sk str d)
  (declare (ignore d))
  (format str "~A" (sk-id sk)))

;; Defines a Skolem constant as a specific type.
(defstruct (skolem (:conc-name sk-)
		   (:print-function print-skolem)
		   (:predicate skolem?))
  (id (get-skolem-id) :type symbol :read-only t))

;; input:
;;   sk1, sk2 - Skolems
;;
;; output:
;;   t - when two skolems have the same name.
(defun skolem-equal? (sk1 sk2)
  (and (skolem? sk1) (skolem? sk2)
       (eq (sk-id sk1) (sk-id sk2))))