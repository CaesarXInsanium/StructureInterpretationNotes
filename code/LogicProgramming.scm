(define (append x y)
  (if (null? x)
    y
    (cons (car x) (append (cdr x) y))))
