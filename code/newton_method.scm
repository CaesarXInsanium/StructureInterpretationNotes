(define (floor-test x)
  (write "Floor of ")
  (write x)
  (write " is ")
  (write (floor x))
  (newline))

(floor-test 4.5)
(floor-test 0.0001)
(floor-test 9.5)
(define EPSILON 0.00001)

(define (floor x)
  (cond ((<= x 1) 0)
        (else (+ 1  (floor (- x 1))))))

(define (square x)
    (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) EPSILON))

(define
  (better-good-enough
    guess 
    x 
    previous_guess
  )
  (and 
    (<
      (abs
        (-
          (square 
            guess
          )
          x
        )
      )
      EPSILON
    )
    (<
      (abs
        (- 
          previous_guess
          guess 
        )
      )
      EPSILON
    )
  )
)
    
(define (sqrt-iter guess x previous_guess)
  (if (better-good-enough guess x previous_guess)
    guess
    (sqrt-iter (improve guess x)
                x guess)))

(define (sqrt x)
  (sqrt-iter 1.0 x 0.0))

(define (sqrt-test x)
  (write "Square root of ")
  (write x)
  (write " is")
  (write (sqrt x))
  (newline))

(sqrt-test 4)
(sqrt-test 100)
(sqrt-test 1)
(sqrt-test 999999999)
(sqrt-test 2)
(sqrt-test 0.5)
(sqrt-test 0.0001)

