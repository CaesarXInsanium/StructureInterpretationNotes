## 3.1 Assignment and Local State

> [Relevant Lecture 5A](https://youtu.be/a2Qt9uxhNSM?si=bnAnEcuD6LOevxlz)

Sometimes previous values are not important, the 'enviroment model' of computation
allows not needed the history of value to make use of it now. Computational objects
must be decoupled from time and an assignment operation is required, to change
value associated with a variable.

### 3.1.1 Local State Variables

Here is where the example Bank Account program is used to show the idea of state
and setting the values of a variable, associated with a symbol. 

[Code](code/AssignmentAndLocalState.scm)

We see a function that returns a different value each time that it is called.
Because it has a side effect.

`begin` form is introduced, only value of last expression is returned.

Encapsulation needs to happen in order to protect values of one section of a program
from being modified in another section. A new model of computation if required
in order to make sense of the intricacies of `set!`.

### 3.1.2 The Benefits of Introducing Assignment

The example given is random number generators, objects that can return a different
set of numbers each time that it is invoked or called. Then the code for a function
`rand` that invokes a `rand-update` function that updates its own internal state
after each call.

`rand-update` has to be called indirectly in order to not have to remember to keep
track of the inner state variable. *Monte Carlo* simulation is implemented using
this idea. The code given is about a procedure that can compute the value of *pi*
using the fun property of random numbers.

> Code is in `code/Rand.scm`

Encapsulating a random number state hides it away from the idea of Monte Carlo
and keeps them seperate, the user calling `monte-carlo` does not have to worry about

### 3.1.3 The Costs of Introducing Assignment

*Functional Programming* is first introduced, the first 2 chapter are all about
this functional style. The substitution model analysis no longer works for analyzing
programs that are written using the `set!` function.

#### Sameness and Change

Two things can be equivalent without being the same objects and `set!` introduces
the notion that two things are not `eq?` or `eqv?` meaning that they are functionally
not the same thing. They cannot be substitued for the other.

It is here that the scheme programming language runs into the same problem that
other languages such as `C` experience with pointers and multiple references to
the same object and touching memory that itsn't yours.

#### Pitfalls of Imperative Programming

Imperative Programming
: Makes extensive use of Assignment

Differs from functional programs where no side affects are possible. Changing the
values of variables in different orders would change the result of a programing,
yielding an incorrect result.
