;; Define Important functions
(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (enumurate-interval low high)
  (if (> low high)
      nil
      (cons low (enumurate-interval (+ low 1) high))))

;; Begin

;; Copy pasta code?
(define (unique-pairs n) 
  (accumulate append
              nil
              (map (lambda (i) 
                     (map (lambda (j)
                            (cons i j))
                          (enumurate-interval 1 (- i 1))))
                   (enumurate-interval 1 n))))
(unique-pairs 5)
(map (lambda (pair) 
       (list (car pair) 
             (cdr pair) 
             (+ (car pair) 
                (cdr pair)))) 
     (unique-pairs 3))

(define (prime-sum-pairs n)
  (filter (lambda (ls) 
            (prime? (list-ref ls 
                              2))) 
        (map (lambda (pair) 
               (list (car pair) 
                     (cdr pair) 
                     (+ (car pair) 
                        (cdr pair)))) 
             (unique-pairs n))))

(prime-sum-pairs 5

;; Pull From Internet

 (define (prime-sum-pairs n) 
   (map make-sum-pair 
        (filter prime-sum? (unique-pairs n))))) 
