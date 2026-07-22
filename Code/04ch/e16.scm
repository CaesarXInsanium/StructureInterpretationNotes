;; Exercise 4.16

;; Implemention of internal definitions described in current 4.1.6

;; A
;; Show error if special *unassigned* literal is retrieved
(define (unassigned? x) (eq? x '*unassigned*))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-enviroment env)))
            ((eq? var (car vars))
             (if (unassigned? (car vals))
               (error "Attempt to access variable with *unassigned* value")
               (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-enviroment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

;; B
;; Do the transformation

;; transform inner defines to a let statement
(define (scan-out-defines proc)
  (let [(internal-definitions (get-definitions proc))]
    (make-let (definition-symbols internal-definitions) 
              (definition-values internal-definitions))))

;; depends on what the actual structure of a procedure body actually is
;; here I am assuming that it is a list of expressions
(define (get-definitions proc)
  (map definition? (procedure-body proc)))

(define (definition-symbols definitions) (map definition-symbol definitions))
(define (definition-values definitions) (map definition-value definitions))

;; I don't actually know the representation of the expressions of body of the proc
(define definition-symbol (todo!))
(define definition-value (todo!))

;; C
;; This is impossible. Also I really hate the defined interface
