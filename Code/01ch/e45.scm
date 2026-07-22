(define tolerance 0.00001)
(define (average x y) (/ (+ x y) 2))
(define (close-enough? x y)
  (< (abs (- x y)) tolerance))
(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
         (if (close-enough? guess next)
             next
             (try next))))
  (try first-guess))
(define (average-damp f)
  (lambda (x) (average x (f x))))
(define (newton-transform g)
  (lambda (x)
          (- (/ (g x)
                ((derive g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define dx 0.000001)
(define (repeated f n)
  (if (= n 1)
      (lambda (x) (f x))
      (lambda (x)
              (f ((repeated f (- n 1)) x)))))


;; Returns Function that Needs to be fixed pointed
(define (nrootf n x)
  (lambda (y) (/ x (expt y (- n 1)))))

;; Generates A Function for finding the nth root of number
(define (nroot n m)
  (lambda (x) (fixed-point-of-transform (nrootf n x)
                                        (repeated average-damp m)
                                        1.0)))
;; Generate a function that finds the cube root of x with accuracy level of m

(define (nth-root n x)
  ((nroot n 2) x))

(nth-root 5 32)
  
