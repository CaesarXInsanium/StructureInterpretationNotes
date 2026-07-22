;; Helper Functions
(define (inc x) (+ x 1))
(define (identity x) x)
(define (cube x) (* x x x))

(define (sum-integers a b)
        (if (> a b)
            0
            (+ a (sum-integers (+ a 1) b))))

(define (sum-cubes a b)
    (if (> a b)
        0
        (+ (cube a) (sum-cubes (+ a 1) b))))

(define (pi-sum a b)
    (if (> a b)
        0
        (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

(define (sum term a next b)
        (if (> a b)
            0
            (+ (term a)
               (sum term (next a) next b))))

(display "Sum: ")
(display (sum-integers 4 5))
(display "Sum Cubes ")
(display (sum-cubes 4 5))
(newline)

(display "Pi Sum ")
(display (pi-sum 4 5))
(newline)

;; Redefinition os the previous functions

(define (sum-cubex a b)
        (sum cube a inc b))

(display "sum-cubex ")
(display (sum-cubex 1 10))
(newline)

(define (sum-integers a b)
        (sum identity a inc b))

(display "sum-integers")
(display (sum-integers 1 10))
(newline)

(define (pi-sum a b)
        (define (pi-term x)
                (/ 1.0 (* x (+ x 2))))
        (define (pi-next x)
                (+ x 4))
        (sum pi-term a pi-next b))

(display "pi-sum")
(display (pi-sum 1 10))
(newline)

(define (integral f a b dx)
        (define (add-dx x)
                (+ x dx))
        (* (sum f (+ a (/ dx 2.0)) add-dx b)
           dx))

(define (fx x) (* 2 x))

(integral fx 0 3 2)
(integral cube 0 1 0.001)
