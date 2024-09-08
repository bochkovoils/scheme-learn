(define (set/is? expr) (tagged-list? expr 'set!))
(define (set/var expr) (cadr expr))
(define (set/body expr) (caddr expr))
(define (set/eval expr env)
  (env/set! env (set/var expr) (evaluate (set/body expr) env)))

(evaluator/set-handler! global-evaluator set/is? set/eval)

