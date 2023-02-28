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

(define (accumulate-n op init seps)
  (if (null? (car seps))
      nil
      (cons (accumulate op init (map (lambda (list) (car list)) 
                                     seps))
            (accumulate-n op init (map (lambda (list) (cdr list)) 
                                       seps))))) 

(define vec3 (list (list 1 2 3)
                   (list 4 5 6)
                   (list 7 8 9)))
(define s (list (list 1 2 3)
                (list 4 5 6)
                (list 7 8 9)
                (list 10 11 12)))
(define a (list (list 1 2)
                (list 3 4)))

(define b (list (list 1 2 3 4)
                (list 5 6 7 8)
                (list 9 10 11 12)
                (list 13 14 15 16)))


(accumulate-n + 0 vec3)
(accumulate-n + 0 s)
(accumulate-n + 0 a)
(accumulate-n + 0 b)
