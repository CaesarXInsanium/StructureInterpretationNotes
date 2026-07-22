;; Define Important functions
(define nil '())

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? a b) (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n ) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (prime? n) (= n (smallest-divisor n)))

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
  (if (>= low high)
      nil
      (cons low (enumurate-interval (+ low 1) high))))

(enumurate-interval -3 3)

;; Begin

(define (gen-pairs n) 
  (accumulate append
              nil
              (map (lambda (i) 
                     (map (lambda (j)
                            (list i j))
                          (enumurate-interval 1 (- i 1))))
                   (enumurate-interval 1 n))))

(gen-pairs 4)

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

;; Filter Function
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

;; Generate list with pairs and their sum
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

;; Final

(define (prime-sum-pairs n)
  (map make-pair-sum (filter prime-sum?
                             (flatmap (lambda (i)
                                        (map (lambda (j) 
                                               (list i j))
                                             (enumurate-interval 1 (- i 1))))
                                      (enumurate-interval 1 n)))))

(prime-sum-pairs 8)

;; Permutations

(define (remove item sequence)
  (filter (lambda (x) (not (= x item))) sequence))

(define (permutations s)
  (if (null? s)
      (list nil)
      (flatmap (lambda (x)
                 (map (lambda (p)
                        (cons x p))
                      (permutations (remove x s))))
               s)))

(permutations (list 1 2 3))
