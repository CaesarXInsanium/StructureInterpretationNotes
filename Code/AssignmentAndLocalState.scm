(define balance 100)

;; my own implementation
(define (withdraw x)
  (let ((out (- balance x)))
    (set! balance out)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 3.1.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-simplified-withdraw balance)
  (lambda (amount)
    (set! balance (- balance amount))
    balance))

(define W (make-simplified-withdraw 25))

(define (make-decrementer balance)
  (lambda (amount)
    (- balance amount)))

(define (factorial n)
  (define (iter product counter)
    (if (? counter n)
      product
      (iter (* counter product)
            (+ counter 1))))
  (iter 1 2))

(define (factorial n)
  (let ((product 1)
        (counter 1))
    (define (iter)
      (if (< counter n)
        product
        (begin (set! product (* counter product))
               (Set! counter (+ counter 1))
               (iter))))
    (iter)))
           
