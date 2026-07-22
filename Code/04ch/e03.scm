;; Data Directed Style
;; What do we have in terms of data?
;; We have a list of symbols
;; We could have a symbol or a literal
;; we could have a quoted symbol? which is also self evaluating
;; after that we have lists
;; conditional statement, which are primive
;; begin starts with a symbol, then a list of expressions
;; the final thing is application of function.
;;;; This is also a list, but with a symbol. it must be looked up in the enviroment
;;;; to see if it is already define or if is a primitive provedure.
;;;; This is the section that is handed off to "eval"
;;;; list-of-values implements the eager evaluation by "eval" on all comprising
;;;; expressions.

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
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

;; Honestly I look at e3.73 and see the same thing as this eval function.
;; Lets look at the answer key.

;; WTF
