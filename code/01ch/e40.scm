
(define tolerance 0.000001)
(define (close-enough? x y)
  (< (abs (- x y)) tolerance))
(define (average x y)
  (/ (+ x y) 2))
(define (square x) (* x x))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
         (if (close-enough? guess next)
             next
             (try next))))
  (try first-guess))

(define (deriv g)
  (lambda (x) 
        (/ (- (g (+ x dx))
              (g x))
           dx)))

(define (newton-transform g)
  (lambda (x)
          (- x (/ (g x)
                  ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))
