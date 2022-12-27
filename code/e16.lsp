(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((= n 1) b)
        ((= n 2) (square b))
        ((even? n) (fast-expt (square b) (/ n 2)))
        (else (* b (fast-expt b (- n 1))))))
  


(define (iter-fast-expt b n) 
  (define (iter N B A) 
    (cond ((= 0 N) A) 
          ((even? N) (iter (/ N 2) (square B) A)) 
          (else (iter (- N 1) B (* B A))))) 
  (iter n b 1))

(define (test b n)
  (write "b = ")
  (write b)
  (write "n = ")
  (write n)
  (write " :b^n =")
  (write (iter-fast-expt b n))
  (newline))

(test 2 2)
(test 2 0)
(test 4 5)
(test 4 3)
(test 1 9)
