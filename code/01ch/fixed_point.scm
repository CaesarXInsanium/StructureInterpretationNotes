(define tolerance 0.00001)
(define (average x y)
  (/ (+ x y) 2))

(define (close-enough? x y)
  (< (abs (- x y)) tolerance))
(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
         (if (close-enough? guess next)
             next
             (try next))))
  (try first-guess))
  
(fixed-point cos 1.0)

(fixed-point (lambda (x) (+ (sin x) (cos x))) 1.0)

;; Square Root can be redefined as
(define (sqrt x)
  (fixed-point (lambda (y) (/ x y)) 1.0))
;; Problem here is that is does not converge.
;; A bettert way to define this procedure it to write it as
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))

(sqrt 4)
(display (sqrt 4))
(newline)
