;;;; Created on 2011-03-26 10:58:05

(in-package :tutil)


;(defun copy-file (in out &key (if-exists :supersede))
;       (read-list))

(defun read-list ()
  (let ((input nil))
    (loop while (not (eq input 'eof)) do (setf input (read))(write input))))

(defmacro from-file (File &rest Fn)
  "do Fn action using File as input"
  `(with-open-file (Stream ,File :direction :input ) 
     (let ((*standard-input* Stream)) ,@Fn)))

(defmacro to-file (File &rest Fn)
  "do Fn action using File as output"
  `(with-open-file (Stream ,File :direction :output :if-exists :supersede :if-does-not-exist :create) 
     (let ((*standard-output* Stream)) ,@Fn)))

(defmacro replace-file (File &rest Fn)
  `(with-open-file (Stream ,File :direction :output :if-exists :overwrite :if-does-not-exist :create) 
     (let ((*standard-output* Stream)) ,@Fn)))

(defmacro append-file (File &rest Fn)
  `(with-open-file (Stream ,File :direction :output :if-does-not-exist :create :if-exists :append) 
     (let ((*standard-output* Stream)) ,@Fn)))

(defun save (filename string method)  
  (cond ((equal method 'create)
         (with-open-file (stream filename :direction :output :if-exists :supersede :if-does-not-exist :create)
           (print string stream)
           (close stream)))
    ((equal method 'append)
     (with-open-file (stream filename :direction :output :if-exists :append :if-does-not-exist :create)
       (print string stream)
       (close stream)))))
