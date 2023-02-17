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

;;; stolen code
(define (reverse items)
  (if (null? (cdr items))
      items
      (append (reverse (cdr items))
              (cons (car items) nil))))

;; before the append, if the car of times if a list, call reverse on that
;; if not then continue

;; functions to use, reverse, pair?, null?, list?


(define (deep-reverse items)
  (if (null? (cdr items))
      items
      (let ((deep (if (list? (car items))
                      (deep-reverse (car items))
                      (car items))))
        (append (deep-reverse (cdr items))
                (cons deep nil)))))


(define x (list (list 1 2) (list 3 4)))
(deep-reverse x)
