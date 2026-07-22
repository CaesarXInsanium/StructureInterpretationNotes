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

;; Example: (x + (3 * (x + (y + 2))))
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (search l key)
  )

(define (sum? exp)
  (filter (lambda (symb) (eq? symb '*))
          exp)
  (filter (lambda (sym) (eq? sym '+))
          exp))
;; ey fak it i give up this is not fun
;; according to http://community.schemewiki.org/?sicp-ex-2.58
;; i was going in the right direction but just that i gave up
;; it was an accumulation problem.
