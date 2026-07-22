;; I use `import` because I wish to conform to R7RS
;; stream stuff is in this library
;; (use-modules (srfi srfi-41))
(import (rename (srfi srfi-41)
                (stream-cons cons-stream)))

;; code inside of srfi
(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define s (cons-stream 1 (add-streams s s)))

;; End of SICP code
(display (stream->list 100 s))
(newline)
