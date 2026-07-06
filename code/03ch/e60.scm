(import (srfi srfi-41))
(define take stream->list)

;; I get that we are supposed to compose stuff.
;; I am not gonna even bother trying
;; Here is code from https://mk12.github.io/sicp/exercise/3/5.html

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                            (mul-series (stream-cdr s1) s2))))
