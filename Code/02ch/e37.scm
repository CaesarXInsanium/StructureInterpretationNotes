;; Define Important functions
(define nil '())

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (reverse items)
  (if (null? (cdr items))
      items
      (append (reverse (cdr items))
              (cons (car items) nil))))
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumurate-interval low high)
  (if (> low high)
      nil
      (cons low (enumurate-interval (+ low 1) high))))

(define (enumurate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumurate-tree (car tree))
                      (enumurate-tree (cdr tree))))))

(define (accumulate-n op init seps)
  (if (null? (car seps))
      nil
      (cons (accumulate op init (map (lambda (list) (car list)) 
                                     seps))
            (accumulate-n op init (map (lambda (list) (cdr list)) 
                                       seps))))) 

;; Begin

(define m1 (list (list 1 2 3 4)
                 (list 5 6 7 8)
                 (list 9 10 11 12)
                 (list 13 14 15 16)))

(define m2 (list (list 1 3 7 9)
                 (list 3 4 5 8)
                 (list 7 5 0 4)
                 (list 9 8 4 2)))

(define v1 (list 1 2 3 4))
(define v2 (list 5 6 7 8))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(dot-product v1 v2)

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product v row)) m))

(matrix-*-vector m1 v1)

(define (transpose mat)
  (accumulate-n cons nil mat))

(transpose m1)

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row) )m)))

(matrix-*-matrix m1 m2)
