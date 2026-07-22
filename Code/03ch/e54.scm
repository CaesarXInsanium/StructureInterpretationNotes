(import (srfi srfi-41))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

;; 0 1 2 3 4  5  6
;; 1 1 2 6 24 60 360

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define factorials 
  (stream-cons 1 (mul-streams factorials integers)))

(display (stream->list 6 factorials))
(newline)
