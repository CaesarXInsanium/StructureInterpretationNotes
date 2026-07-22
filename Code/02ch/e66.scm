;; Start: implement lookup function where record is a binary tree
;; first assume that the thing is binary search tree

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) #f)
        ((equal? given-key (key (parent set-of-records)))
         (car set-of-records))
        (else (if (< given-key (key (parent set-of-records)))
                  (lookup given-key (left-branch set-of-records))
                  (lookup given-key (right-branch set-of-records))))))
