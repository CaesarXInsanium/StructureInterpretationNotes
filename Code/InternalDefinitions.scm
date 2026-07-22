(define (f x)
  (define (even? n)
    (if (= n 0) true (odd? (- n 1))))
  (define (odd? n)
    (if (= n 0) false (even? (- n 1))))
  <other-stuff>)

(lambda <vars>
  (define a <e1>)
  (define b <e2>)
  <body>)

(lambda <vars>
  (let ((a null)
        (b null))
    (set! a <e1>)
    (set! b <e2>)
    <body>))
