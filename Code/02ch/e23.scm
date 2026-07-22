(define (for-each proc items)
  (if (not (null? items))
      (begin (proc (car items))
             (for-each proc (cdr items)))))

(for-each (lambda (x) (begin (display x)
                             (newline)) ) (list 1 2 3 4))
