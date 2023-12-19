(define nil '())
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (reverse items)
  (if (null? (cdr items))
    items
    (append (reverse (cdr items))
            (cons (car items) nil))))


(define l (list 0 1 2 3 4))
(reverse l)

(define (relu x)
(if (< x 0)
    0
    x))