(define (square x)
    (* x x))

(define (cube x)
  (* x x x))

(define (improve y x)
  (/ (+ (/ x (square y)) (* 2 y)) 3))

(define (good-enough? guess x)
    (< (abs (- (cube guess) x)) 0.00001))
    
(define (cbrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (cbrt-iter (improve guess x)
                x)))

(define (cbrt x)
  (cbrt-iter 1.0 x))

(write (cbrt 8) )
(newline)
(write (cbrt 27))
(newline)
(write (cbrt 125))
(newline)
(write (cbrt 1000))
(newline)
(write (cbrt 69))
(newline)
