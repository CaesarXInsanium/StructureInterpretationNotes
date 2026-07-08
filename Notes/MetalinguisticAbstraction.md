# Chapter 4: Metalinguistic Abstraction

First paragraph is about how book has been about using languages to describe
problems and enable for solution to be constructed using the facilities afforded
by the language itself. Machine languages(Assembly) is the language for getting
computers to perform computations for the programmer, it is just one example on the
power of languages. The main tool in formulating a language for a particular problem
set is the evaluator/interpreter/compiler. It it is used to tell the machine
exactly what to do. To quote from the book.

Sometimes, if the problem has grown in complexity to catagorize itself as a set
of problems, then maybe it might no be a bad idea to design a language to solve
that set of problems.

There are many languages can be used to solve a variety of classes of problems
so that a computer can be made to solve them automatically.

> The evaluator, which determines the meaning of expressions in a programming language
> is just another program.

A programmer is as much a language designer, as a language user. Any program
contains the primitives and procedures required to solve some problem.

Final part of introduction is a description of the different sections in this
chapter.

We are in the section in which we can start to design a language. The question
becomes, what is the thing that evaluates the characters and symbols in the
file, to a representation of a sequence of instructions and make the computer do
something that is hopefully a behaviour that solve a problem for the user.

Previous chapters and exercises are about defining some form of language that
can be used to solve a catagory of problems. Now are using that same muscle to
solve th problem of evaluating scheme expresssions and
running scheme programs.

The language being implemented in Lisp/Scheme will be a subset of the whole
language. There will a focus in implementing the concept of
`normal-order evaluation`. What ever that means.

`non-deterministic` computing is about generating all possible values that could
fit and then filtering to get the exact thing we need. Lazy evaluation will be
implemented.

### Lectures

A bit late now I have decided that I will stop watching the lectures. This
section is kept purely because I feel like it.

#### Lecture 7A Metacircular Evaluator

Deals with section 4.1

- [Lecture 7A: Metacircular Evaluator Part 1](https://www.youtube.com/watch?v=aAlR3cezPJg&list=PLE18841CABEA24090&index=13)

#### Lecture 7B 

Deals with section 4.2, did not watch yet

- [Lecture 7B: Metacircular Evaluator Part 2](https://www.youtube.com/watch?v=QVEOq5k6Xi0&list=PLE18841CABEA24090&index=14)
