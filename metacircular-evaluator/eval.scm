(load "table.scm")
;(load "utils.scm")

(define symbol/is? symbol?)
(define (symbol/eval expr env) (env/value env expr))

(define (self-eval/is? expr) (or (number? expr) (string? expr)))
(define (self-eval/eval expr env) expr)

(define (evaluator)
  (define ops (table/make))

  (table/insert! ops symbol/is? symbol/eval)
  (table/insert! ops self-eval/is? self-eval/eval)

  (define (set-handler! type-check evaluation)
    (table/insert! ops type-check evaluation))

  (define (find-operation-for-expr expr)
    (table/find-by-key-predicate ops (lambda (type-check) (type-check expr))))

  (define (evaluate expr env)
    (let ((eval-fn (find-operation-for-expr expr)))
      (if eval-fn
	(eval-fn expr env)
	(error "There is not handler for" expr))))

  (define (dispatch m)
    (cond ((eq? m 'set-handler!) set-handler!)
	  ((eq? m 'eval) evaluate)))
  dispatch)

(define (evaluator/make) (evaluator))
(define (evaluator/set-handler! *e type-check handler) ((*e 'set-handler!) type-check handler))
(define (evaluator/eval *e expr env) ((*e 'eval) expr env))

(define global-evaluator (evaluator))
(define (evaluate expr env)
  (evaluator/eval global-evaluator expr env))
