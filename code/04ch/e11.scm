(define (enclosing-enviroment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-enviroment '())

(define (make-frame variables values)
  (if (= (length variables) (length values))
    (map cons variables values)
    (error "make-frame: variables len != values len" variables values)))

;; go trough the list of cons cells, and return the car of each

(define (frame-variables frame) (map car frame))
(define (frame-values frame) (map cdr frame))

;; Assuming we have a list of vars and vals each independent. We do not need to
;; actually change this
(define (extend-enviroment vars vals base-env)
  (if (= (length vars) (length vals))
    (cons (make-frame vars vals) base-env)
    (if (< (length vars) (length vals))
      (error "Too many arguments supplied" vars vals)
      (error "Too few arguments supplied" vars vals))))

;; Good stuff. I actually wrote this.

