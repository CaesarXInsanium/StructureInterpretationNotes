;; little change is needed
(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (empty-deque? deque) (null? (front-ptr deque)))
(define NULL '())
(define (make-deque) (cons NULL NULL))

(define (front-deque deque)
    (if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (car (front-ptr deque))))

(define (rear-deque deque)
    (if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (car (rear-ptr deque))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (cons item NULL)))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           deque)
          (else (set-cdr! (rear-ptr deque) new-pair)
                (set-rear-ptr! deque new-pair)
                deque))))

(define (front-insert-deque deque item)
  (let ((new-pair (cons item NULL)))
    (cond ((empty-deque? deque) 
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           deque)
          (else
            (set-cdr! new-pair (front-ptr deque))
            (set-front-ptr! deque new-pair)
            deque))))
(define (rear-insert deque item)
  (let ((new-pair (cons item NULL)))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           deque)
          (else (set-cdr! (rear-ptr deque) new-pair)
                (set-rear-ptr! deque new-pair)))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with an empty deque" deque))
        (else (set-front-ptr! deque (cdr (front-ptr deque)))
              deque)))

;; i made a best effort, i just want to finish this book before i die
;; in my mind dequeu are just a logical next step for queues, so implementing them
;; is as simple as extending the code given by the book
