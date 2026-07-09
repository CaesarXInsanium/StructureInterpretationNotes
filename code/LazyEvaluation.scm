;; guile compatibility hack, 
(define false #f)
(define true #t)

;; Lazy Evaluation and Thunk handling. Streams are possible

(define (force-it obj)
  (cond ((thunk? obj)
         (let ((result (actual-value (thunk-exp obj)
                                     (thunk-obj obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj) result)
           (set-cdr! (cdr obj) '())
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))
(define (actual-value exp env) (force-it (sicp-eval exp env)))
(define (delay-it exp env)
  (list 'thunk exp env))
(define (thunk? obj) (tagged-list? obj 'thunk))
(define (thunk-exp thunk) (cadr thunk))
(define (thunk-env thunk) (caddr thunk))
(define (evaluated-thunk? obj) (tagged-list? obj 'evaluated-thunk))
(define (thunk-value evaluated-thunk) (cadr evaluated-thunk))

;; Code Starts here
(define (sicp-eval exp env)
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
        ((cond? exp) (sicp-eval (cond->if exp) env))
        ((application? exp)
         (sicp-apply (sicp-eval (operator exp) env)
                     (list-of-values (operands exp) env)
                     env))
        (else (error "Unknown expression type -- EVAL" exp))))

(define (sicp-apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure
                                    (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence (procedure-body procedure)
                        (extend-enviroment (procedure-parameters procedure)
                                           (list-of-delayed-args arguments env)
                                           (procedure-enviroment procedure))))
        (else (error "Unknown procedure type -- APPLY" procedure))))

(define (list-of-arg-values exps env)
  (if (no-operands? exps)
    '()
    (cons (actual-value (first-operand exps) env)
          (list-of-arg-values (rest-operands exps)
                              env))))
(define (list-of-delayed-args exps env)
  (if (no-operands? exps)
    '()
    (cons (delay-it (first-operand exps) env)
          (list-of-delayed-args (rest-operands exps)
                                env))))
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (sicp-eval (first-operand exps) env)
          (list-of-values (rest-operands exps) env))))

(define (eval-if exp env)
  (if (true? (actual-value (if-predicate exp) env))
    (sicp-eval (if-consequent exp) env)
    (sicp-eval (if-alternative exp) env)))

(define (eval-sequence exps env)
  (cond ((last-exp? exps) 
         (sicp-eval (first-exp exps) env))
        (else (sicp-eval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

;; The two procedures the return 'ok mutate some state don't they?
(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (sicp-eval (assignment-value exp) env)
                       env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (sicp-eval (definition-value exp) env)
                    env)
  'ok)

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

(define (variable? exp) (symbol? exp))

(define (quoted? exp) (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))
(define (tagged-list? exp tag) (if (pair? exp) (eq? (car exp) tag) #f))
(define (assignment? exp) (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))

(define (definition? exp) (tagged-list? exp 'define))
(define (definition-variable exp) (if (symbol? (cadr exp)) (cadr exp) (caadr exp)))
(define (definition-value exp) 
  (if (symbol? (cadr exp)) 
    (caddr exp) 
    (make-lambda (cdadr exp) (cddr exp))))

(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
;; make a thing that can have the `eval` function work on
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-concequent exp) (caddr exp))
;; sometimes the alternative form is not defined. This particular implementation
;; of scheme defines the return value of 'if' expression with no alternative as
;; the literal false
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
    (caddr exp)
    'false))
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

;; Begin is a sequence of expressions.
(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

;; reading this code make me realize that this shit is not type safe
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

;; Implementation of `cond`
(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses) (cdr exp))
(define (cond-else-clause clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp) (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
    'false
    (let [(first (car clauses))
          (rest (cdr clauses))]
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first))
          (error "ELSE clause was not last -- in COND->IF"
                 clause))
        (make-if (cond-predicate first)
                 (sequence->exp (cond-actions first))
                 (expand-clauses rest))))))

(define (true? x) (not (eq? x false)))
(define (false? x) (eq? x false))

;; I just realize that this might not actually work well. Oh well

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-enviroment p) (cadddr p))

;; An enviroment is merely as list of frames. What is a frame? A pair of lists.
;; Each entry in the car is a symbol, each corresponding entry in the cdr is the 
;; corresponding value

(define (enclosing-enviroment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-enviroment '())
(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

;; Now to define an enviroment in terms of frames.
;; In this code here the enviroment object is inherently immutable
(define (extend-enviroment vars vals base-env)
  (if (= (length vars) (length vals))
    (cons (make-frame vars vals) base-env)
    (if (< (length vars) (length vals))
      (error "Too many arguments supplied" vars vals)
      (error "Too few arguments supplied" vars vals))))

;; scan list of variables to see if it is defined.
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-enviroment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-enviroment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
            (cond [(null? vars)
                   (env-loop (enclosing-enviroment env))]
                  [(eq? var (car vars))
                   (set-car! vals val)]
                  [else (scan (cdr vars) (cdr vals))]))
    (if (eq? env the-empty-enviroment)
      (error "Unbound variable! -- SET!" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let [(frame (first-frame env))]
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

;; Running the Evaluator as Code

(define (setup-enviroment)
  (let ((initial-env (extend-enviroment (primitive-procedure-names)
                                        (primitive-procedure-objects)
                                        the-empty-enviroment)))
    ;; GNU Guile Compatibility
    (define-variable! 'true #t initial-env)
    (define-variable! 'false #f initial-env)
    initial-env))

(define (primitive-procedure? proc) (tagged-list? proc 'primitive))
(define (primitive-implementation proc) (cadr proc))
;; Aperantly we can define any number of primitive procedures. We should limit
;; ourselves otherwise it would be cheating.
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? '())
        (list '+ +)))

(define (primitive-procedure-names)
  (map car primitive-procedures))
(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))

(define apply-in-underlying-scheme apply)
(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme (primitive-implementation proc) args))

(define input-prompt ";;; Lazy M-Eval input:")
(define output-prompt ";;; Lazy M-eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (actual-value input the-global-enviroment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))
(define (announce-output string)
  (display string) (display " "))
(define (user-print object)
  (begin (if (compound-procedure? object)
             (display (list 'compound-procedure
                            (procedure-parameters object)
                            (procedure-body object)
                            '<procedure-env>))
             (display object))
         (newline)))

(define the-global-enviroment (setup-enviroment))

(define prompt-for-input
  (let ((stdout (current-output-port)))
    (lambda (prompt)
      (display prompt stdout)
      (display " " stdout))))


;; START the REPL!
(driver-loop)

;; User input
;; (define (append x y) (if (null? x) y (cons (car x) (append (cdr x) y))))
;; => 'ok

;; (append '(a cb c) '(d e f))
;; => (a b c d e f)

