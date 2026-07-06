;; Imports

(import (srfi srfi-41))
(define take stream->list)

;;;;;; Exercise explanation.
;; 

(define (expand num den radix)
  (stream-cons (quotient (* num radix) den)
               (expand (remainder (* num radix) den) den radix)))
;; Before running
;; (expand 1 7 10)
;; 1 (promise (expand 3 7 10))
;; 1 4 (promise (expand 2 7 10))
;; 1 4 1 (promise (expand 3 7 10))
;; 1 4 1 4

;; So it is going to repeat forever the pattern 1 4 1 4 1 ...
(display (take 10 (expand 1 7 10)))
(newline)

;; I was wrong
;; (1 4 2 8 5 7 1 4 2 8)

;; let me try again with this one. substitution style
;; (expand 3 8 10) => 
;;;; (quotient 30 8) = 3, r = 6
;; (cons 6 (expand (remainder 30 8) 8 10))
;; (cons 6 (expand 6 8 10))
;;;; (cons 6 (cons (quotient 60 8) (expand (remainder 60 8) 10)))
;;;; q = 7, r = 4
;;;; (cons 6 (cons 7 (expand 4 8 10)))
;; (cons (quotient 40 8) (expand (remainder 40 8) 8 10))
;; q = 5, r = 0
;; (cons 5 (expand 0 8 10))
;; (cons (quotient 0 10) (expand (remainder 0 10) 8 10))
;; q = 0, r = 0
;; (cons 0 (expand 0 8 10))
;; '(6 7 0 0 0 0 0 0 ...)

(display (take 10 (expand 3 8 10)))
(newline)

;; wrong again
;; (3 7 5 0 0 0 0 0 0 0)
