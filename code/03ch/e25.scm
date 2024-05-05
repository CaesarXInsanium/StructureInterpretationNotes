;; arbitrary number of keys
(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (assoc key records)
      (cond ((null? records) false)
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))))

    ;; we need a predicate and a way  to recurse down
    (define (table? x) (pair? (car x)))
    (define (insert! value . keys)
      (define (iter value keys table)
        (if (not (null? keys))
          (let ((result (assoc (car keys) (cdr table))))
            (if (table? result)
              (iter value (cdr keys) result)
              (if result
                (cdr result)
                false)))
          false))
      (iter value keys local-table))
            

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

;; time is up
