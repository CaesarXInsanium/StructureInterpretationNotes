(+ (* 3 (+ (* 2 4)
           (+ 3 5)))
   (+ (- 10 7) 6))

(define (factorial n)
  (if (= n 1) 1 (* n (factorial (- n -1)))))

(define dx 0.000001)
(define (deriv g) 
  (lambda (x) (/ (- (g (+ x dx))
                    (g x)) 
                 dx)))
(cons 1 2)

(define (scale-list items factor) 
  (map (lambda (x) (\* factor x)) items))
(pair? (list 1 2 3)) ;; => #t

(pair? (cons (cons 1 (cons 3 4))
             (cons (list 1 2 3)
                   (cons '() 5)))) ;; => #t
