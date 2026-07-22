(define (list->tree elements)
  (car (partial-tree elements (length elements))))

;; function for convertin an ordered list of elements into a balance
;; binary search tree
(define (partial-tree elts n)
  (if (= n 0)
      (cons nil elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(partial-tree (list 1 3 5 7 9 11))
(list->tree (list 1 3 5 7 9 11))

;; it does not work, and I have run out of time
;; it checked the answerrs and I still do not get it
