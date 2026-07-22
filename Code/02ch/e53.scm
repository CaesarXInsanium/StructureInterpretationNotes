(list 'a 'b 'c)
;; $5 = (a b c)
(list (list 'george))
;; ((george))
(cdr '((x1 x2) (y1 y2)))
;; ((y1 y2))
(cadr '((x1 x2) (y1 y2)))
;; (y1 y2)
(pair? (car '(a short list)))
;; #f

(define (memq item x)
  (cond ((null? x) #f)
        ((eq? item (car x) )x)
        (else (memq item (cdr x)))))

(memq 'red '((red shoes blue socks))
;; (red shoes blue socks)
(memq 'red '(rd shoes blue socks))
;; #f
