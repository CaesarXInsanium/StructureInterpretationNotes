(define equal?
  (lambda (a b)
    (cond ((and (null? a) (null? b)) #t)
          ((eq? (car a) (car b)) (equal? (cdr a) (cdr b)))
          ((and (null? a) (not (null? b))) #f)
          (else #f))))

(define (equal? a b)
  (or (and (null? a) (null? b))
      (and (eq? (car a) (car b))
           (equal? (cdr a) (cdr b)))))

(equal? '(this is a list) '(this is a list))
