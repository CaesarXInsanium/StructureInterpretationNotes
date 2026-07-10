## 4.3 None Deterministic Computing

On a first reading this section seems to be talking about the ability for
non-deterministic computing to be implemented in terms of a brand new special
form known as `amb`. This form is supposed to implement automatic search, but I
don't really understand the significance.

It one way to make state explicit, but from what I can garner about the
definition of "non-deterministic", is that there is no gurantee that executing
the same function with same arguments will result in the same result.

So the book is talking about providing a predicate and a list of objects. The
interpreter will continue testing the predicate against the list of object until
one of them is reached that evaluates to true.

It is based on the illusion that time branches out, and one branch might contain
useful work that can then be saved and used, and all the others are discarded.

### 4.3.2 Amb and Search

> Code will be in `code/AmbSearch.scm`

The main concept is that `amb` will take a list of expression and returns just
one of them.

```scheme
(list (amb 1 2 3) (amb 'a 'b))
```

There are six possible values from this expression but only one will be
returned.

When used in conjunction with infinite streams, it becomes possible to create a
procedure that returns just one element at a time, but with no promises mixed
in. Each time the procedure is called, it returns a different object.

So, I think it seems to like spin off multiple threads until either one succeds
or they all fail. The children  can spin of their own children.

So it combines delayed execution with filtering. It basically allows for
multidimensional time travel until at least one path succeds.

It has to be matched with the `require` form.

```scheme
(define (require p) (if (not p) (amb)))
```

Calling `amb` with no arguments is the fail notification system. The evaluater
will generally always choose the first expression and go from there as that as
the non-deterministic choice point. This section has some built in time travel
into the interpretation engine. The whole joint implements the algorithm of
depth first search. Where the actual search functionality is done by the
language runtime itself.

> **I have decided**: All exercises I am not gonna even bother. Save time and
> finish chapter 4
> Also: it seems the answer key I was reading has run out so...

All of this to make the language runtime learn a set of requirements and tell it
to find the thing that we are looking for in an infinite or even finite stream.

### 4.3.2 Examples of Non-deterministic Programs

Getting rid of the explicit search, let the language runtime deal with that.
What the code can no do is set the predicates for successful runs. The program
can now do brute force, but implicit.

Yep, it is syntax sugar for brute force.

Connecting back to the concept of parsing, according to some grammar rules,
`amb` might be useful in the sense that maybe the parser interprets a token as
the beginning of one rule, but actually it is part of another rule. The
backtracking ability allows for path correction from this perspective.

*Grammar rules mentioned!*

I seen this shit before, in "Crafting Interpreters". While over there, it was
more akin to pattern matching, here it is "have the compiler try a bunch of
different things and automatically find the one thing that works". Which is
actually ambiguous grammar rules and stuff.

Of course the code here expresses recursive grammar rules.

### 4.3.3 Implementing the `amb` Evaluator

So this section will deal with implementing the `amb` evaluator. The ability to
find a dead end in the execution and backtrack to try and find new paths
forward.

I think what will happen is that a path will be chosen, but a thunk will be
kept. If the execution path happens to decide that it is a dead end. then a
failure mode will be triggered, and the saved thunk will be executed next.
The thunk itself would hold all the information needed to backtrack again if
need be.

`amb` expression define the divergence points. Also I just realize that this
execution model being describe is strickingly similar to try catch exceptions in
some poorly design languages. I personally prefer option/result enums and
monads. But what do I know. Just that I am decades ahead in time of this book.

The core is the procedure `ambeval`. It does the analysing of the wrapped `amp`
expression.

`amb `expression also works together with conditional expressions. I don't
really understand though.

I think, that what is happened is that the whole evaluator is being rework so as
to support the `amb` form. A lot of code to read/copy and not fully understand.

I realize that a lot of code patterns are being repeated here. Which would make
refactoring a massive pain in this particular circumstance.

Assignments might fail, so a backup plan of undoing the assignment must be set
in place, to be done in the case of execution failure. Does the code set back in
the previous value? Analyze assignment is indeed super wack.

There is even a new implementation of the driver loop. Should I even bother?
