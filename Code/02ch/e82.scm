(define (apply-generic op . args)
  (let ((type-tags (map (type-tag args)))
        (let ((proc (get op type-tags)))
          (if proc
            (apply proc (map contents args))
            (map (lambda (target)
                   (map (lambda (item)
                          (let ((target-type (type-tag target))
                                (item-type (type-tag item)))
                            (let ((conv (get-coercion item-type target-type)))
                              (if conv
                                conv
                                'nothing))))
                        args)) 
                 args))))))

;; times up
;; it looks like i misunderstood the point of the exercise.
