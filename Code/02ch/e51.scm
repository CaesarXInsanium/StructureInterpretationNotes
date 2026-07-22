;; Analogous
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-up (transform-painter painter1
                                       (make-vect 0.0 0.0)
                                       (make-vect 0.0 1.0)
                                       split-point))
          (paint-down (transform-painter painter2
                                         split-point
                                         (make-vect 1.0 0.0)
                                         (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-up frame)
        (paint-right frame)))))
                                         
;; Other method

;; returns procedure the repeats a procedure n number of times
(define (repeated f n)
  (lambda (a) 
    (if (= n 0)
        (f a)
        (f (repeat f (- n 1) a))))

 (define (rotate270 painter)
   (lambda (painter) ((repeated rotate90 3) painter)))) 

(define (below-rot painter1 painter2)
  (rotate270 (beside (rotate90 painter1) (rotate90 painter2))))
