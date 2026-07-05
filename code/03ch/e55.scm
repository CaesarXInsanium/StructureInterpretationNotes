(import (srfi srfi-41))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

;; return stream: S0, S0 + S1, S0 + S1 + S2, ...
;;(define (partial-sums s) ...)

(define (partial-sums s)
  (define (inner n g)
    (stream-cons n (inner (+ n (stream-car g)) (stream-cdr g))))
  (inner (stream-car s) (stream-cdr s)))

(display (stream->list 6 (partial-sums integers)))
(newline)
