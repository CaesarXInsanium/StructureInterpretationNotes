;; basically the same thing as define-variable!
;; except instead of doing the binding, we recurse into a special function
;; that does the work and, get the parent and child of our nodes, and get the
;; parent to point its grandchild. This would only recurse so much, it will
;; terminate execustion on reaching this

;; add-binding-to-frame! sets cars and cdrs of a pair

(define (make-unbound! var val env)
  (let [(frame (first-frame env))]
    (define (scan vars vals previous)
      (cond ((null? vars) 
             (make-unbound! var val (enclosing-enviroment env))) ;; go up a level
            ((eq? var (car vars))
             (begin (set-car! frame-level (cons (car vals)
                                                (car vars)))
                    (set-cdr! frame-level (grand-child previous))))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame)
          (cons frame))))

