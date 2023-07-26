(define (make-vec x y z) (list x y z))

(define (vec? v) (and (= 3 (list-length v))
                      (number? (list-ref v 0))
                      (number? (list-ref v 1))
                      (number? (list-ref v 2))))

(define (vecx v) (list-ref v 0))
(define (vecy v) (list-ref v 1))
(define (vecz v) (list-ref v 2))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vec (origin-frame frame)
             (add-vec (scale-vec (vecx v)
                                 (edge1-frame frame))
                      (scale-vec (vecy v)
                                 (edge2-frame frame))))))


(define (make-frame origin edge1 edge2)
        (list origin edge1 edge2))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each (lambda (segment)
                (draw-line ((frame-coord-map frame) (start-segment segment))
                           ((frame-coord-map frame) (end-segment segment))))
              segment-list)))
