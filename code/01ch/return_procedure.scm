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

((average-damp square) 10)

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

(sqrt 4)

(define (cube x)
  (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))
(cube 8)

(define dx 0.000001)
(define (deriv g)
  (lambda (x) 
        (/ (- (g (+ x dx))
              (g x))
           dx)))

(define (cube x) (* x x x))
((deriv cube) 5)

(define (newton-transform g)
  (lambda (x)
          (- x (/ (g x)
                  ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))

(sqrt 4)

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0))

(sqrt 4)
