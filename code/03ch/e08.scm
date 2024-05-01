;; i cant think of a way to do this without a global variable
(define (f x)
  (if (= x y)
    -1)
    
;; I forgot that let bindings are a thing
 (define f
   (let ((init 0))
     (λ (x)
       (set! init (- x init))
       (- x init)))))
