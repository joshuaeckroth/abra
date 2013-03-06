(in-package :abra)

;;;; BELIEFS
;;
;; Beliefs are the elements of working memory. They are unique and
;; they have logical content. Beliefs are not to be confused with
;; literals modified by a belief modal. In this version of the code,
;; goals, intentions, observations, and beliefs, are all stored using
;; the belief structure. If I ever refactor the code, I plan to rename
;; the structure something more generic like "element".
;; 
;; historical note: Originally, I had planned to distinguish goals,
;; intentions, beliefs, etc. by having different types of worlds that
;; would house different types of elements. My latest thoughts are
;; that all the elements in all the worlds are identical and the
;; modality of the elements are determined by the relationships that
;; link worlds to one another.

;;; support the creation of unique belief identifiers
(let ((bid 0)) 
  (defun reset-belief-id () (setf bid 0))
  (defun make-belief-id () 
    (symb "B" (incf bid))))

(defun print-belief (b str d)
  (declare (ignore d))
  (format str "(~A ~A)" (belief-id b) (belief-content b) ))

(defstruct (belief (:conc-name belief-)
		   (:print-function print-belief)
		   (:predicate belief?))
  (id (make-belief-id) :type symbol :read-only t)
  (content nil)
  (source nil)
  (weak-links nil) ;; justifications used by other agents that rely on this belief
                   ;; ((wrld jst) (wrld jst) ...)
  (start nil)
  (end nil))

;; tests if the content of the belief is negated.  this only considers
;; the outermost context of the belief and does not drill down into
;; modals.
(defun belief-negated? (b)
  (negated? (belief-content b)))

;; tests if two beliefs contradict each other.
(defun belief-contradiction? (b1 b2)
  (literal-contradiction? (belief-content b1) (belief-content b2)))
