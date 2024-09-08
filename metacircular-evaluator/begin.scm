(define (begin/is? expr) (tagged-list? expr 'begin))
(define (begin/body expr) (cdr expr))
(define (begin/eval expr env) 
  (define (loop exprs)
    (if (null? (cdr exprs))
      (evaluate (car exprs) env)
      (begin
	(evaluate (car exprs) env)
	(loop (cdr exprs)))))
  (loop (begin/body expr)))

(evaluator/set-handler! global-evaluator begin/is? begin/eval)
