;; This code is wrong!!!
(define (square x) (* x x))
(define (average x y)
  (/ (+ x y) 2))
(define tolerance 0.00001)

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
         (if (good-enough? guess next)
             next
             (try next))))
  (try first-guess))

(define (sqrt x)
  (let ((iter (lambda (guess x)
                (if (good-enough? guess x)
                    guess
                    (iter (improve guess x)
                          x)))))
       (iter 1.0 x)))

(define (improve guess x)
  (average guess (/ x guess)))
(define (print x)
  (display x)
  (newline)
  x)

(define (iterative-improve f g)
  (define (iter guess x)
        (if (g guess x)
            guess
            (iter (f guess x) x)))
  (lambda (x) (iter 1.0 (print x))))
                        
(define sqrt (iterative-improve improve good-enough?))


(define (new-fixed-point f first-guess)
  (iterative-improve  good-enough? first-guess))

(define (new-fixed-point f first-guess)
  (lambda (x) ((iterative-improve (lambda (f) (f x) good-enough)))))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt x)
  ((new-fixed-point (average-damp (lambda (y) (/ x y))) 1.0) x))

(sqrt 4)
