(define (install-rectangular-package)
  (define (real-part z) (car z))
  (put 'real-part '(rectangular) real-part)
  ...)


(define (install-polar-package)
  (define (real-part z) (* (magnitude z) (cos (angle z))))
  (put 'real-part '(polar) real-part)
  ...)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags))
          (if proc
              (apply proc (map contents args))
              (error
               "No Method for these types -- APPLY-GENERIC"
               (list op type-tag)))))))

;; This function allows for the real usage of API

(define (real-part z) (apply-generic 'real-part z))

;; ALl of this rests on the existance of function

(define (get op datum) ...)
