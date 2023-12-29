;; nice

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol char tree) 
  (cond ((leaf? tree) '()) 
        ((memq char (symbols (left-branch tree))) 
         (cons 0 (encode-symbol char (left-branch tree)))) 
        ((memq char (symbols (right-branch tree))) 
         (cons 1 (encode-symbol char (right-branch tree)))) 
        (else (error "symbol not in tree" char)))) 

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;; start: define succesive-merge

(define initial-leaves '(('A . 8)
                         ('B . 3)
                         ('C . 1)
                         ('D . 1)
                         ('E . 1)
                         ('F . 1)
                         ('G . 1)
                         ('H . 1)))

(define (pair-compare a b)
  (> (cdr a) (cdr b)))


(define (find-min l proc)
  (define (find-min-iter min l proc)
    (if (null? l) min (if (proc min (car l))
                          (find-min-iter min (cdr l) proc)
                          (find-min-iter (car l) (cdr l) proc))))
  (find-min-iter (car l) l proc))
