;; Exercise 3.57

;; Guile quirks: it should be (import (streams))
(import (srfi srfi-41))
(define take stream->list)

(define count 0)
(define (add a b)
  (begin (set! count (+ count 1))
         (display "Adding ")
         (display a)
         (display " and ")
         (display b)
         (newline) 
         (+ a b)))


(define (fibgen a b)
  (stream-cons a (fibgen b (add a b))))

(define fibs (fibgen 0 1))

(display (take 5 fibs))
(newline)
(display count)
(newline)

;; The memoized version is O(n)
;; The question the exercise is asking, is how much less efficient would a non
;; memoized version of the code be.
;; For each computation of for the nth term of fibs, we use the + procedure n times.
;; O(2^n), O(n^2)
;; 1, 2, 3 + 2 + 1, 4 + 3 + 2 + 1, 5 + 4 + 3 + 2 + 1,  6,  7
;; 1, 2,         6,            10,                15, 21, 28
