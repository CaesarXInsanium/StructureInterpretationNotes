(define (even? n)
        (= (remainder n 2) 0))

(define (sum term a next b)
        (if (> a b)
            0
            (+ (term a)
               (sum term (next a) next b))))

;; I managed to figure this one out myself. if you dont believe me then
;; Freak off
(define (sum-iter term a next b)
        (define (iter a result)
                (if (> a b)
                    result
                    (iter (next a) (+ (term a) result))))
        (iter a 0))
        
(define (cube x) (* x x x))

(define (sum-integers a b)
        (sum-iter identity a inc b))
(define (identity x) x)
(define (inc x) (+ x 1))

(define (sum-cubex a b)
        (sum-iter cube a inc b))
(sum-integers 0 2)
