;; Exercise 4.25
;; unless syntax allows for a list of expression that are be evaluated depending
;; value of the predicate.
;; Back to the exercise
(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

(factorial 5)

;; It seems that unless is the wrong form to use
