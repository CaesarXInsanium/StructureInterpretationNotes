(define (square x) (* x x))

(define (next n)
  (if (= n 2) 3 (+ n 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n ) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
  


(define (smallest-divisor n d)
  (find-divisor n d))


(define (test)
  (search-for-primes 1000 1019))


(define (time-function f)
  (define start (current-time))
  (f)
  (define end (current-time))
  (newline)
  (display "Difference is ")
  (display (- end start))
  (newline))
  

(current-time)
