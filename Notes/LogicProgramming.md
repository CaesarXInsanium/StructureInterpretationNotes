## 4.4 Logic Programming **REREAD**

We are moving away from programming languages being a means for expressions to
show a computer steps on how to compute a single value, but rather to
constraints and definitions in which one expression/program can exemplify any
number of values or categories of values.

We are moving over to from how to to what is.

> Code will generate a new list with y at attached to x.

```scheme
(define (append x y)
  (if (null? x)
    y
    (cons (car x) (append (cdr x) y))))
```

It appears that the language will now deal with creating a DSL for querying data
from a database. It will be like SQL but lispy. The book will focus on writing
an interpreter for such a language. There will be a heavy use of streams.

> Code might be in `code/DatabaseQuery.scm`

### 4.4.1 Deductive Information Retrieval

Writing the language to describe patterns and have the system spit out entries
in the database that match those patterns.

There are `and` queries which must find entries that satisfy all the given
predicates. `or` queries can match any one of the entries. `not` qualifiers does
all of that flips it. The sub note says that this `not` does not perfectly match
boolean algebra `not`. It will be explained later they say.

> Exercises are skipped.

There is the rule compound query, which joins some queries into one predicate.
It is a very basic function like construct.

I am starting to see that the last section was about building a means to
implement this query based language thing.

### 4.4.2 How the Query System Works

Lo an behold, I was right. It make use of the `amb` form. And now I can see how
this section can fit into the being able to create a compiler. It is about
making a language for pattern matching. Being able to patter  match is how
parsing is done.

This is basically an intro to database design and implementation, from a DSL
standpoint.

Something about unifiers. There is a driver loop which is a REPL in which an
user would type in queries and the result of those queries would be shown to the
user.

### 4.4.3 Is Logic Programming Mathematical Logic?

It becomes necessary to use streams and delayed evaluation, as the somethings
infinite lists generate from a query. There has to be a way to handle this.

What I am getting here is that programming languages can be so powerful as to be
declarative, the programmer can describe the problem space and the computer is
the one that needs to find the solution for it.

After finishing this chapter, I have come to the conclusion that everything that
I just read has gone way over my head.
