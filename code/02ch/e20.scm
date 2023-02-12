(define nil '())

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (reverse items)
  (if (null? (cdr items))
      items
      (append (reverse (cdr items))
              (cons (car items) nil))))

;; Exercise 2.20

(define (f x y . z)
  (display x) ;; second single argument
  (newline)
  (display y) ;; second single arguments
  (newline)
  (display z) ;; is list of arguments
  (newline))

(f 1 2 3 4 5 6 7 8 9)

(define (g . w)
  (map (lambda (x) (begin (display "Value: ")
                          (display x)
                          (newline)
                          x)) w))

(g 0 1 2 3 4)

(define (parity? x y) (or (= x y) (= (remainder x 2) (remainder y 2))))

(define (same-parity-inner x items)
  (if (not (null? items))
      (if (parity? x (car items))
          (cons (car items) (same-parity-inner x (cdr items)))
          (same-parity-inner x (cdr items)))
      nil))

(define (same-parity x . items)

  (cons x (same-parity-inner x items)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)
