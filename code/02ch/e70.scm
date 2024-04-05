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

(define initial-leaves '(('A . 2)
                         ('BOOM . 1)
                         ('GET . 2)
                         ('JOB . 2)
                         ('NA . 16)
                         ('YIP . 9)
                         ('WAH . 1)))

(define (pair-compare a b)
  (> (cdr a) (cdr b)))



;; i give up
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (successive-merge set)
  (accumulate make-code-tree (car set) (cdr set)))
