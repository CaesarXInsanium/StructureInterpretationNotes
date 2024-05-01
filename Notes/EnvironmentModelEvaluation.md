## 3.2 Environment Model of Evaluation

> [Relevant Lecture 5A](https://youtu.be/a2Qt9uxhNSM?si=bnAnEcuD6LOevxlz)

Substitution method for finding out what happens to data no longer works with
imperative programming. Environment model of execution is stored in which variables
are mainly slots where values can be store, and environments are where the variables
are kept track of.

Environment
: Sequence of frames

Frames
: table with bindings "variable names", any number including none. Contains pointer
  to enclosing environment, except global *frame*

The value of a variable is the fist one given in the chain of frames within the
context of execution, the first found. Frames in lower down the stack can shadow
the values of higher frames.

Expressions require frames to derive meaning with respect to. From now on the code
will assume the execution is performed inside a global frame, with primitive
procedures defined.

### 3.2.1 The Rules of Evaluation

Given an expression, in order to derive its value, first the values of sub-expressions
must be found in order to plug and play. Procedures themselves can be implemented
as a pair with a pointer to environment and relevant code to evaluate procedure.

`define` keyword creates definition in local frame and sticking it to the table.
Applying a procedure involves creating a new frame and binding relevant values
in that frame. `lambda` is created with respect to the environment in which it was
created. `set!` set changes the value of the first instance found of a variable.
If it does not exist then an error is raised.

First hint of the full purpose of *Structure and Interpretation of Computer Programs*.
It is to explain how to implement a scheme interpreter.

### 3.2.2 Applying Simple Procedures

Page 241 is where an example is given about how environments and frames business
works. Each time a procedure is called, a new frame is create with initial bindings
set to values of passed arguments. Each time a new symbol is encountered, it is
looked up in the current frame. If not found it goes back up until a relevant binding
is found and the value is substituted. It is in this way that different functions
can all have a variable named *x*.

Chapter 5 is where compilation is explored. Chapter 4 is where an interpreter
is created.

### 3.2.3 Frames as the Repository of Local State

Here in this section the Environment model of execution is used to explore the
`make-withdraw` procedure in an earlier section. It is kinda funny in a way.
The trick to add a sub-environment in which the variable `balance` can be stored
in which it can be modified.

### 3.2.4 Internal Definitions

Callback to **1.1.8** in which procedures can have internal definitions, other
procedures and variables defined within the scope of a procedure's frame.

```scheme
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
      guess
      (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
```

Each frame can have its own definitions. Is the point. Local bindings do not conflict
with global bindings, no name clashes.
