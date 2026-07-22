(define (make-interval a b) (cons a b))
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define x (make-interval -1 1))
(lower-bound x)
(upper-bound x)
