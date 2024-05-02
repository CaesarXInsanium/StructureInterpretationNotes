(define (append x y)
  (if (null? x)
    y
    (cons (car x) (append (cdr x) y))))

(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

;; Begin

;;; (cdr x)
;;; => (b)

; (define w (append! x y))
;; => (a b c d)

; (cdr x)
;; => (b c d)

;; drawing is beneath me
