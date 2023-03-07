;; Define Important functions
(define nil '())


(define (accumulate op initial sequence)
  (if (null? sequence)
      initial (op (car sequence)
                  (accumulate op initial (cdr sequence)))))

(define (enumurate-interval low high)
  (if (> low high)
      nil
      (cons low (enumurate-interval (+ low 1) high))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))


;; Begin

(define (gen-pairs n) 
  (accumulate append
              nil
              (map (lambda (i) 
                     (map (lambda (j)
                            (list i j))
                          (enumurate-interval 1 (- i 1))))
                   (enumurate-interval 1 n))))

(define (gen n)
  (let ((pairs (gen-pairs n))
        (interval (enumurate-interval 1 n)))
    (accumulate append
                nil
                (map (lambda (pair)
                       (map (lambda (int)
                              (list (list-ref pair 0) (list-ref pair 1) int))
                            interval))
                     pairs))))

(define (triples n s)
  (filter (lambda (triple)
            (= s (accumulate + 0 triple)))
          (gen n)))

(triples 10 5)
(triples 13 7)
(display result)
(newline)
