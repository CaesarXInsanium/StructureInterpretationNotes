(define (print what x)
  (display "Value of ")
  (display what)
  (display ": ")
  (display x)
  (newline)
  x)
(define (square x) (* x x))
;; Points
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;; Segments

(define (make-segment P Q) (cons P Q))
(define (default-segment) (make-segment (make-point 0 0) (make-point 0 0)))

(define (start-segment s) (car s))
(define (end-segment s) (cdr s))


(define (get-length s)
  (let ((start (start-segment s))
        (end (end-segment s)))
       (let ((x1 (x-point start))
             (x2 (x-point end))
             (y1 (y-point start))
             (y2 (y-point end)))
            (sqrt (+ (square (- x2 x1))
                    (square (- y2 y1)))))))

(define (get-line-slope s)
  (let ((dy (- (y-point (end-segment s)) (y-point (start-segment s))))
        (dx (- (x-point (end-segment s)) (x-point (start-segment s)))))
       (let ((slope (/ dy dx)))
         slope)))
         

(define (is-parallel s1 s2)
  (= (get-line-slope s1) (get-line-slope s2)))

(define (is-perpindicular s1 s2)
  (let ((m1 (get-line-slope s1))
        (m2 (get-line-slope s2)))
       (= s1 (- 0 s2))))

;; RECT
;; Rectangles can be define as two lines parallel lines of equal lenght
(define (make-rekt s1 s2)
  (if (and (is-parallel s1 s2) (= (get-length s1) (get-length s2)))
      (cons s1 s2)
      (cons (default-segment) (default-segment))))
(define (side-a r) (car r))
(define (side-b r)
  (let ((p (start-segment (car r)))
        (q (start-segment (cdr r))))
    (make-segment p q)))

(define (get-perimeter r)
  (let ((a (get-length (side-a r)))
        (b (get-length (side-b r))))
       (* (+ a b) 2)))

(define (get-area r)
  (let ((a (get-length (side-a r)))
        (b (get-length (side-b r))))
       (* a b)))

(define rek (make-rekt (make-segment (make-point 2 2) (make-point 4 2))
                       (make-segment (make-point 2 7) (make-point 4 7))))
(display "Starting!\n")
(display (get-perimeter rek))
(newline)
(display (get-area rek))
