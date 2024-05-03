(define (make-queue)
  (let ((front-ptr NULL)
        (rear-ptr NULL))
    (define (front-queue queue))
    (define (set-front-ptr! queue item))
    (define (set-rear-ptr! queue item))
    (define (insert-queue! queue item)
      (let ((new-pair (cons item NULL)))
        (cond ((empty-queue?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair))
              (else))))
    (define (empty-queue?) (null? front-ptr))
    (define (delete-queue! queue))
    (define (dispatch m) ...)
    dispatch))

;; time's up
;; dewey's answer is genius
