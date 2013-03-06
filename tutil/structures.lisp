;;;; Created on 2011-03-26 10:54:02

(in-package :tutil)


; *****************************
; ## bagof (func list)
; *****************************

; func is a function that inputs a list element and returns a key
; (bagof #'car '( (a b c) (a 1 3) (b x 1) (c d 1) (b 2 3)))
; --> 
; 


(defun bagof (func list)
  (cond ((null list) nil)
    (t
     (let* ((key (funcall func (car list)))
            (splitresult
             (split (lambda (X) (equal (funcall func X) key)) list))
            (matched (first splitresult))
            (rest (second splitresult)))
       
       (cons (list key matched) (bagof func rest))))))




; *****************************
; split (func list) --> (satisfied, unsatisfied)
; *****************************
; for simplicity, this function is not tail recursive

(defun split (func list)
  (cond ((null list)
         '(nil nil)) ; return two empty lists
    (t
     (let* ((head (car list))
            (tail (cdr list))
            (tail-out (split func tail)))
       (if (funcall func head)
           (list (cons head (first tail-out)) (second tail-out))
           (list (first tail-out) (cons head (second tail-out))))))))


; *****************************
; mapcar-tree (func tree)
; *****************************

(defun mapcar-tree (func tree)
  (mapcar #'(lambda (X)
              (if (listp X)
                  (mapcar-tree func X)
                  (funcall func X)))
          tree))

; *****************************
; substitute-tree (x y tree)
; *****************************

(defun substitute-tree (new old storage)
  (if (equal old storage) new
      (if (listp storage)
          (mapcar  
           (lambda (X)
             (substitute-tree new old X))
           storage)
          storage)))
                
; *****************************
; mapc-tree
; *****************************

(defun mapc-tree (func tree)
  (cond ((null tree)
         nil)
    
    ((listp tree)
     (mapc-tree func (car tree))
     (mapc-tree func (cdr tree)))
    
    (t (funcall func tree))))

; *****************************
; travers-tree
; *****************************

(defun traverse-tree (func tree)
  (unless (null tree)
      (funcall func tree)
      (when(listp tree)
        (mapcar 
         (lambda (x)
           (traverse-tree func x))
         tree))))

; *****************************
; random-pick ()
; *****************************

(defun random-n-subset (n list)
  "removes n random elements from a list. Not uniform, but close when selecting small from large lis"
       (if (equal n 0)
           list
           (random-n-subset 
            (- n 1)  
            (remove 
             (nth (random (length list)) list) 
             list))))

(defun random-pick-one (list)
  (delete 
   (nth (random (length list)) list)
   list))
  
  
