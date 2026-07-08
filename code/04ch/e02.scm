;; New implementation of the "eval" function

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((application? exp) 
         (apply (operator exp) (list-of-values (operands exp) env)))
        ((assignment? exp) (eval-assingment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else (error "Unknown expression type -- EVAL" exp))))


(define x 3)
;; I think that it would go into infinite recursion as it will never git a 
;; terminal
;; "define" is supposed to be more of a primitive, directly implemented by the
;; compiler
;; It is something with an implicit side effect. And it is not a function call.
;; "define" is something akin to a keyword within the scheme programming language

(define (application? exp) (tagged-list?  exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))

;; So basically take the syntax from the "define" keyword and apply it to new
;; keyword "call". New primitive that will take a symbol and arguments and
;; evaluate it
