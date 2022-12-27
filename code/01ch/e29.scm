(define (even? n)
        (= (remainder n 2) 0))
(define (sum term a next b)
        (if (> a b)
            0
            (+ (term a)
               (sum term (next a) next b))))

(define (inc x) (+ x 1))
(define (cube x) (* x x x))

(define (z n f a h b)
        (define (term k)
                (* (cond
                       ((= k 0) 1)
                       ((= k n) 1)
                       ((even? k) 2)
                       (else 4))
                   (f (+ a (* k h)))))
        (define (next x)
                (+ x 1))
        (sum term a next b))
         
(define (simpsons f a b n)
        (z n f a (/ (- b a) n) b))

;; n define accuracy of approximation, the larger the more accurate

(simpsons cube 0 1 1000)

;; Correct
(define (simpson-integral f a b n) 
        (define (sum term a next b) 
                (if (> a b)
                    0 
                    (+ (term a) (sum term (next a) next b)))) 
        (define (term x) 
                (+ (f x)
                   (* 4 (f (+ x h)))
                   (f (+ x (* 2 h))))) 
        (define (next x) 
                (+ x (* 2 h))) 
        (define h (/ (- b a) n)) 
        (* (/ h 3) (sum term a next (- b (* 2 h))))) 

(simpson-integral cube 0 1 1000)
