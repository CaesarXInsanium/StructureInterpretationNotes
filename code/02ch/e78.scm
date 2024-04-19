;; modify so that it uses built in functions
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number  scheme-number)
       (lambda (x y) (tag (/ x y))))
  'done)

(define (attach-tag type-tag contents)
  (if (number? contents)
    contents
    (cons type-tag contents)))

(define (type-tag datum)
  (if (pair? datum)
    (car datum)
    (if (number? (cdr datum))
      'scheme-number
      (error "Bad Tagged Datum -- TYPE-TAG" datum))))

(define (contents datum)
  (if (pair? datum)
    (cdr datum)
    (if (number? datum)
      datum
      (error "Bad Tagged datum -- CONTENTS" datum))))
      
