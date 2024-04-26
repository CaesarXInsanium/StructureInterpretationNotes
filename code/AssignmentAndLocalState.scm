(define balance 100)

;; my own implementation
(define (withdrawxxx x)
  (let ((out (- account-balance x)))
    (set! account-balance out)
    x))

;; example
(withdraw 25) ;; 75
(withdraw 25) ;; 50

(set! balance 100)

(define (withdraw amount)
  (if (>= balance amount)
    (begin (set! balance (- balance amount))
           balance)
    "Insufficient Funds"))

(define new-withdraw
  (let ((balance 100))
    (lambda (amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient Funds"))))

(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient Funds")))

;; to seperate account objects, with their own internal state.
(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))

(W1 50) ;; => 50
(W1 25) ;; => 25
(W2 75) ;; => 25
(W2 3) ;; => 22

;; real bank account maker procedure
(define (make-account balance)
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
  ;; returns a procedure object as implementation
  dispatch)

(define acc (make-account 100))
((acc 'withdraw) 50)

;; object oriented programming for the win.
