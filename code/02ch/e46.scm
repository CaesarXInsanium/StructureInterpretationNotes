(define (make-vect x y) (list x y))

(define (vect? v) (and (= 2 (length v))
                       (number? (list-ref v 0))
                       (number? (list-ref v 1))))

(define (xcor-vect v) (list-ref v 0))
(define (ycor-vect v) (list-ref v 1))

(define (scale-vect v x)
  (make-vect (* (xcor-vect v) x)
             (* (ycor-vect v) x)))

(define (add-vect a b)
  (make-vect (+ (xcor-vect a) (xcor-vect b))
             (+ (ycor-vect a) (ycor-vect b))))

(define (sub-vect a b)
  (add-vect a (scale-vect b -1)))

(define v (make-vect 1 2))
(define vv (make-vect 2 3))

(vect? v)

(add-vect v vv)
