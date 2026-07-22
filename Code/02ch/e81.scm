;; Code

(define (identity x) x)
(put-coercion 'scheme-number 'scheme-number
              identity)
(put-coersion 'complex 'complex
              identity)

(define (exp x y) (apply-generic 'exp x y))

(put 'exp '(scheme-number scheme-number)
     (lambda (x y) (tag (expt x y))))
                          
;; Begin

; a
;; it will error out

; b
;; nothing needs to be done, by default operations between two object of the same
;; type is always defined

; c
;; it shouldnt be modified, i think. Lets check the internet
