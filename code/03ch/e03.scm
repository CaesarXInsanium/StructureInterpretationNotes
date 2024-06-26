(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient Funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))

  (define (make-password-protected password proc)
    (lambda (first . args)
      (if (eqv? first password)
        (apply proc args)
        "Incorrect Password")))

  ;; returns a procedure object as implementation
  (make-password-protected password dispatch))

(define a (make-account 100 'pass))
((a 'pass 'withdraw) 10)
