;; result of evaluation is 16
(letrec ((a 1)
         (f (lambda (x)
             (define b (+ a x))
             (define a 5)
             (+ a b))))
  (f 10))
            
;; guile gets confused, unrecognized argument in procedure +
;; chezscheme also gives error in same location.
;; nothing works.

;; I don't understand either viewpoint
