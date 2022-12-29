(define (print x)
  (display x)
  (newline))
(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n k) (+ (d k) (cont-frac n d (- k 1))))))

(define (a x) (+ (/ 4 3) (* x (/ 2 3))))
(define (pattern n)
  (if (= (remainder (- 1 n) 3) 0)
      (a n)
      1))


      

(let ((x (cont-frac (lambda (i) 1.0)
                    pattern
                    10000)))
     (print  (+ x 2)))
