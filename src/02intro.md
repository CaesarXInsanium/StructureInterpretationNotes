# Building Abstractions with Data

Chapter one focused on using elementary data and procedures to construct higher
order functions and can be used to express some higher level algorithms and processes
using simple functions.

However, everything that has been learned use only integers, float and ratios.
Even more complex behavior require the use to computational objects that have
different parts. `Compound Data` is the building of abstraction by combining data
objects. Compound procedures allow for elevated procedures and is the same with
compound data.

A simple example is in designing a system that allows for addition of rational numbers
by acting on compound data that have a component of denominator and numerator.
Designing procedures that kept track of individual primitive data would be a hassle
to maintain, so components must be glued together in order to be managed.

Compound data also allow for separation of the actions and procedures that act on
the data from the actual implementation and background of the compound data.
`Data Abstraction` is the idea that the true nature of how data ideas are represented
in the hardware is hidden from user in order for easier design and management.

Linear Combinations can be expressed as such.

```scheme
(define (linear-combination a b x y)
  (+ (* a x) (* b y)))
```

This implementation take is 4 numbers, However, we can define using data abstraction
a procedure that takes 4 anything and performs the appropriate procedures defined
for the data object on the data provided. The add and mul procedures determine the
data type in question and use correct procedure for addition and multiplication
respectably

```scheme
(define (linear-combination a b x y)
  (add (mul a x) (mul b y)))
```

Abstraction is a technique that can be used to manage complexity and this chapter
will focus on the use of data abstraction in order to separate different sections
for program.

Programming languages provide the glue for allowing this forms of abstractions.
From the way that data is stored and represented in computer to expression data
as nothing more than procedures on primitive data. `Closure` is the idea that a
language allows for the combining of both primitive data and compound data. `Symbolic`
expression is augmentation of language expressive power by arbitrary symbols as
opposed to numbers in which they are not defined and called until they are used
store some data.

`Generic Operations` allow for defining generic operations that can be applied
to different data types and a `data oriented programming` approach. This in technique,
data is the most important concept and data representations are defined separately
and combined `additively`

## Relevant Lectures

[Lecture 2B](https://www.youtube.com/watch?v=DrFkf-T-6Co&t=3722s)

[Lecture 3A](https://www.youtube.com/watch?v=PEwZL3H2oKg&list=PLE18841CABEA24090&index=5)

> on 28:38
