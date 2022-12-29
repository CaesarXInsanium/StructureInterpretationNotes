(define tolerance 0.00001)
(define (average x y)
  (/ (+ x y) 2))

(define (close-enough? x y)
  (< (abs (- x y)) tolerance))
(define (fixed-point f first-guess)
  (define (try guess)
    (display "x=")
    (display guess)
    (display ", f(x)=")
    (display (f guess))
    (newline)
    (let ((next (f guess)))
         (if (close-enough? guess next)
             next
             (try next))))
  (try first-guess))


(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n k) (+ (d k) (cont-frac n d (- k 1))))))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           100)
(define (print x)
  (display x)
  (newline))

(let ((x (cont-frac (lambda (i) 1.0)
                    (lambda (i) 1.0)
                    10)))
     (print  x))
     

