(define (tagged-list? lst tag) (and (pair? lst) (eq? (car lst) tag)))
