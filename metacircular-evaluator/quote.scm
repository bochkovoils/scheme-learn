(define (quote/is? expr) (tagged-list? expr 'quote))
(define (quote/eval expr env) (cadr expr))

(evaluator/set-handler! global-evaluator quote/is? quote/eval)
