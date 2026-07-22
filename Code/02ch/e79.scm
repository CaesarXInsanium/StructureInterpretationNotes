;;; Don't bother trying to exevute this file. it wont work.
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No Method for these types -- APPLY-GENERIC"
           (list op type-tag))))))

(define (equ? x y)
  (apply-generic 'equal x y))

;; inside arithmetic-package
(define (equal x y)
  (= x y))

(put 'equal '(scheme-number scheme-number) (lambda (x y) (equal x y)))

;; inside complex
(define (equal-complex x y)
  (and (= (car x) (car y))
       (= (cdr x) (cdr y))))

(put 'equal '(complex-number complex-number) (lambda (x y) (equal-complex x y)))

;; inside rational package
(define (equal-rat x y)
  (and (= (car x) (car y))
       (= (cdr x) (cdr y))))

(put 'equal '(complex-number complex-number) (lambda (x y) (equal-rat x y)))

;; I just checked and my answers are wrong, as expected
