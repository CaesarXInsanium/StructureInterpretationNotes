(import (srfi srfi-41))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

;; return stream: S0, S0 + S1, S0 + S1 + S2, ...
;;(define (partial-sums s) ...)

(define (partial-sums s)
  (define (inner current-total stream)
    (stream-cons current-total (inner (+ current-total (stream-car stream)) 
                                      (stream-cdr stream))))
  (inner (stream-car s) (stream-cdr s)))

(display (stream->list 8 (partial-sums integers)))
(newline)
