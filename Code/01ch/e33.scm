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

(define (inc x) (+ x 1))
(define (identity x) x)
(define (factorial x)
        (product identity 1 inc x))
(factorial 4)

(define (filtered-accumulator filter combiner null-value term a next b)
        (cond ((> a b) null-value)
              ((not (filter a)) (filtered-accumulator filter combiner null-value term (next a) next b))
              (else (combiner (term a)
                              (filtered-accumulator filter combiner null-value term (next a) next b)))))
               
(define (no-filter x) #t)
(define (product term a next b)
        (filtered-accumulator no-filter * 1 term a next b))
(define (factoriali x)
        (product identity 1 inc x))
(factoriali 4)

;; Part A
(define (sq x) (* x x))
(define (smallest-div n) 
        (define (divides? a b) 
                (= 0 (remainder b a))) 
        (define (find-div n test) 
                (cond ((> (sq test) n) n) ((divides? test n) test) 
                      (else (find-div n (+ test 1))))) 
        (find-div n 2)) 
  
(define (prime? n) 
        (if (= n 1)
            false
            (= n (smallest-div n)))) 
(define (cube x) (* x x x))


(define (sum-cube-prime a b)
        (filtered-accumulator prime? + 0 (lambda (x) (* x x)) a inc b))

(sum-cube-prime 1 5)

;; Part B
(define (gcd a b)
        (if (= b 0)
            a
            (gcd b (remainder a b))))
(define (sum-pos-int n)
        (define (filter x) (= (gcd x n) 1))
        (filtered-accumulator filter * 1 identity 0 inc n))
(sum-pos-int 10)
