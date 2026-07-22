(define (make-accumulator init)
  (lambda (amount)
    (begin (set! init (+ init amount))
           init)))

(define a (make-accumulator 5))
(a 4)

