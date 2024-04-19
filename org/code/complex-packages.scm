(define (install-rectangular-package)
  (define (real-part z) (car z))
  (put 'real-part '(rectangular) real-part)
  ...)


(define (install-polar-package)
  (define (real-part z) (* (magnitude z) (cos (angle z))))
  (put 'real-part '(polar) real-part)
  ...)
