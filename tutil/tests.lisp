;;;; Created on 2011-04-01 14:08:28
(in-package :tutil)

(define-test fire-rule-test
  (assert-equal 
   
   '((neq sk1 sk2))
   
   (fire-rule 
    '((on sk1 sk2))
    '((neq ?x ?y) ((on ?x ?y)))))
  
  (assert-equal
   
   '((neq a b)(neq sk1 sk3))            
   (fire-rule
    '((on a sk1)
      (on sk1 b)
      (on b sk3))
    
    '((neq ?x ?z) ((on ?x ?y)(on ?y ?z)))))
  
  ; It cannot handle this yet
  (assert-equal
   
   '((neq a b)(neq sk1 sk3))            
   (fire-rule
    '((on a sk1)
      (on sk2 b)
      (on b sk3))
    
    '((neq ?x ?z) ((on ?x ?y)(on ?y ?z)))))
  
  (assert-equal 
   '(((?Y . 2) (?X . 1) (T . T)) ((?Y . B) (?X . A) (T . T)))
   
   (match-condition '(p ?x ?y) '((p 1 2)(p a b))))
  
  (assert-equal
   
   '(P 1 2)
   (match-state '(p ?x ?y) '((p 1 2)(p a b)))))