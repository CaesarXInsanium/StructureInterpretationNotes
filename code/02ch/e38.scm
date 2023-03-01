;; Define Important functions
(define nil '())

;; Begin


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

(fold-right / 1 (list 1 2 3)) ;; => 3 / 2
(fold-left / 1 (list 1 2 3)) ;; 1/6

(fold-right list nil (list 1 2 3)) ;; => (1 (2 (3 ())))
(fold-left list nil (list 1 2 3)) ;; => (((() 1) 2) 3)

;; Addition has the associative property
(fold-left + 1 (list 1 2 3)) ;; => 7
(fold-right + 1 (list 1 2 3)) ;; => 7

;; Multiplication too
(fold-left * 1 (list 1 2 3)) ;; => 6
(fold-right * 1 (list 1 2 3)) ;; => 6
