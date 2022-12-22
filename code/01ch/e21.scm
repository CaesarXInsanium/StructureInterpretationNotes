
;; x * x or x^2
(define (square x) (* x x))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n ) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n d)
  (find-divisor n d))

(define (divides? a b) (= (remainder b a) 0))


(display (find-divisor 19999 (find-divisor 1999 199)))
