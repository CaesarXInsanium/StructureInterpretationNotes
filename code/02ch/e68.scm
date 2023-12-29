(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree (make-leaf 'B 2)
                                  (make-code-tree (make-leaf 'D 1)
                                                  (make-leaf 'C 1)))))
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;; Start: define encode-symbol procedures

(define (encode-symbol sym tree)
  (if (null? tree)
      (error "Something has gone terribly wrong")
      (cond ((eq? sym (symbol-leaf tree)) ()))))

;; get symbols
;; if list is returned, then choose a branch and return a bit from that and recurse fromn there
;; if symbol is returned then return 

(define (encode-symbol sym tree)
  (let ((syms (symbols tree))
        (w (weight tree)))
    ))

;; times up
 (define (encode message tree) 
   (if (null? message) 
       '() 
       (append (encode-symbol (car message) tree) 
               (encode (cdr message) tree)))) 
  
 (define (encode-symbol sym tree) 
   (if (leaf? tree) 
       ;; tree is single node, check if sym is there, otherwise throw error
       (if (eq? sym (symbol-leaf tree)) 
           '() 
           (error "missing symbol: ENCODE-SYMBOL" sym)) 
       ;; get symbols in left branch
       (let ((left (left-branch tree))) 
         ;; if symbol exists in left branch, then go left and return 0
         (if (memq sym (symbols left)) 
             (cons 0 (encode-symbol sym left)) 
             ;; otherwise go right and return 1
             (cons 1 (encode-symbol sym (right-branch tree))))))) 

 (define (encode-symbol char tree) 
   (cond ((leaf? tree) '()) 
         ((memq char (symbols (left-branch tree))) 
          (cons 0 (encode-symbol char (left-branch tree)))) 
         ((memq char (symbols (right-branch tree))) 
          (cons 1 (encode-symbol char (right-branch tree)))) 
         (else (error "symbol not in tree" char)))) 

;; it seems that i forgot about the memq function.
