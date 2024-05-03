(define (print-queue q)
  (if (empty-queue? q)
    (format #f "Queue: ~s" NULL)
    (format #f "Queue: ~s" (let ((f (front-ptr q)))
                             (map (lambda (t)
                                    (if (eq? t f)
                                      ""
                                      (format #f "~a" t)))
                                  f)))))

(display (print-queue q))
  
