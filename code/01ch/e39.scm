(define (print x)
  (display x)
  (newline))

(define (cont-frac n d k)
  (if (= k 0)
      0.0
      (/ (n k) 
         (+ (d k) (cont-frac n 
                             d
                             (- k 1))))))


(define (tan-cf x k) 
  (cont-frac (lambda (i) 
               (if (= i 1)
                   x
                   (- 0.0 (* x x)))) 
             (lambda (i) 
               (- (* i 2) 1)) 
             k))  

(tan-cf 1.0 10)
(print (tan-cf 1.0 10000))
