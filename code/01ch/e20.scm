
(define (gcd a b) (display "X")(if (= b 0)
                                a
                                (gcd b (remainder a b))))

(define (test fn a b) 
 (display "A: ")
 (display a)
 (display "\t")
 (display "B: ")
 (display b)
 (display "\t")
 (display "Result: ")
 (display (fn a b))
 (newline))


(test gcd 206 40)

;; it looks like the remainder procedure is executed 18 times
