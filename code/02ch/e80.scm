(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No Method for these types -- APPLY-GENERIC"
           (list op type-tag))))))

(define (zero? x) (= x 0))

(define (=zero? x)
  (apply-generic 'zero x))

;; inside arithmetic
(put 'zero (lambda (x) (if (number? x) (zero? ) (error "Not a Scheme Number"))))

;; inside complex
(put 'zero 'complex (lambda (x) 
                      (and (zero? (real-part x))
                           (zero (imag-part x)))))

;; inside rat
(put 'zero 'rat (lambda (x) (zero? (numer x))))

;; we can allow for definitions in terms of itself. in case rational numbers and
;; and other expression want in on some recursive data structure action.
