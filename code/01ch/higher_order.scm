;; Helper Functions
(define (inc x) (+ x 1))
(define (indentity x) x)
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
(newline)

(display "Sum Cubes ")
(display (sum-cubes 4 5))
(newline)

(display "Pi Sum ")
(display (pi-sum 4 5))
(newline)

(define (sum-cubex a b)
        (sum cube a inc b))

(display "sum-cubex ")
(display (sum-cubex 4 5))
(newline)
