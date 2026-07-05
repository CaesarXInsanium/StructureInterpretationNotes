# Structure and Interpretation of Computer Programs Notes

This repo contains my personal self study notes from reading the book by
edition.

~~Currently stuck on chapter 2, skipped my last exercise. Will now focus
on learning computer systems and algorithms.~

~I am back from suffering in Algorithms land. By that I mean that I was
procrastinating and doing other unrelated things. I was reading Art of
Computer Programming and I got even more depressed because I could get
fast enough to my true goal of writing my own Minecraft clone.

~Crafting Interpreters can be read before or after this book.~

I am back once again. I have resolved to reread this book(or my notes) and
finish this book once and for all. I have finished Crafting Interpreters. I
hated it but I did learn some cool stuff.

Now that I have checked once again the table of contents of SICP, I actually
recognize some of the stuff that is in it.

I was planning on reading some source code BUT, I now realized I really want to
finish this book. I will be throwing/gifting the other books that I have
finished but now I realize that this book, SICP is a true godsend.

I will be on and off reading source code, reading relevant papers, learning the
`zk` command line utility, finishing the book. Lots of fun stuff. Since I now
longer have college, I can think about. The only thing keeping me going with
college was my pride. But due to personal reasons, the is no longer the case.

## Goals

- [ ] reorganize the pandoc setup so as to have a proper PDF output
- [ ] finish book
- [x] Learn a LISP language
- [x] learn to code, hard way
- [x] create strategy for organizing exercises
- [X] configure Neovim for note-taking. Since I am back this is hard, I have
  configured Neovim to be a good TEXT editor, less focus on code editing
- [x] write compiler in GNU Guile
- get rid of makefile
- add support for EPUB
- [ ] chapters 1 and 2

A lot of TODOs failed bacause I suck, as such they were deleted.

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
