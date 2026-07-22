;; Define Important functions
(define nil '())

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

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

;; Begin Exercise
(define (leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (leaves (car x))
                 (leaves (cdr x))))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (enumurate-tree t))))


(define (countleaves tree)
  (length (enumurate-tree tree)))

(define x (cons (list  1 2) (list 3 4)))

(count-leaves x)
(leaves x)
(map (lambda (x) x) (enumurate-tree x))
