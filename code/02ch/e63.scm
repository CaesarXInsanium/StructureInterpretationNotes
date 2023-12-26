;; first implementation
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree)

                            )
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

;; Second implementation
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;; Start
;; generate tests, generate trees
;; create a function that generates a random tree
;;;  hay i give up
;; size n, number range r

(define (flip-coin) (= 1 (random 2)))

(define (inc-range range g)
  (cons (+ g (car range))
        (+ g (cdr range))))
(define (move-range range g proc)
  (cons (proc g (car range))
        (proc g (cdr range))))

(define (random-node n range)
  (if (flip-coin)
      (make-tree (random r) nil nil)
      (make-tree (random r) (random-node (dec n) (dec r)) (random-node (dec n) (inc) r))))

(define (random-value range)
  (let ((n (- (cdr range) (car range))))
    (+ (car range) n)))

(define (random-tree n range)
  (let ((value (random-value range))
        (key (random 3)))
    (cond ((= 2 key) (make-tree (random-value range) nil nil))
          ((= 1 key) (make-tree (random-value range) (random-tree (dec n) (move-range range value -)) nil))
          ((= 0 key (make-tree (random-value range)
                               (random-treee (dec n))
                               (move-range))))))
  )

(define (random-node flip value range)
  (if flip (make-tree value (random-node (flip-coin) ))))

(random 10)

(define t (random-node 3 10))

;; checking answers

(define a (make-tree 7
                     (make-tree 3
                                (make-tree 1 nil nil)
                                (make-tree 5 nil nil))
                     (make-tree 9
                                (make-tree 11 nil nil)
                                nil
                                )))

(define b (make-tree 3
                     (make-tree 1 nil nil)
                     (make-tree 7
                                (make-tree 5 nil nil)
                                (make-tree 9 nil (make-tree 11 nil nil)))))

(define c (make-tree 5
                     (make-tree 3
                                (make-tree 1 nil nil)
                                nil)
                     (make-tree 9
                                (make-tree 7 nil nil)
                                (make-tree 11 nil nil))))
;; apperantly the do that same thing
;; no, one is clearly less efficient, the first version might be less efficient
;; im checking the answers
