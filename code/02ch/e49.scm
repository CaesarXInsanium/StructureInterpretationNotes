;; Wish List
(define (draw-line a b)
  (begin (display a)
         (newline)
         (display b)
         (newline)))

;; Vectors
(define (make-vect x y) (list x y))

(define (vect? v) (and (= 2 (length v))
                       (number? (list-ref v 0))
                       (number? (list-ref v 1))))
(define scale-vect (lambda (vec scale) (make-vect (* scale (xcor-vect vec))
                                                  (* scale (ycor-vect vec)))))

(define (xcor-vect v) (list-ref v 0))
(define (ycor-vect v) (list-ref v 1))

;; Frames
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define frame? (lambda (frame)
                 (and (= 3 (length frame))
                      (vect? (list-ref 0))
                      (vect? (list-ref 1))
                      (vect? (list-ref 2)))))

(define (origin-frame frame)
  (list-ref frame 0))

(define (edge1-frame frame)
  (list-ref frame 1))

(define (edge2-frame frame)
  (list-ref frame 2))

;; Segments
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

;; Help Procedures
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect (origin-frame frame)
             (add-vect (scale-vect (xcor-vect v)
                                  (edge1-frame frame))
                      (scale-vect (ycor-vect v)
                                 (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each (lambda (segment)
                (draw-line ((frame-coord-map frame) (start-segment segment))
                           ((frame-coord-map frame) (end-segment segment))))
              segment-list)))

;; Begin Exercise

(define frame_painter (segments->painter (list (make-segment (make-vect 0 0)
                                                             (make-vect 1 0))
                                               (make-segment (make-vect 1 0)
                                                             (make-vect 1 1))
                                               (make-segment (make-vect 1 1)
                                                             (make-vect 0 1))
                                               (make-segment (make-vect 0 1)
                                                             (make-vect 0 0)))))

(frame_painter (make-frame (make-vect 0 0) (make-vect 2 0) (make-vect 0 2)))
