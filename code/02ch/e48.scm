(define (make-vect x y) (list x y))

(define (vect? v) (and (= 2 (length v))
                       (number? (list-ref v 0))
                       (number? (list-ref v 1))))

(define (xcor-vect v) (list-ref v 0))
(define (ycor-vect v) (list-ref v 1))

;; Exercise Start


(define (make-segment start end)
  (list start end))


(define (start-segment seg)
  (list-ref seg 0))

(define (end-segment seg)
  (list-ref seg 1))

(define (segment? seg)
  (and (vect? (start-segment seg))
       (vect? (end-segment seg))
       (= 2 (length seg))))

(make-vect 5 6)

(segment? (make-segment (make-vect 1 2)
                        (make-vect 4 5)))

