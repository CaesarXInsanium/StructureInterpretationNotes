# Structure and Interpretation of Computer Programs Notes

Now that I have checked once again the table of contents of SICP, I actually
recognize some of the stuff that is in it.

## Goals

- [x] reorganize the pandoc setup so as to have a proper PDF output
- [ ] finish book
- [x] learn to code, hard way
- [x] create strategy for organizing exercises
- [X] configure Neovim for note-taking. Since I am back this is hard, I have
  configured Neovim to be a good TEXT editor, less focus on code editing
- [x] write compiler in GNU Guile

I have decided at this point that the lectures are a waste of time. The lecturer
seems to really like spending his time writing stuff on the chalkboard.
Something which bores me to no end.

## Example of Scheme Code

``` scheme
(define (square x) (* x x))
(define relu (lambda (x) (if (< x 0) 0 x)))

(square 3) ;; => 9
(relu 7) ;; => 7
(display "Hello World!\n") ;; Writes to standard out.
(relu -2) ;; => 0
```

## Rereading

If in the future I am rereading the notes, take heed: start at streams section
'3.3'.

Basically all of chapter 4, specially in the section of database query language,
most if not all of the exercises are skipped.
