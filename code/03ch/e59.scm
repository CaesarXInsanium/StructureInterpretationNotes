(import (srfi srfi-41))

(define (print-stream n stream)
  (display (stream->list n stream))
  (newline))

;; A: I copied this code. https://mk12.github.io/sicp/exercise/3/5.html
;; I don't get it. now I get it. I don't understand how to reach this point

(define (integrate-series power-series)
  (stream-map / power-series (integers-starting-from 1)))

;; B. this section I did. scouts honor
(define neg (lambda (x) (- 0 x)))
(define exp-series (stream-cons 1 (integrate-series exp-series)))
(define sine-series (stream-cons 0 (integrate-series consine-series)))
(define cosine-series (stream-cons 1 (stream-map neg sine-series)))

;; Now I remember why I quit this stuff. It is so hard to wrap my brain around the
;; concepts here that I get depressed because I can't
