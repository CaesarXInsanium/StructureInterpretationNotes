(define (make-password-protected password proc)
  (lambda (first . args)
    (if (eqv? first password)
      (apply proc args)
      "Incorrect Password")))

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
  (make-password-protected password dispatch))

(define (make-joint account password new-password)
  (make-password-protected new-password
                           (lambda (m)
                             (account password m))))

(define peter-acc (make-account 100 'open-sesame))

(define paul-acc (make-joint peter-acc 'open-sesame 'rose-bud))
(display ((paul-acc 'rose-bud 'withdraw) 75))
