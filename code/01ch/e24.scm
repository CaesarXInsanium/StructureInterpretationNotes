 ;; ex 1.24 
(define false #f)
(define true #t)
(define runtime current-time)
  
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((= n 1) b)
        ((= n 2) (square b))
        ((even? n) (fast-expt (square b) (/ n 2)))
        (else (* b (fast-expt b (- n 1))))))

 (define (square x) (* x x)) 
  
 (define (expmod base exp m) 
   (cond ((= exp 0) 1) 
         ((even? exp) 
          (remainder (square (expmod base (/ exp 2) m)) 
                     m)) 
         (else 
          (remainder (* base (expmod base (- exp 1) m)) 
                     m))))         
  
 (define (fermat-test n) 
   (define (try-it a) 
     (= (expmod a n n) a)) 
   (try-it (+ 1 (random (- n 1))))) 
  
 (define (fast-prime? n times) 
   (cond ((= times 0) true) 
         ((fermat-test n) (fast-prime? n (- times 1))) 
         (else false))) 

 (define (prime? n) 
   ; Perform the test how many times? 
   ; Use 100 as an arbitrary value. 
   (fast-prime? n 100)) 
  
 (define (timed-prime-test n) 
   (start-prime-test n (runtime))) 
  
 (define (start-prime-test n start-time) 
   (if (prime? n) 
       (report-prime n (- (runtime) start-time)))) 
  
 (define (report-prime n elapsed-time) 
   (newline) 
   (display n) 
   (display " *** ") 
   (display elapsed-time)) 
  
 (timed-prime-test 1009) 
 (timed-prime-test 1013) 
 (timed-prime-test 1019) 
 (timed-prime-test 10007) 
 (timed-prime-test 10009) 
 (timed-prime-test 10037) 
 (timed-prime-test 100003) 
 (timed-prime-test 100019) 
 (timed-prime-test 100043) 
 (timed-prime-test 1000003) 
 (timed-prime-test 1000033) 
 (timed-prime-test 1000037) 
  
 ; See comments in exercise 1.22 
 (newline) 

 (timed-prime-test 1000000007) 
 (timed-prime-test 1000000009) 
 (timed-prime-test 1000000021) 
 (timed-prime-test 10000000019) 
 (timed-prime-test 10000000033) 
 (timed-prime-test 10000000061) 
 (timed-prime-test 100000000003) 
 (timed-prime-test 100000000019) 
 (timed-prime-test 100000000057) 
 (timed-prime-test 1000000000039) 
 (timed-prime-test 1000000000061) 
 (timed-prime-test 1000000000063) 
