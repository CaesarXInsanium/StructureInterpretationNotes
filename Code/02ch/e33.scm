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

;; Start

(define (map p sequence)
  (accumulate (lambda (x y) 
                (cons (p x) 
                      y)) 
              nil sequence))

(map square (list 1 2 3 4))

(define (append seq1 seq2)
  (accumulate cons seq1 seq2))

(append (list 1 2 3 4) (list 5 6 7 8))

(define (length sequence)
  (accumulate  (lambda (item rest) (+ rest 1)) 0 sequence))

(length (list 1 2 3 4))
