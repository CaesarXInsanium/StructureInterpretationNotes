(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment P Q) (cons P Q))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(make-point 0 0)
(print-point (make-point 1 2))
  
