(define (lambda/is? expr) (tagged-list? expr 'lambda))
(define (lambda/params expr) (cadr expr))
(define (lambda/body expr) (cddr expr))
(define (lambda/eval expr env)
  (procedure/make (lambda/params expr) (lambda/body expr) env))

(evaluator/set-handler! global-evaluator lambda/is? lambda/eval)
