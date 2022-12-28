(define (square x) (* x x))
(define (f g)
  (g 2))

(f square)
(f (lambda (z) (* z (+ z 1))))
;; calling this could recurse forever
(f f)
;; more modern implementations of scheme detects that the wrong type has been used
;; function f expects a function be passed to it instead of a number
