;; Library Functions
(define (frame-coord-map frame)
  (lambda (v)
    (add-vec (origin-frame frame)
             (add-vec (scale-vec (vecx v)
                                 (edge1-frame frame))
                      (scale-vec (vecy v)
                                 (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each (lambda (segment)
                (draw-line ((frame-coord-map frame) (start-segment segment))
                           ((frame-coord-map frame) (end-segment segment))))
              segment-list)))
(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

;; Begin

;; 180 degrees?
(define (rotate180 painter)
  (rotate90 (rotate90 painter)))

;; 270 degrees?
(define (rotate270 painter)
  (rotate90 (rotate90 (rotate90 painter))))

(define (flip-horiz painter)
  (rotate180 (flip-vert painter)))
