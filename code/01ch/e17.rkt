;; Again stolen from the internet
 (define (fast-mult-by-add a b) 
   (define (double x) (+ x x)) 
   (define (halve x) (/ x 2)) 
    
   (define (helper a b product) ;; "add a" b times 
     (cond ((= b 0) product) 
           ((even? b) (helper (double a) (halve b) product)) 
           (else (helper a (- b 1) (+ a product))))) 
   (helper a b 0)) 
