(define true #t)
(define false #f)

(define (element-of-set? x set)
  (cond ((null? set) false)             ; elements cannot be part of empty sets
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

;; create new set with added element
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))
;; implement union-set using given functions
;; I simply realized that they are doing the same thing just switched branches
;; we just have to make sure that there are not repeats in the resulting
;; set
(define (union-set a b)
  (cond ((or (null? a) (null? b)) '())
        ((element-of-set? (car a) b)
         (union-set (cdr a) b))
        (else (cons (car a)
                    (union-set (cdr a) b)))))
