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

;; Begin

(define (reverse sequence)
  (fold-right (lambda (x y) (newline)) nil sequence))

(define (reverse sequence)
  (fold-left (lambda (x y) (newline)) nil sequence))
