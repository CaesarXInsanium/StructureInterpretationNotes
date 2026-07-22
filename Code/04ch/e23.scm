;; Exercise 4.23
;; The work that the other procedure implemention was doing is not being  done by
;; this new implementation.
;; The whole thing is suppose to return a thunk, while this one skips straight to
;; executing and evaluating the code
(define (analyze-sequence exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs)) ((car procs) env))
          (else ((car procs) env)
                (execute-sequence (cdr procs))))))
