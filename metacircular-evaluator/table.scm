(define (table)
  (define t '())

  (define (ordered-table) (reverse t))

  (define (contains? key)
    (if (find (lambda (pair) (eq? (car pair) key)) (ordered-table)) true false))

  (define (get-pair-with-key key)
    (find (lambda (pair) (eq? (car pair) key)) (ordered-table)))
  
  (define (insert! key value)
    (let ((pair (get-pair-with-key key)))
      (if pair
	(set-cdr! pair value)
	(set! t (cons (cons key value) t)))))

  (define (get-value key)
    (cdr (get-pair-with-key key)))

  (define (get-keys) (map car (ordered-table)))

  (define (find-value-by-key predicate)
    (let ((result (find (lambda (pair) (predicate (car pair))) (ordered-table))))
      (if result
	(cdr result)
	result)))

  (define (dispatch m)
    (cond ((eq? m 'contains?) contains?)
	  ((eq? m 'insert!) insert!)
	  ((eq? m 'value) get-value)
	  ((eq? m 'keys) get-keys)
	  ((eq? m 'value-by-key-predicate) find-value-by-key)))
  dispatch)

(define (table/make) (table))
(define (table/contains? *table key) ((*table 'contains?) key))
(define (table/keys *table) ((*table 'keys)))
(define (table/value *table key) ((*table 'value) key))
(define (table/insert! *table key value) ((*table 'insert!) key value))
(define (table/find-by-key-predicate *table predicate) ((*table 'value-by-key-predicate) predicate))
