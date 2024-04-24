(put sub 
     '(polynomial polynomial)
     (lambda (a b)
       (let ((aterms (term-list a))
             (bterms (term-list b))
             (avar (variable a))
             (bvar (variable b))))))

;; switch the sides
(define (negate p)
  (let ((terms (term-list p)))
    (map (lambda (term)
           (make-term (term-order term)
                      ;; subtract from zero the coefficient
                      (sub 0 (coeff term)))) 
         terms)))
       
;; basically just copy paste add-term, my answer
(define (sub-terms l1 l2)
  (cond ((empty-termlist? l1) (negate l2))
        ((empty-termlist? l2) l1)
        (else (let ((t1 (first-term l1))
                    (t2 (first-term l2)))
                (cond ((> (order t1) (order t2))
                       (adjoin-term t1
                                    (sub-terms (rest-terms l1)
                                               l2)))
                      ((< (order t1) (order t2))
                       (adjoin-term t2 (sub-terms l1 (rest-terms l2))))
                      (else (adjoin-term (make-term (order t1)
                                                    (sub (coeff t1) (coeff t2)))
                                         (sub-terms (rest-terms l1)
                                                    (rest-terms l2)))))))))

(put 'sub '(polynomial polynomial) sub-terms)

;; answer is to define sub terms as A - B == A + -B
