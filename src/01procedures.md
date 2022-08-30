# Abstractions with Procedures

A process is an idea of a set of events occurring under the direction of a program.

Lips was invited as a way to express computational thought in a manner using recursion
equations. Lisp is an interpreted language that is akin to a mathematical notation.
While it used to be slow it became able to translate directly to machine code in
order to get that boost in performance. It can now be used in production and as
an extension language. In lisp, data and function can be both be returned from
function calls.

## Elements of Programming

Programming languages can be used to express ideas about instructions that we want
a computer to execute as well as about processes and incorporate decision-making.
This is composed to 3 things

- primitive expressions: simplest entities and data
- combination: methods to build larger things from smaller ones
- abstractions: ways to reduce complexity by finding implementation details and
  organizing data and procedures

### Expressions

Expressions are evaluated and interpreter will return a value, usually itself.

Here is an example in lisp

```lisp
89 ;; will return 89 as an integers
(+ 9 10) ;; will evaluate result of adding 9 and 10 and then return
(+ 1 1 1 1) ;; unlimited number of operands
(+ (* 3 8) (- 10 4)) ;; nested expressions
```

Operators and operands are organized into prefix notation where the operator is
listed first and operands come afterwards. This hold true for function calls.
More complicated expressions are difficult for humans to understand, but an interpreter
can easily handle complexity.

Of course such expressions can also be rewritten in a way that would allow for
easier human understanding by aligning operators.

```lisp
(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      (6))
```

### Naming and Environment

In lisp things can be named with `define`. This allows easy reference with a value
without spelling it out. Assigned variable names are evaluated with their referred
value.

```lisp
(define size 2)
(+ size 2) ;; evaluates to
```

### Evaluating Combinations

In order to evaluate lisp expression

- evaluate sub-expressions
- apply procedure on data
- return value

Imagine a tree structure that with each expression, there is an operator and a
list of values. They can either be literals or expressions that themselves need
to be evaluated.

### Compound Procedures

Abstraction technique that allows for a set of instructions to be saved and used
multiple times in a program.

Here is procedure that square a number.

```lisp
(define (square x) (* x x))
;; here is example usage
(square 21)
(square (+ 6 7))
(square (square 5))
```

Define a procedure where we multiply a thing by itself. Here we use the `define`
keyword to name a procedure, specify that it takes only one parameter and then following
expression is that happens to data that is passed.

```lisp
(define (<name> <formal parameters>) (<body expression>))
```

### Substitution Model Procedure Application

Evaluation begins from the top down, in order to begin to evaluate the top most
expression, first the bottom expressions must be evaluated recursively. One way
is to replace every instance where we call a procedure with the body of said procedure.

One can simply think back to algebra to when we were solving systems of equations.
This is known as the substitution model.

Full implementation of interpreter and compiler will be done in this book.

Normal order evaluation is done by humans where full meaning of expression is expanded
to using only the most basic ideas and then evaluate. Interpreter use application
order evaluation where expressions are evaluated before applying.

### Conditional Expression and Predicates

Method for executing different based on results of tests if required for Turing
completeness and is basis for any for decision-making. Here are some examples.

```lisp
(define (abs x)
  (cond ((> x 0) x) ;; i thing cond keyword is akin to switch statement
        ((= x 0) 0)
        ((< x 0) (-x))))
(define (abs x)
  (cond ((< x 0) (-x))
        (else x)))
(define (abs x)
  (if (< x 0)
      (- x)
      x))
```

Here a condition is defined followed by a list of clauses or tests that can be performed.

We see the base form for a conditional statement in lisp.

```text
(if <predicate> <consequent> <alternative>)
```

### Example: Square Root using Newton's Method

```scheme
(define (square x)
    (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
    
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
                x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))
```

#### Exercises: Attractions

```lisp
10
12
8
3
6
a=3
b=a+1=4
19
false
4
17
16

(define (threesum x y z)
  (+ (square x) (square y) (square z)))

;; This is a function that in its conditional will return an operator that it will
;; then use in order to peform on the provided arguments
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))


;; Exercise 1.6
it does not call recursively on values and new values are not passed
It will condinue forever

;; Exercise 1.7
Because floats are discrete and finite representations of the infinite real number
plane. This means that evenuall with very large, small and accurate numbers cannot
be represented.

;; Exercise 1.8
(define (cube x)
  (* x x x))

(define (improve y x)
  (/ (+ (/ x (square y)) (* 2 y)) 3))

(define (good-enough? guess x)
    (< (abs (- (cube guess) x)) 0.00001))
    
(define (cbrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (cbrt-iter (improve guess x)
                x)))

(define (cbrt x)
  (cbrt-iter 1.0 x))

(write (cbrt 8) )
(newline)
(write (cbrt 27))
(newline)
(write (cbrt 125))
(newline)
(write (cbrt 1000))
(newline)
(write (cbrt 69))
(newline)
```

### Procedures as Black-Box Abstractions

Procedure Abstraction should allow for encapsulation of lower level procedure and
joining them together in order to make larger procedures. Naming arguments generally
does not matter to user of a procedure. All that matters is that the function is
correct and return need value.

Lisp also allows defining private procedures inside other procedures in order
to be able to maintain a specific procedure that is important to working of public
facing function.

```lisp
(define (public x)
  (define (private y)
    (write y)
    (newline))
  (private x)
```

## Procedures and Processes They Generate
