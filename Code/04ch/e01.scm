;; original
;; arguments to a function are a list of expressions to be evaluated
;; order of operations is determined by the implementation of scheme
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
          (list-of-values (rest-operands exps) env))))

;; left to right guaranteed
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (begin (define result (cons '() '()))
           (set-car! result (eval (first-operand exps) env))
           (set-cdr! result (list-of-values (rest-operands exps) env))
           result)))

;; right to left guaranteed

(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (begin (define result (cons '() '()))
           (set-car! result (list-of-values (rest-operands exps) env))
           (set-cdr! result (eval (first-operand exps) env))
           result)))

;; key question is, what does the `operands` procedure do, they take the quoted expression
;; and symbols from the list, so they simple exclude the first symbol and return
;; everyting else
