;; Wrong? YES!!
;; I forgot to define nth level recursion
;; I should of have tested
(define (beside painter) (+ 1 painter))
(define (below painter) (- 1 painter))

(define (split a b) (lambda (painter) (a (b painter))))
(define right-split (split beside below))
(define up-split (split below beside))
