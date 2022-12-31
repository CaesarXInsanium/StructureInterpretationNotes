(define square (lambda (x) (* x x)))
(define (repeated f n)
  (if (= n 1)
      (lambda (x) (f x))
      (lambda (x)
        (f ((repeated f (- n 1)) x)))))

(define (inc x) (+ x 1))

((repeated square 2) 5)

