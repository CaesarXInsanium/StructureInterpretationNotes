(define nil '())
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(count-leaves (cons (cons (cons 1 2)
                          4)
                    (cons 1
                          (cons 3 4))))

(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)) 10)

;; defined using map procedure
(define (scaled-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scaled-tree sub-tree factor)
             (* sub-tree factor)))
       tree))

(scaled-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)) 10)

(define (enumurate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumurate-tree (car tree))
                      (enumurate-tree (cdr tree))))))

(enumurate-tree (list 1 (list 2 (list 3 4) ) 5))
