;; Exercise 4.22
;; Extend new evaluator to support let expressions
;; All of this code I did not write. There was not way I could of have

(define (analyze exp)
  (cond [(self-evaluating? exp)
         (analyse-self-evaluating exp)]
        [(quoted? exp) (analyze-quoted exp)]
        [(variable? exp) (analyze-variable exp)]
        [(assignment? exp) (analyze-assignment exp)]
        [(definition? exp) (analyze-definition)]
        ;; this has to return a lambda that accepts an env obj
        [(let-exp? exp) (analyze-let exp)] 
        [(if? exp) (analyze-if exp)]
        [(lambda? exp) (analyze-lambda exp)]
        [(begin? exp) (analyze-sequence (begin-actions exp))]
        [(cond? exp) (analyze (cond->if exp))]
        [(application? exp) (analyze-application exp)]
        [else (error "Unknown expression type -- ANALYZE" exp)]))


(define (analyze-let exp) (analyze (let->combination exp)))
