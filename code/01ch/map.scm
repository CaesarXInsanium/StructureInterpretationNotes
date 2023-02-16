(define nil '())
(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))


(map (lambda (x) (+ x 2)) (list 1 2 3 4 5))
(map abs (list -10 2.5 -11.6 17))

;; Scheme Standard defines a map function that takes in a procedure of n parameters
;; and with n lists of same length
(map (lambda (x y z) (+ x y z)) (list 1 2 3) (list 4 5 6) (list 7 8 9))

(define (scale-list items factor)
  (map (lambda (x) (* factor x)) items))
