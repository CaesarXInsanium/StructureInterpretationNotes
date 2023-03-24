;; Define Important functions
(define nil '())


(define (accumulate op initial sequence)
  (if (null? sequence)
      initial (op (car sequence)
                  (accumulate op initial (cdr sequence)))))

(define (enumurate-interval low high)
  (if (> low high)
      nil
      (cons low (enumurate-interval (+ low 1) high))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))


;; Begin

(define (make-board n) (map (lambda (item) (make-list n 0)) (make-list n)))
(make-board 9)

(define (safe? k positions)
  (newline))
(define (rest-of-queens n) (newline))
(define (new-row n) (newline))


; provided by book
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter (lambda (positions)
                  (safe? k positions))
                (flatmap (lambda (rest-of-queens)
                           (map (lambda (new-row)
                                  (adjoin-position new-row k rest-of-queens))
                                (enumurate-interval 1 board-size)))
                         (queen-cols (- k 1))))))
  (queen-cols board-size))
