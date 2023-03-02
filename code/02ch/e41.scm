;; Define Important functions
(define nil '())


(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumurate-interval low high)
  (if (> low high)
      nil
      (cons low (enumurate-interval (+ low 1) high))))

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
  (accumulate cons nil (map (lambda (pair x)
                              (append pair x))
                            (gen-pairs n)
                            (enumurate-interval 1 n))))

(list? (gen-pairs 3))
(display (gen 3))
(newline)
