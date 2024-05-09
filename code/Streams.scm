;; Guile Library
(use-modules (math primes))
(use-modules (srfi srfi-41))


(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (proc (stream-car s))
                 (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

;; Stream implementations

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

;; Primes
(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream low
                 (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(stream-car (stream-cdr (stream-filter prime?
                                       (stream-enumerate-interval 10000 1000000))))

;; Implementing delay and force

(define (force delayed-object)
  (delayed-object))

(define (memo-proc proc)
  (let ((already-run? false)
        (result false))
    (lambda ()
      (if (not already-run?)
        (begin (set! result (proc))
               (set! already-run? true)
               result)
        result))))
;; answer to e3.50

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (stream-cons (apply proc (map stream-car argstreams))
                 (apply stream-map
                        (cons proc (map stream-cdr argstreams))))))

;; Infinite Streams

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (divisible? x y) (= (remainder x y) 0))
(define (no-sevens)
  (stream-filter (lambda (x) (not (divisible? x 7)))
                 integers))

(stream-ref no-sevens 100) ;;100th element not divisible by 7

; fibonacci numbers
(define (fibgen a b)
  (cons-stream a (fibgen b (+ a b))))
(define fibs (fibgen 0 1))

; stream of prime numbers
(define (sieve stream)
  (cons-stream (stream-car stream)
               (sieve (stream-filter (lambda (x)
                                       (not (divisible? x (stream-car stream))))
                                     (stream-cdr stream)))))

(define primes (sieve (integers-starting-from 2)))

;; Implicit
(define (add-streams s1 s21)
  (stream-map + s1 s2))
(define integers (cons-stream 1 (add-streams ones integers)))

;; this formatting is ugly but at least it is readable
(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))

;; multiply each element in stream by factor
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))
;; produces powers of 2
(define double (cons-stream 1 (scale-stream double 2)))

;; better definition for prime?

(define (prime? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps)) n) true)
          ((divisible? n (stream-car ps)) false)
          (else (iter (stream-cdr ps)))))
  (iter primes))

(define primes
  (cons-stream 2
               (stream-filter prime? (integers-starting from 3))))
