;; #lang scheme
;; -*- geiser-scheme-implementation: guile -*-

;; really

(define (num n)
  (display "Loop Number")
  (display n)
  (display ".\n")
  (not (= n 5)))


(define (repeat start end f)
  (define (iter current end f)
    (define stop (f current))
    (cond
      ((and (not (= current end)) stop) (iter (+ current 1) end f))
      ((= current end) (display "Loop Ended"))))
    
  
  (iter start end f))


(repeat 0 10 num)
