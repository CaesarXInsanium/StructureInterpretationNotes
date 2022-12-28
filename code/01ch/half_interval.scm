(define (average x y)
  (/ (+ x y) 2))
(define (close-enough? x y)
  (> (abs (- x y)) 0.00001))

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
        
       (if (close-enough? neg-point pos-point)
           midpoint
           (let ((test-value (f midpoint)))
                (cond ((positive? test-value)
                       (search f neg-point mid-point))
                      ((negative? test-value)
                       (search f midpoint pos-point))
                      (else midpoint))))))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
       (cond ((and (negative? a-value) (positive? b-value))
              (search f a b))
             ((and (negative? b-value) (positive? a-value))
              (search f b a))
             (else (error "Values are not opposite signs")))))

(let ((x (half-interval-method sin 2.0 4.0)))
     (display x))
(newline)

(define y (half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3))
                                1.0
                                2.0))
(display y)
(newline)
