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

(define (self-power n)
  (fixed-point (lambda (x)  (/ (log n) (log x)))  2.0))
(define (self-power-d n)
  (fixed-point (lambda (x) (average  x (/ (log n) (log x)))) 2.0))

(self-power 1000)
(self-power-d 1000)
  
  
