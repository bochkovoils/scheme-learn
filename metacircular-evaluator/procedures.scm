(load "utils.scm")

(define primitives
  (list (cons 'car car)
	(cons 'cdr cdr)
	(cons 'cons cons)
	(cons '+ +)
	(cons '- -)
	(cons '= =)
	(cons '/ /)
	(cons '* *)))

(define (procedure/primitive? proc) (tagged-list? proc 'primitive-procedure))
(define (procedure/primitive proc) (caddr proc))

(define (procedure/compound? proc)
  (tagged-list? proc 'procedure))

(define (procedure/make params body original-env)
  (list 'procedure params body original-env))

(define (procedure/params proc) (cadr proc))
(define (procedure/body proc) (caddr proc))
(define (procedure/env proc) (cadddr proc))

(define (procedure/extend-global env)
  (for-each 
    (lambda (primitive-proc) (env/define! env (car primitive-proc) (list 'primitive-procedure (car primitive-proc) (cdr primitive-proc))))
    primitives))

