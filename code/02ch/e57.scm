;; Guile fix for defining an exponentiation function
(define ** expt)

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (addend x) (cadr x))
(define (augend x) (caddr x))

(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

;; code from previus exercise
(define (exponentiation? x) (and (pair? x) (eq? (car x) '**)))
(define (base x) (cadr x))
(define (exponent x) (caddr x))
(define (make-exponentiation b e)
  (cond ((and (number? b) (number? e)) (** b e))
        ((and (variable? b) (=number? e 1)) b)
        ((=number? e 0) 1)
        (else (list '** b e))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp) (make-sum (make-product (multiplier exp)
                                                (deriv (multiplicand exp) var))
                                  (make-product (deriv (multiplier exp) var)
                                                (multiplicand exp))))
        ((exponentiation? exp) (make-product (exponent exp)
                                             (make-exponentiation (base exp)
                                                                  (- (exponent exp) 1))))
        (else (error "Unknown expression type -- DERIV"))))

;; Start Exercise
;;; implement ability to derive aribitry lists of sumbs and products
;;; do not change deriv function

;; solve this particular expression
(deriv '(* x y (+ x 3)) 'x)

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (sum-iter prev rest)
  (if (number? prev)
      (sum-iter )))

(define (make-sum . a)
  (let ((item (car a)))
    (cond ((=number? a) ))))

;; from now on I will only give myself 25 minutes to solve a problem
;; SOLUTION stolen from internet
 (define (make-sum-list l) 
   (if (= (length l) 2) 
       (list '+ (car l) (cadr l)) 
       (make-sum (car l) (make-sum-list (cdr l))))) 
;; so i was going in the corrent direction in thinking in solving this problem
;; with and 
(define (make-sum a1 a2) 
  (cond ((=number? a1 0) a2) 
        ((=number? a2 0) a1) 
        ((and (number? a1) (number? a2)) (+ a1 a2)) 
        (else (make-sum-list (list a1 a2))))) 
  
(define (make-product-list l) 
  (if (= (length l) 2) 
      (list '* (car l) (cadr l)) 
      (make-product (car l) (make-product-list (cdr l))))) 

(define (make-product m1 m2) 
  (cond ((or (=number? m1 0) (=number? m2 0)) 0) 
        ((=number? m1 1) m2) 
        ((=number? m2 1) m1) 
        ((and (number? m1) (number? m2)) (* m1 m2)) 
        (else (make-product-list (list m1 m2))))) 
  
(define (augend s) 
  (let ((a (cddr s))) 
    (if (= (length a) 1) 
        (car a) 
        (make-sum-list a)))) 
(define (multiplicand p) 
  (let ((m (cddr p))) 
    (if (= (length m) 1) 
        (car m) 
        (make-product-list m)))) 
