(define (amb? exp) (tagged-list? exp 'amb))
(define (amb-choices exp) (cdr exp))

;; ((amb? exp) (analyze-amb exp))

(define (ambeval exp env succed fail)
  ((analyze-exp) env succed fail))

(define (analyze-self-evaluating exp)
  (lambda (env succed fail)
    (succed exp fail)))

(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env succed fail)
      (succed qval fail))))

(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp)))
    (lambda (env succed fail)
      (succed (make-procedure vars bproc env)
              fail))))

(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env succed fail)
      (pproc env
             (lambda (pred-value fail2)
               (if (true? pred-value)
                 (cproc env succed fail2)
                 (aproc env succed fail2)))
             fail))))

(define (analyze-sequence exps)
  (define (sequentially a b)
    (lambda (env succed fail)
      (a env
         (lambda (a-value fail2)
           (b env succed fail2))
         fail)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
      first-proc
      (loop (sequentially first-proc (car rest-procs))
            (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
      (error "Empty Sequence -- ANALYZE analyze-sequence")
      (loop (car procs) (cdr procs)))))

(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp))))
    (lambda (env succed fail)
      (vproc env
             (lambda (val fail2)
               (define-variable! var val env)
               (succed 'ok fail2))
             fail))))

(define (analyze-assignment exp)
  (let ((9var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succed fail)
      (vproc env
             (lambda (val fail2)
               (let ((old-value (lookup-variable-value var env)))
                 (set-variable-value! var val env)
                 (succed 'ok
                         (lambda ()
                           (set-variable-value! var old-value env)
                           (fail2)))))
             fail))))
                           
(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env succed fail)
      (fproc env
             (lambda (proc fail2)
               (get-args aprocs
                         env
                         (lambda (args fail3)
                           (execution-application proc
                                                  args
                                                  succed
                                                  fail3))
                         fail2))
             fail))))

;; so much fucking indentation
(define (get-args aprocs env succed fail)
  (if (null? aprocs)
    (succed '() fail)
    ((car aprocs) env
                  (lambda (arg fail2)
                    (get-args (cdr aprocs) 
                              env
                              (lambda (args fail3)
                                (succed (cons arg args)
                                        fail3))
                              fail2))
                  fail)))

(define (execute-application proc args succed fail)
  (cond ((primitive-application? proc)
         (succed (apply-primitive-procedure proc args)
                 fail))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-enviroment (procedure-parameters proc)
                             args
                             (procedure-enviroment proc))
          succed
          fail))
        (else (error "Unknown or malformed procedure type"
                     proc))))

(define (analyze-amb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succed fail)
      (define (try-next choices)
        (if (null? choices)
          (fail)
          ((car choices) env
                         succed
                         (lambda () (try-next (cdr-choices))))))
      (try-next cprocs))))
