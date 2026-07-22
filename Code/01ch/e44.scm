(define (average x y z) (/ (+ x y z) 3))
(define dx 0.000001)

(define (smooth f)
  (lambda (x) (average (f x)
                       (f (- x dx))
                       (f (+ x dx)))))

(define (repeated f n)
  (if (= n 1)
      (lambda (x) (f x))
      (lambda (x)
        (f ((repeated f (- n 1)) x)))))

(define (smoothn f n)
  ((repeated smooth n) f))

(define k 0.5)
(sin k)
((smoothn sin 9) k)
  
