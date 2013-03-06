(in-package :tutil)

;passing a list but saving the members not the list
;each member is a list and I like to change it to string: (a b c) --> a-b-c
(defun save-members (filename stringlist method)
  (cond ((equal method 'create)
         (save filename (car stringlist) 'create))
    ;(if (atom (car stringlist)) (car stringlist) (car stringlist)) 'create))
    ;      (concat (car stringlist))) 'create))
    ((equal method 'append)
     (save filename (car stringlist) 'append)))
  ;(if (atom (car stringlist)) (car stringlist) (car stringlist)) 'append)))
  ;(concat (car stringlist))) 'append)))
  
  (mapcar #'(lambda (sl)
              (save filename sl 'append))
          (cdr stringlist)))

;chop if too long
(defun concat (inputlist)
  (let* ((temp (eval (append (list 'concatenate ''string) (mapcar #'princ-to-string inputlist))))) 
    (subseq temp 0 (min 60 (length temp)))))

(defun read-file (file)
  (with-open-file (inp file :direction :input :if-does-not-exist :error)
    (let (line res)
      (loop do (setf line (read inp nil nil))
            until (null line)
            do (when line (push line res)))
      (nreverse res))))


; *****************************
; ## print-heading2 &optional output-stream messageslist
; *****************************

(defun print-heading2 (Input &optional (stream *standard-output*) )
  (write-line "" stream)
  (write-line "" stream)
  (write-line "****************************" stream)
  (mapcar (lambda (X)
            (cond ((stringp X)
                   (write-string X stream))
              
              (t (write X  :stream stream))))
          Input)
  (write-line "" stream)
  (write-line "****************************" stream)
  (write-line "" stream))