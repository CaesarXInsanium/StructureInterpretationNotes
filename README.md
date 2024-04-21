# Structure and Interpretation of Computer Programs Notes

This repo contains my personal self study notes from reading the book by
Abelson, Sussman, and the other Sussman. To be more specific the second
edition.

~~Currently stuck on chapter 2, skipped my last exercise. Will now focus
on learning computer systems and algorithms.~~

I am back from suffering in Algorithms land. By that I mean that I was
procrastinating and doing other unrelated things. I was reading Art of
Computer Programming and I got even more depressed because I could get
fast enough to my true goal of writing my own Minecraft clone.

Crafting Interpreters can be read before or after this book.

## Goals

-   [ ] finish book
-   [ ] learn ORG mode
    -   failed because I have no loyalty to any editor. Also I am
        thinking of setting everything back to markdown files
    -   I like neovim keybindings
    -   I dislike some Emacs
-   [x] Learn a LISP language
-   [x] learn to code, hard way
-   [x] create a strategy for note-taking
-   [x] create strategy for organizing exercises
-   [x] configure Neovim for Lisp code editing
-   [x] configure Neovim for note-taking.
    -   [x] configure for ORG documents
-   [x] attempt to use other editors for writing code
    -   sticking to Emacs with Lisp editing tools and Geiser
-   [x] write compiler in GNU Guild
-   [x] move all notes to Notes to ORG documents
-   [x] switch to my own configured version of emacs
-   [ ] stick to Emacs for SICP, helix for everything and anything that
    has a proper language server
    -   failed bacause I suck

## Example of Scheme Code

``` scheme
(define (square x) (* x x))
(define relu (lambda (x) (if (< x 0)
                             0
                             x))))
(square 3)
(relu 7)
(display "Hello World!\n")
(relu -2)
```
