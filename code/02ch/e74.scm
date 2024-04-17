(define (install-company a)
  (define (make-record-a name address salary)
    (list 'comp-a name address salary))
  (define (a-record? a) (and (list? a) (eq? (cadr a) 'comp-a)))
  (define (a-get-address record)
    (listref record 0))
  (define (a-get-record name file)
    ()))

(define (get-record name file)
  (apply-generic 'get-record name file))

(define (address record)
  (apply-generic 'address record))

(define (get-salary record)
  (apply-generic 'get-salary record))

(define (find-employee-record files name)
  ())

;; I don't get it
;; OOOOOH
;; I was suppose to implement the higer level precedure
;; OK I am dum
