(define equal? (lambda (a b)
                 (cond 
                  ((and (null? a) (null? b)) #t)
                  ((eq? (car a) (car b)) (equal? (cdr a) (cdr b)))
                  ((and (null? a) (not (null? b))) #f)
                  (else #f))))

(equal? '(this is a list) '(this is a list))
