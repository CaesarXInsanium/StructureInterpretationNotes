(define (make-monitored f)
  (define sum 0)
  (lambda (x)
    (cond ((eq? x 'how-many-call?) sum)
          ((eq? x 'reset-count) (begin (set! sum 0)
                                       sum))
          (else (begin (set! sum (+ sum 1))
                       (f x))))))

(define (inc x) (+ x 1))

(define minc (make-monitored inc))
