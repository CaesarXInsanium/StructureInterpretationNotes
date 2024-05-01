(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
        (begin (set!  balance (- balance amount))
               balance)
        "Insufficient Funds"))))

;; let is syntactic sugar for a procedure call.
;; same as the other, checking online answers
