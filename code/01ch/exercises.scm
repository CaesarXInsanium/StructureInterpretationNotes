(define (pow x n)
  (cond ((= n 0) 1)
        ((= n 1) x)
        (else (* x (pow x  (- n 1))))))

;; exercice 1.3
(define (aaa a b c)
  (cond (( and (< a b) (< a c) )
         (+ (pow b 2) (pow c 2)))
        ((and (< b a) (< b c)) (+ (pow a 2) (pow c 2)))
        ((and (< c a) (< c b) (+ (pow a 2) (pow b 2))))
        ))

(define x (aaa 1 2 3))
(write "Exercise 1.3")
(write "(aaa 1 2 3)")
(newline)
(write x)
(newline)

;; Exercise 1.4
;; If b is greater than zero the addition operator is returned and addition is peformed
;; If not then the subtraction operator is returned and used instead.

;; Exercise 1.6

(define (square x)
    (* x x))

(define (cube x)
  (* x x x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

;;  THIS CODE WILL RECURSE FOREVER AND NEVERN DO ANYTHING
;; (define (new-if predicate then-clause else-clause)
;;   (cond (predicate then-clause)
;;         (else else-clause)))
;;
;; (define (sqrt-iter guess x)
;;   (new-if (good-enough? guess x)
;;           guess (sqrt-iter (improve guess x) x )))
;;
;; (define (sqrt x)
;;   (sqrt-iter 1.0 x))
;;
;; (define foursqrt (sqrt 2))
;; (write "Square Root of four is ")
;; (write foursqrt)
;; (newline)

;; Exercise 1.7


;; My Previous Implementation was stupid and I had to change it
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

;; Exercise 1.8
;; Simple translation from the equation shown in the book

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

;; Exercise 1.11

(define (f n)
  (cond ((< n 3) n)
        ((>= n 2) (+
                    (f (- n 1))
                    (* 2 (f (- n 2)))
                    (* 3 (f (- n 3)))
                  )
        )
  )
)

