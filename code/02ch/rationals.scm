(define (make-rat n d) (cons n d))

(define (make-rat n d)
  (let ((g (gcd n d)))
       (cons (/ n g) (/ d g))))

(define (numer a) (car a))
(define (denom a) (cdr a))
(define a (make-rat 3 4)) ;; returns an abstract data structure that represents a rational number
(numer a) ;; returns numrator of rational number
(denom a) ;; return denominator.

(define (gcd a b) 
  (if (= b 0)
      a
      (gcd b (remainder a b))))


(define (print-rat rat)
  (newline)
  (display (numer rat))
  (display "/")
  (display (denom rat)))
(print-rat a)

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denon y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))


