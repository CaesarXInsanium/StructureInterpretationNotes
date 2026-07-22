;; Define Important functions
(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define fold-right accumulate)

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))

(define (enumurate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumurate-tree (car tree))
                      (enumurate-tree (cdr tree))))))

;; Begin

(define (reverse sequence)
  (fold-right (lambda (x y) (enumurate-tree (list y x))) nil sequence))

(reverse (list 1 2 3 4 5 6))

(define (reversed sequence)
  (fold-left (lambda (x y) (cons y x)) nil sequence))

(reversed (list 12 13 14 15 16 17))
