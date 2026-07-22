(format #t "Hello World!~%")

(put '=zero? 'polynomial
     (lambda (p)
       (or (= 2 (length (term-list p)))
           (and (=zero? (coeff))))))

;; implement the =zero? procedure for 'polynomial
;; wrong answer
