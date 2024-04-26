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
        (lambda args "Incorrect Password"))))
  (define call-the-cops (lambda () (error "Cops Called")))
  (define (limit-access proc)
    (define access-count 0)
    (lambda args
      (if (> 7 access-count)
        (let ((result (proc args)))
          (if (equal? result "Incorrect Password")
            (begin (set! access-count (+ access-count 1))
                   result)
            result))
        (call-the-cops)))) 
                  
    
      
  ;; returns a procedure object as implementation
  (limit-access (make-password-protected password dispatch)))

(define a (make-account 1000 'pass))

((a 'pss 'withdraw) 10)
((a 'pss 'withdraw) 10)
((a 'pss 'withdraw) 10)
((a 'pss 'withdraw) 10)
((a 'pss 'withdraw) 10)
((a 'pss 'withdraw) 10)
((a 'pss 'withdraw) 10)
((a 'pss 'withdraw) 10)

;; my honest attempt. I have too much time on this exercise.
