(define (split a b) (lambda (painter) (a (b painter))))
(define right-split (split beside below))
(define up-split (split below beside))
