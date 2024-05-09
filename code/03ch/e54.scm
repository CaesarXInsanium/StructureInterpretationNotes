(require 'streams)

(define (mul-streams s1 s21)
  (stream-map * s1 s2))
;; IDK
(define factorial (cons-stream 1 (mul-streams (stream-cdr factorials)
                                              factorials)))
;; ey what ever
