(define (product term a next b)
        (if (> a b)
            1
            (* (term a)
               (product term (next a) next b))))
(define (product-iter term a next b)
        (define (iter a result)
                (if (> a b)
                    result
                    (iter (next a) (* (term a) result))))
        (iter a 1))

(define (sum term a next b)
        (if (> a b)
            0
            (+ (term a)
               (sum term (next a) next b))))

(define (sum-iter term a next b)
        (define (iter a result)
                (if (> a b)
                    result
                    (iter (next a) (+ (term a) result))))
        (iter a 0))

(define (accumulator combiner null-value term a next b)
        (if (> a b)
            null-value
            (accumulator term (next a) next b)))
(define (accumulator-iter combiner null-value term a next b)
        (define (iter a b)
                (if (> a b)
                    result
                    (iter (next a) (accumulator (term a) result)))))
(define (product term a next b)
        (accumulator-iter * 1 term a next b))
(define (inc x) (+ x 1))
(define (identity x) x)
(define (factorial x)
        (product identity 1 inc x))
(factoriali 4)
