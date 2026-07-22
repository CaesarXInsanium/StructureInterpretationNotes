(define nil '())
(define nums (list 1 2 3 4 5 6 7 8 9))
(define (square x) (* x x))
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
(define (even-fibs n)
  (define (next k)
    (if (> k n)
        nil
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))

;; Define cool functions

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

;; New and Improved

(define (sum-odd-squares tree)
  (accumulate + 0 (map square
                       (filter odd? (enumurate-tree tree)))))
(sum-odd-squares nums)

(define (even-fibs n)
  (accumulate cons nil (filter even? 
                               (map fib
                                    (enumurate-interval 0 n)))))
(even-fibs 10)                                         

;; Reuse same components

(define (list-of-fib-square n)
  (accumulate cons nil (map square
                            (map fib (enumurate-interval 0 n)))))

(list-of-fib-square 10)

(define (product-of-squares-of-odd-elements sequence)
  (accumulate * 1 (map square
                       (filter odd? sequence))))

(product-of-squares-of-odd-elements (list 1 2 3 4 5))

(define (salary-of-higher-paid-programmer records)
  (accumulate max 0 (map salary
                         (filter programmer? record))))

