(define (f x y)
        (define (f-helper a b)
                (+ (* x (square a))
                   (* y b)
                   (* a b)))
        (f-helper (+ 1(* x y))
                  (- 1 y)))

(define (square x) (* x x))

(define (f x y)
    (let ((a (+ 1 (* x y)))
          (b (- 1 y)))
          
         (+ (* x (square a))
            (* y b)
            (* a b))))

(define (f x y)
    (let ((a (+ 1 (* x y)))
          (b (- 1 y)))

         (+ (* x (square a))
            (* y b)
            (* a b))))


(define (g x y)
    (let ((a (+ 1 (* x y)))
          (b (- 1 y)))
         (+ (* x (square a))
            (* y b)
            (* a b))))

(f 7 8)
(g 7 8)

(define x 5)
(+ (let ((x 3))
     (+ x (* x 10)))
   x)
