(define (make-interval a b) (cons a b))
(define (lower-bound x) (min (car x) (cdr x)))
(define (upper-bound x) (max (car x) (cdr x)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))


(define (div-interval x y) (if (= 0 (width y)) 
                               (begin (display "Error dividing by zero\n")
                                      (make-interval 0 0))
                               (mul-interval x (make-interval (/ 1.0 (upper-bound y))
                                                              (/ 1.0 (lower-bound y))))))

(define (width x) (/ (- (upper-bound x) (lower-bound x)) 2))

(define x (make-interval 1 1))
(define y (make-interval 4 9))
(div-interval y x)
