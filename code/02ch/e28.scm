(define nil '())

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
;;; stolen code
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (deep-reverse items)
  (if (null? (cdr items))
      items
      (let ((deep (if (list? (car items))
                      (deep-reverse (car items))
                      (car items))))
        (append (deep-reverse (cdr items))
                (cons deep nil)))))

;; Begin Exercise

(define x (list (list 1 2) (list 3 4)))
(define y (list 1))
(define z (list 3 (list 4 5)))
