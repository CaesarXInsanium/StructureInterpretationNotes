(define (double f)
  (lambda (x) (f (f x))))

(define (inc x)
  (display "Incrementing ")
  (display x)
  (newline)
  (+ x 1))

(((double (double double)) inc) 5) ;;return 21
