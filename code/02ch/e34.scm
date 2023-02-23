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

;;; fak i had to look at answer, i was -> this <- close just needed to switch the
;;; places of two variables
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coef higher-terms) (+ this-coef (* higher-terms x)))
              0
              coefficient-sequence))

(horner-eval 2 (list 1 3 0 5 0 1))

(enumurate-interval 0 (- (length (list 1 3 0 5 0 1)) 1))
