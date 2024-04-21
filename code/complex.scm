(make-from-real-imag (real-part z) (imag-part z))
(make-from-mag-ang (magnitude z) (angle z))

(define (add-complex z1 z2)
  ((make-from-real-imag (+ (real-part z1) (real-part z2))
                        (+ (imag-part z1) (imag-part z2)))))

(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))

;; multiplication and division is easier with polar representation

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))


(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

;; Can only deal with the Rectangular representation
(define (real-part) (car z))
(define (imag-part z) (cdr z))

(define (magnitude z) (sqrt (+ (square (real-part z)) (square (imag-part z)))))

(define (angle z) (atan (imag-part z) (real-part z)))

(define (make-from-real-imag x y) (cons x y))

;; conversion from polar
(define (make-from-mag-ang r a) (cons (* r (cos z)) (* (sin a))))

(define (real-part z) (* (magnitude z) (cos (angle z))))

(define (imag-part z) (* (magnitude z) (sin (angle z))))

(define (magnitude z) (car z))

(define (angle z) (cdr z))

(define (make-from-real-img x y)
  (cons (sqrt (+ (Square x) (square y)))
        (atan y x)))

 (define (make-from-mag-ang r a) (cons r a))
