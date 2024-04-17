;; 2.3.2 Symbolic Differentiation

(define (deriv exp var)
  (cond ((number? exp) p)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var
                          (augend exp) var)))
        ((product? exp)
         (make-sum (make-product (multiplier exp)
                                 (deriv (multiplicand exp) var))
                   (make-product (deriv (multiplier exp) var)
                                 (multiplicand exp))))
        (else (error "Unknown Expression Type -- DERIV" exp))))

(define (deriv exp var)
  (cond ((number ?exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp)
                                           var))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

;; Begin

; A
;; Because the implementations are untagged, the types themselves would require
;; tagging for compatibility. With no real benefit

; B

;; I give up. I have nothing.
