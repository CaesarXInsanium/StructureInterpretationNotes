;; Start Exercise: Reimplement the basic operators assuming that there
;; are repeated elements in a given set

;; is the same since if at least one instance exists than the answer is yes
(define (element-of-set? x set)
  (cond ((null? set) false)             ; elements cannot be part of empty sets
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

;; does not give a fuck
(define (adjoin-set x set)
  (cons x set))

;;; mathematically this does not make sense. I have little time so I will
;; check the answer sheet
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

;; Answer to 2.59, add elements in both sets into one
(define (union-set a b)
  (cond ((or (null? a) (null? b)) '())
        ((element-of-set? (car a) b)
         (union-set (cdr a) b))
        (else (cons (car a)
                    (union-set (cdr a) b)))))

;; not a very interesting exercise
