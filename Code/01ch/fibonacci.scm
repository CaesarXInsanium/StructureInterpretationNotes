(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (fib_i n)
  (fib-iter 1 0 n))

(define (fib-iter a b counter)
  (if (= counter 0)
    b
    (fib-iter (+ a b) a (- ounter 1))))

(define (fn n)
  (cond ((< n 3) n)
        ((>= n 3) (+ (fn (- n 1)) (* 2 (fn (- n 2))) (* 3 (fn (- n 3)))))
