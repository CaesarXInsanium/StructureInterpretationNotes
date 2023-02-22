(define nil '())
(define (make-mobile left right)
  (list left right))

(define (make-branch len structure)
  (list len structure))

;;; Part A

(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length mobile)
  (car mobile))

(define (branch-structure branch)
  (car (cdr branch)))

(define mb (make-mobile 0 1))
(define mm (make-mobile 2 3))
(left-branch mb)
(right-branch mb)
(right-branch mm)

(define mbb (make-branch 10 nil))

;;; Part B

(define (total-weight mobile)
  (cond ((number? mobile) mobile)
        ((null? mobile) 0)
        ((list? mobile) (+ (total-weight (left-branch mobile))
                           (total-weight (right-branch mobile))))))

(total-weight mb)
(total-weight mm)

;;; Part C
;; Incorrect since I did no use torque in my calculations

(define (mobile-balanced? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (cond ((and (number? left) (number? right)) (= left right))
          ((and (not (number? left)) (number? right)) 
           (and (mobile-balanced? left) (= (total-weight left) right)))
          ((and (number? left) (not (number? right)))
           (and (= (total-weight right) left) (mobile-balanced? right)))
          (else (and (mobile-balanced? left) (mobile-balanced? right))))))

(mobile-balanced? mb)
(mobile-balanced? mm)
(define mv (make-mobile 4 4))
(mobile-balanced? mv)

;;; Part D

; I would only need to change the accessor procedures

(define (make-mobile left right)
  (cons left right))
(define (make-branch len structure) (cons left structure))

;; Changed

(define (left-branch mb) (car mb))
(define (right-branch mb) (cdr mb))
