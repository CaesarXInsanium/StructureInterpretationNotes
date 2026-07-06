(import (srfi srfi-41))
(define true #t)
(define (square x) (* x x))
(define (divisible? x y) (= 0 (modulo y x)))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (prime? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps)) n) true)
          ((divisible? n (stream-car ps)) false)
          (else (iter (stream-cdr ps)))))
  (iter primes))

(define primes (stream-cons 2 (stream-filter prime? (integers-starting from 3))))

;; just the merge from merge sort
(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else (let ((s1car (stream-car s1))
                    (s2car (stream-car s2)))
                (cond ((< s1car s2car)
                       (stream-cons s1car (merge (stream-cdr s1) s2)))
                      ((> s1car s2car)
                       (stream-cons s2car (merge s1 (stream-cdr s2))))
                      (else (stream-cons s1car (merge (stream-cdr s1) (stream-cdr s2)))))))))

;; Begin Exercise
(define S (stream-cons 1 (merge (scale-stream S 5)
                                (merge (scale-stream S 2) (scale-stream S 3)))))

(display (stream->list 20 S))
(newline)
