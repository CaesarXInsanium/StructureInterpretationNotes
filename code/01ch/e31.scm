;; Part A
(define (product term a next b)
        (if (> a b)
            1
            (* (term a)
               (product term (next a) next b))))
;; Part B
(define (product-iter term a next b)
        (define (iter a result)
                (if (> a b)
                    result
                    (iter (next a) (* (term a) result))))
        (iter a 1))
;; Part B

(define (inc x) (+ x 1))
(define (identity x) x)
(define (factorial x)
        (product identity 1 inc x))


(define (factoriali x)
        (product-iter identity 1 inc x))
(factorial 4)
(factoriali 4)
(define (term a)
        (define top (- a 1))
        (* (/ top a)
           (/ (+ top 2) a)))
(define (next a)
        (+ a 2))

(define (pi x)
        (* 4 (product term 3 next x)))
(display "Result: ")
;; (format "~8,2F" 1/3)
(display (exact->inexact (pi 1000)))
(newline)

