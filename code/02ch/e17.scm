;; Dont Worry I skipped some exercies because they looked boring and I was depressed.

(define (last-pair l)
  (if (null? (cdr l))
      (car l)
      (last-pair (cdr l))))

(define l (list 1 2 3 4))
(last-pair l)
