(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(count-leaves (cons (cons (cons 1 2)
                          4)
                    (cons 1
                          (cons 3 4))))
