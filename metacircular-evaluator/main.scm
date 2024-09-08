(load "eval.scm")
(load "env.scm")
(load "procedures.scm")
(load "define.scm")
(load "set.scm")

(define (main-loop) 
  (define global-env (env/extend '() (env/empty)))
  (procedure/extend-global global-env)
  
  (define (display-prompt) (display "| "))

  (define (write-string str)
    (begin (display-prompt)
	   (display str)
	   (newline)))
  
  (define (write/inline . strs)
    (begin (display-prompt)
	   (for-each (lambda (str) (begin (display str) (display " "))) strs)
	   (newline)))
  
  (define (write/list . strs)
    (for-each write-string strs))

  (define (write-error err)
    (let ((err-msgs (cdr err)))
      (write/list err-msgs)))

  (define (write-greeting)
    (write-string "Let's GO!"))
  (define (write-bye)
    (write-string "GOODBYE!"))

  (define (read-command)
    (display-prompt)
    (read))

  (define (loop)
    (let ((input (read-command)))
      (if (and (pair? input) (eq? (car input) 'exit)) 
	'()
	(let ((result (evaluate input global-env)))
	  (write-string result)
	  (loop)))))

  (begin
    (write-greeting)
    (loop)
    (write-bye)))
