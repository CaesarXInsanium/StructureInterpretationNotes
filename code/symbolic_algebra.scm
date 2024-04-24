(define *table* (make-hash-table))

(define (put op type proc)
  (hash-set! *table* (cons op type) proc))
(define (get op type)
  (hash-ref *table* (cons op type)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No Method for these types -- APPLY-GENERIC"
           (list op type-tag))))))
;; Package Declaration

(define (install-polynomial-package)
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  ;; same-variable? variable? 2.3.3
  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))
  (define (variable? x) (symbol? x))
  (define (adjoin-set x set)
    (if (element-of-set? x set)
        set
        (cons x set)))

  ;; Simple Operations on Polynomials
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (add-terms (term-list p1)
                            (term-list p2)))
      (error "Polys not in same var -- ADD-POLY "
             (list p1 p2))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (mul-terms (term-list p1)
                            (term-list p2)))
      (error "Polys not in same var -- MUL-POLY"
             (list p1 p2))))
  (define (tag p) (attach-tag 'polynomial p))
  (define (add-terms l1 l2)
    (cond ((empty-termlist? l1) l2)
          ((empty-termlist? l2) l1)
          (else (let ((t1 (first-term l1))
                      (t2 (first-term l2)))
                  (cond ((> (order t1) (order t2))
                         (adjoin-term t1
                                      (add-terms (rest-terms l1)
                                                 l2)))
                        ((< (order t1) (order t2))
                         (adjoin-term t2 (add-terms l1 (rest-terms l2))))
                        (else (adjoin-term (make-term (order t1)
                                                      (add (coeff t1) (coeff t2)))
                                           (add-terms (rest-terms l1)
                                                      (rest-terms l2)))))))))
  (define (mul-terms l1 l2)
    (if (empty-termlist? l1)
      (the-empty-termlist)
      (add-terms (mul-term-by-all-terms (first-term l1) l2)
                 (mul-terms (rest-terms l1) l2))))

  (define (mul-term-by-all-terms t1 l)
    (if (empty-termlist? l)
      (the-empty-termlist)
      (let ((t2 (first-term l)))
        (adjoin-term (make-term (add (order t1) (order t2))
                                (mul (coeff t1) (coeff t2)))
                     (mul-term-by-all-terms t1 (rest-terms l))))))

  ;; representing term lists
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

  (define (the-empty-termlist) '())
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (empty-termlist? term-list) (null? term-list))
  (define (make-term order coef) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))
                     
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-pol var terms))))
  'done)

(install-polynomial-package)

;; outside interface
(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))

(define (zero-poly? poly) 
 (define (zero-terms? termlist) 
   (or (empty-termlist? termlist) 
       (and (=zero? (coeff (first-term termlist))) 
            (zero-terms? (rest-terms termlist))))) 
 (zero-terms? (term-list poly))) 

(put '=zero? 'polynomial zero-poly?)
(put 'negate 'scheme-number 
      (lambda (n) (tag (- n)))) 
  
 ;; add into rational package 
(put 'negate 'rational 
    (lambda (rat) (make-rational (- (numer rat)) (denom rat)))) 

;; add into complex package 
(put 'negate 'complex 
  (lambda (z) (make-from-real-imag (- (real-part z)) 
                                   (- (imag-part z))))) 

;; add into polynomial package 
(define (negate-terms termlist) 
  (if (empty-termlist? termlist) 
      the-empty-termlist 
      (let ((t (first-term termlist))) 
        (adjoin-term (make-term (order t) (negate (coeff t))) 
                     (negate-terms (rest-terms termlist)))))) 

(put 'negate 'polynomial 
      (lambda (poly) (make-polynomial (variable poly) 
                                      (negate-terms (term-list poly))))) 

(put 'sub '(polynomial polynomial) 
   (lambda (x y) (tag (add-poly x (negate y))))) 
