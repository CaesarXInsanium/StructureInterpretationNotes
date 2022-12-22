;; (use-modules (srfi srfi-19))

(define (square x) (* x x))
(lambda (x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0)
         1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else
         (remainder (* base (expmod base (- exp 1)m))m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) 1)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else 0)))

;; This is some documentation text
(define (time-prime-test n)
  (newline)
  (display n)
  (newline)
  (start-prime-test n (current-time)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100000)
      (report-prime (- (current-time) start-time))))

(define (report-prime elapse-time)
  (display '***')
  (display elapse-time)
  (newline)
)

(define (process-prime n)
  (define result (time-prime-test n))
  (true)
)

(define (search-for-primes start end f)
  (define (iter current end f)
    (define stop (f current))
    (cond
     ((and (not (= current end)) stop) (iter (+ current 1) end f))
     ((= current end) (display "Loop Ended"))))
  (iter start end f)
  )

(search-for-primes 0 10 num)

(search-for-primes 1000 3)
