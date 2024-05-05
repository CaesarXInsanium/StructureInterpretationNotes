(define NULL '())
;; main header contains symbol, comparison procedure
(define (make-tree) (list 'tree cmp NULL))
;; call comparison functions with arguments
(define (tcmp tree) (list-ref tree 1))

(define (node-key node)
  (if (null? node)
    (error "NODE-VALUE valled on nil ")
    (car (car node))))

(define (node-value node)
  (if (null? node)
    (cdr (car node))))

(define (node-left node) (car (cdr node)))
(define (node-right node) (cdr (cdr node)))

(define (empty-tree? tree) (null? (list-ref tree 2)))
(define (tree-head tree) (list-ref tree 2))


(define (lookup tree key)
  (define cmp (tcmp tree))
  (define (node-lookup node key)
    (if (null? node)
      false
      (let ((cmp-result (cmp key (node-key node))))
        (cond ((eq? 'less cmp-result) (node-lookup (node-left node) key))
              ((eq? 'equal cmp-result) (node-value node))
              ((eq? 'greater cmp-result) (node-lookup (node-right node) key))
              (else (error "unexpected symbol in node-lookup"))))))
  (if (empty-tree? tree)
    false
    (node-lookup (tree-head tree) key)))
  
;; to look up an item

;; that was an actual enjoyable experience, but time is up
