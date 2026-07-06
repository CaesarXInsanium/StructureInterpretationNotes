;; Exercise 3.63
(define (sqrt-stream x)
  (stream-cons 1.0 (stream-map (lambda (guess) (sqrt-improve guess x))
                               (sqrt-stream x))))

;; There is no memoization in sqrt-stream, it recalculates everything once again.
