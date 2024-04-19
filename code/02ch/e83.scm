;; int
;; rat
;; real

;; real to rat
;; I don't have enough math knowledge to create an approximation for irrational number
;; to rational. By definition, we lose some information
(put 'raise 'real (lambda (x)
                    (approximate x)))

(define (floor rat) '<asda>)
    
(put 'raise 'rational (lambda (x) (floor rat)))
(define (identity x) x)
(put 'raise 'scheme-number identity)
