;; a frame is a list of cons cells
;; '( (1 . 2) (3 . 4) (5 . 6) ...)

;; An enviroment is alist of frames
;; (list f1 f2 f3 f4 ...)

;; the exercise tells me to redefine. in terms of even more basic primitives
;; lookup-variable
;; set-variable!
;; define-variable! 

;; useful stuff to consider
;; enclosing-enviroment first-frame the-empty-enviroment
;; make-frame frame-variables frame-values add-binding-to-frame
;; extend-enviroment

(define (frame-filter frame variable)
  (lambda (entry) (eq? variable (car entry))))
   
(define (lookup-variable-value var env)
  (cdr (filter-map (frame-filter var) env)))

;; I give up. It has something to do with iterating and filtering the values
;; and using the definition of the enviroments to advantage.

;; I was wrong yet again. It was about doing the actual work of looking up
;; variables. The primitives are different
