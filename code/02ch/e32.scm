(define nil '())

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (items) (cons (car s) items)) rest)))))

(subsets (list 1 2 3))

;; I have no clue on how my code words and why
