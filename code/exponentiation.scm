;; recursive definition
(define (expt b n)
  (if (= n 0)
    1
    (* b ( expt b (- n 1)))))


(define (expt-iter b counter product)
  (if (= counter 0)
    product
    (expt-iter b (- counter 1) (* b product))))

;; iterative definition
(define (expti b n)
  (expt-iter b n 1))

;; calculates if n is even
(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (fast-expt-i b n))
(define n_i 1)


  )


(define (double x)
  (+ x x))

(define (halve x)
  (/ x 2))
