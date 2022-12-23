# Abstractions with Procedures

[Lecture 1A](https://www.youtube.com/watch?v=eJeMOEiHv8c)

[Lecture 1B](https://www.youtube.com/watch?v=-J_xL4IGhJA&list=PLE18841CABEA24090&index=1)

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

```scheme
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

```scheme
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

```scheme
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

```scheme
(define (square x) (* x x))
;; here is example usage
(square 21)
(square (+ 6 7))
(square (square 5))
```

Define a procedure where we multiply a thing by itself. Here we use the `define`
keyword to name a procedure, specify that it takes only one parameter and then following
expression is that happens to data that is passed.

```scheme
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

```scheme
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

### Procedures as Black-Box Abstractions

Procedure Abstraction should allow for encapsulation of lower level procedure and
joining them together in order to make larger procedures. Naming arguments generally
does not matter to user of a procedure. All that matters is that the function is
correct and return need value.

Lisp also allows defining private procedures inside other procedures in order
to be able to maintain a specific procedure that is important to working of public
facing function.

```scheme
(define (public x)
  (define (private y)
    (write y)
    (newline))
  (private x)
```

## Procedures and Processes They Generate

In order to make the best use of procedure it is not enough to know how they work
one must also know tactics and strategies for using them.
In order to get the bast idea on how to design and build a system one must have
a good idea on what we want the end result to be. It makes it necessary to
plan out much of what we want to do. Procedures are local evolutions of computational
processes and as such can be built on top of each other in order to create the
bigger result. They are some "shapes" that procedure definitions can follow.

Lisp allows reasoning about and build procedures as if they were mathematical expressions.

### Linear Recursion

The definition of factorial is as follows

$$
n! = n *(n - 1)*(n -2) ...3*2*1
$$

From this it is logical to assume that *n* factorial is equal to *n* times *n* minus
one factorial.

$$
n! = n * (n-1)!
$$

> Here is a more recursive method

```scheme
(define (factorial n)
  (if (= n 1)
    1
    (* n (factorial (- n -1)))
  )
)
```

> Here is another method of defining the factorial function.

```scheme
(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
      product
      (iter (* counter product)
            (+ counter 1))))
  (iter 1 1))
```

Expanding expression allows one to see the true "shape" of a procedure as it evaluates.
Some have a diamond shape as the expression expands to the simplest term and then
contracts as each term is evaluated.

The expansion evaluation of a procedure is known as `deferred operations` in which
an is like as the program is being run this is the part where each function is
being initial called. And then after that the evaluation of the value is the actual
recursion.

With the iterative function definition each time the recursive function is called
it is being immediate evaluated before it can be called again. This is `iterative`
processes. In this method the state can be tracked with certain variables keeping
track of when the process should end if at all. For is a for loop in most languages.

Iterative procedures allow for easy description of the entire state of the process
at any given point. Recursive not so much since the compiler/interpreter hide away
much of the inner working up to the point in which it is difficult to resume from
any position.

Recursive procedures are strictly those that call themselves within their own definition.
Iterative procedures hold their state in outside variables.

Most languages define iterative procedures using for/while loop unlike Scheme and
any other lisp dialect.

### Tree Recursion

*Tree recursion* occurs when a procedure calls itself more than once inside
its own definition. For example look at this procedure for getting Fibonacci numbers.

```scheme
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

This example is not efficient because work is repeated. Computing the Fibonacci
of any sufficiently big number will result with entire branches of work being
recalculate in different branches in the execution of the procedure. The time
complexity of this function is exponential. Space complexity grow linearly.

Here is iterative version.

```scheme
(define (fib_i n)
  (fib-iter 1 0 n))

(define (fib-iter a b counter)
  (if (= counter 0)
    b
    (fib-iter (+ a b) a (- ounter 1))))
```

Here the time complexity is linear.

Tree recursion and iteration are tools and should be used when it is the best tool
in the current situation.

### Orders of Growth

Order of growth simply describe who quickly the time it takes for a procedure to
finish executing given data size *n* as *n* reaches infinity. *N* can be used to
describe the size of a number itself, the number of bit required to describe a
piece of data, the number of elements in a data structure.

Such method of describing a procedure grows in computation time is inaccurate, but
it is useful in describing how efficient an algorithm really is.

### Exponentiation

One way to calculate the exponent of a value is to use the recursive definition
of exponentiation.

$$
b^n = b * b^{n-1},
b^0 = 1
$$

Here it is in scheme.

```scheme
(define (expt b n)
  (if (= n 0)
    1
    (* b ( expt b (- n 1)))))
```

Here it is in Clojure

```clojure
(defn expt [b n]
  (if (= n 0)
    1
    (* b ( expt b (- n 1)))))
```

It is possible to make a faster procedure by simply using a different algorithm.
It can be done using the idea that certain value can be reached faster. For example
take following expression.

$$
b^4 = b^2 * b^2
$$

Using this \\(b^8\\) can be calculated much faster. Here is an implementation.

```scheme
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
```

Given from this implementation, it can be easy to see that the time complexity goes
to logarithmic because each exponent jump is bigger the deeper the recursion goes.

### Greatest Common Divisor

Greatest Common Divisor or GCD is defined as the largest integers that divides
integers A and B. Meaning that there are integers x and y such that
\\( x *GCD =A \\)
and \\( y* GCD =  B \\)

Finding the GCD is simple since one can take the recursive definition.

$$
GCD(a,b) = GCD(b,r)
$$

Use it to define this function in scheme.

```scheme
(define (gdc a b) (if (= b 0)
                    a
                    (gcd (remainder a b))))
```

We continuously divide a from b recursively until the final GCD is found.

This algorithm is iterative in nature as each recursion is a tail recursion and grows
in logarithmic time.

### Testing for Primality

There are two main methods for testing if integer n is a prime number or not.

One strategy is to find if it has any factors.

```scheme
;;Naive Method

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? a b) (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n ) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (prime? n) (= n (smallest-divisor n)))
```

What this implementation does it check all numbers less than square root of n if
they are the prime numbers. The logic goes if none of those work then the number
*n* is prime.

The second big strategy is based on Fermat's Little theorem which states basically
the idea that is *n* is a prime number and *a* is a positive integer less than
*n* then *a* raised to the *n* power is congruent to *a* modulo *n*.

> Two numbers are congruent if when divide by the same number have the same remainder.

```scheme
;; Fermats Theorem applied

(define (expmod base exp m)
  (cond ((= exp 0)
         1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else
          (remainder (* base (expmod base (- exp 1)m))m))))
```

This procedure grows logarithmic in accordance to size of input. Using it we can
implement the Fermat test.

```scheme
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1))))
)
```

The final form. Will take a number and number of attempts to see if it is prime.

```scheme
(define (fast-prime? n times)
  (cond ((= times 0) 1)
        ((fermat-test n) (fast-prime? n (- times 1))) (else 0)
```

However, it has been proven that even if the procedure says that a number passes
the test then it does not mean that it is prime. There is also the fact that some
non primes that fool the Fermat test for why modulo congruent with a lot of numbers.
This algorithm is an example of a `Probabilistic Algorithm` in which there is a
chance of error that the algorithm yields the incorrect result.

## Formulating Abstractions with Higher Order Procedures

The ability to write procedures and function allows for the ability to create program
that can work on higher and higher levels of abstraction and reuse instructions and
operations without repeat the definitions.

Procedures that only work on numbers can be limiting. `Higher Order` procedures
are those that accept functions as arguments and can return functions as results.

### Procedures as Argument

Here we have three procedures.

```scheme
;; Sums Integers from A to B
(define (sum-integers a b)
        (if (> a b)
            0
            (+ a (sum-integers (+ a 1) b))))

;; Computers Sum of Cubes of Integers
(define (sum-cubes a b)
    (if (> a b)
        0
        (+ (cube a) (sum-cubes (+ a 1) b))))

;; Computes Series of multiplied cubes
;;; 1 / (1 * 3) + 1 / (5 * 7) +1 / (9 * 11)
(define (pi-sum a b)
    (if (> a b)
        0
        (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))
```

These are similar procedures, that have the same template and could be automatically
generated. Sigma notation is used in order to express how express a method to add
the results of a function given a range of integer values.

$$
\sum_{n=a}^{b}(f(n) = f(a)+...+f(b))
$

The realization that the pattern being emulated is in fact a mathematical summation
allows for easy redefinition using the scheme language.

```scheme
(define (sum term a next b)
        (if (> a b)
            0
            (+ (term a)
                (sum term (next a) next b))))

;; term is a function that determines the selection of items being summed
;; next is a function that determines which is the next items after the previus one
    ;; for function term
```

Using some other helper functions it is possible to redefine all the functions

```scheme
(define (sum-cubes a b)
        (sum cube a inc b))
        
```
