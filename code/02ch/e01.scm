(define (gcd a b) 
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (onlyone n d)
  (cond ((and (> n 0) (> d 0)) (cons n d))
        ((and (< n 0) (< d 0)) (cons (- 0 n) (- 0 d)))
        ((< d 0) (cons (- 0 n) (- 0 d)))
        (else (cons n d))))

(define (make-rat n d)
  (let ((x (onlyone n d))
        (g (gcd n d)))
       (cons (/ (car x) g) (/ (cdr x) g))))

(make-rat 6 12)
    
                             
        

