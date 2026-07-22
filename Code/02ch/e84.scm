;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; working raise from internet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define (raise x) (apply-generic 'raise x)) 
  
 ;; add into integer package 
 (put 'raise '(integer)  
          (lambda (x) (make-rational x 1))) 
  
 ;; add into rational package 
 (put 'raise '(rational) 
          (lambda (x) (make-real (* 1.0 (/ (numer x) (denom x)))))) 
  
 ;; add into real package 
 (put 'raise '(real) 
          (lambda (x) (make-complex-from-real-imag x 0))) 

;; modify this
(define (apply-generic op . args)
  (let ((type-tags (map (type-tag args)))
        (let ((proc (get op type-tags)))
          (if proc
            (apply proc (map contents args))
            (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                        (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                        (else (error "No Method for these types"
                                     (list op type-tags))))))
              (error "No Method for these types"
                     (list op type-tags))))))))

;; Begin
(define tower '(integer rational real complex))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I give up, this exercise is not very interesting or fun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; I read the online solutions and still don't get it.
