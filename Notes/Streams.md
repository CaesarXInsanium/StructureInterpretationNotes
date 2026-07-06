## 3.5 Streams

Streams are used to model state, a scheme data structure. Thinking of it as a
continuous function that does not change, it produces different values based on
the input of time. Different functions can be used to represent *infinite* streams,
sources of endless data.

> I have seen in the future, that Streams are a form of lazy evaluation. They
> are basically a series of forms that delay execution until they are needed. It
> can also allow for recursion to turn into iteration.

#### Relevant Lectures

I forgot to watch these lectures so maybe that is why I haven't done any of the
relevant exercises. I had too small a brain.

- [Lecture 6A: Streams Part 1](https://www.youtube.com/watch?v=JkGKLILLy0I&list=PLE18841CABEA24090&index=11)
- [Lecture 6B: Stream Part 2](https://www.youtube.com/watch?v=qp05AtXbOP0&list=PLE18841CABEA24090&index=12)

### 3.5.1 Streams as Delayed Lists

Streams cannot be implemented as straight lists, since the computational space
and time required will provide no benefits. As such an example is given to show
why this is the case. The example deals with finding the sum of prime numbers in
a given interval.

Code is at `code/Streams.scm`

The goal of a stream is to behave as if it were a complete list, yet the values
are lazy evaluated. They are generated only as needed and nothing more. The related
functions are as described

```scheme
(stream-car (cons-stream x y)) == x
(stream-cdr (cons-stream x y)) == y
```

They really just are the advanced version of the normal list operations. They allow
for the usage other list actions. The core of stream is the function `delay` and
`force`

```scheme
(delay <exp>) ;; => promise object
(force <promise>) 
```

> delay is actually a compiler primitive/intrinsic. At least in the scheme
> implementation that SICP uses. It is essentially creating a thunk. An
> anonymous function that will no be evaluated until `force` is called on it.


In GNU Guile `delay` is a macro, that returns a promise. `force` is a procedure.
It also has the predicate `promise?`. Check out SRFI-46.

#### The Stream Implementation in Action

Find a way to pretend like we have the entire list. I have no idea where the author
is going with this. `stream-filter` and `stream-enumerate-interval` where both
shown implementations in terms of `cons-stream` and using `cons-car` `cons-cdr`.

#### Implementing `delay` and `force`

`force` can be easily implemented if we think of the expression inside passed
to the `delay` form as a thunk, a procedure in of itself of no arguments.
The thunk must be memoized, once the procedure has been computed, the result is
saved and if the procedure is called again it simply returns saved result.
`delay` can be implemented in terms of `memo-proc` and `force`.

### 3.5.2 Infinite Streams

Given the definition of streams, it is possible to use streams in order to represent
practically infinite lists. For example a stream representing integers. In essence
we have a well. Each `stream-cdr` is a promise to evaluate and expression at a
later time.

And infinite prime generator is created by writing a stream that generates another
stream with filter which generates another stream with another filter and so on
to filter out numbers divisible by 2, then 3, then 4 and so on until infinity.

#### Defining Streams Implicitly

Here is some hilarious code. It produces and infinite stream of ones. It takes
advantage of the fact that evaluation of the second argument is delayed until it
it needed. So the values ones is treated as a symbol.

```scheme
(define ones (cons-stream 1 ones))
```

We can define summations in this way, where each element depends on the value
of the previous element. It is very abstract, I don't get half of it. An infinite
list of integers can be created in terms of the infinite list of ones. A Fibonacci
number stream uses the previous two elements.

### 3.5.3 Exploiting the Stream Paradigm

Using streams is useful tool when dealing with a language that has assignment
and the concept of change. A time series is a list of values.

#### Formulating Iterations as Stream Processes

Iteration can be improved with streams, the square root guessing procedure can be
modeled with a stream to generate better and better guesses. This is done with
a stream generator `sqrt-stream`. Approximating *pi* up to a predetermined amount
with a stream. 

```scheme
(define (sqrt-stream x)
  (define guesses 
    (stream-cons 1.0 (stream-map (lambda (guess) (sqrt-improve guess x))
                                 guesses)))
  guesses)
```

With that what can be written is a procedure that determines if a guess if good
enough and then stop generating answers. Another strategy is to use the infinite
summation strategy.

There is a method to generate better guesses faster using Euler's Sequence Accelerator.
This transformation can easily be described in scheme code. Several procedures
are required for this, but it can increase memory requirements for an increase
in processing speed.

```scheme
(define (make-tableu transform s)
  (stream-cons s
               (make-tableu transform
                            (transform s))))
```

#### Infinite Streams of Pairs

There is a way to generate using promises and streams specific elements in
a 2D array, specific indexes. The main challenge is to write a stream definition
that would allow for a stable lazy generation of pairs, where items in one column
are not all generated at one when one element is requested from the stream.

Creating a table of streams. No longer linear, it can now be two, three, or n
dimensional.

#### Streams as Signals

Streams can be used to represent signal values in accordance to time. With this
idea integrals can be defined in terms of streams.

```scheme
(define (integral integrand initial-value dt)
  (define int (stream-cons initial-value
                           (add-streams (scale-stream integrand dt)
                                        int)))
  int)
```


### 3.5.4 Streams and Delayed Evaluation

Feedback loops are possible to emulate using the `integral` procedure, which can
then be used in signal processing. It all comes back to the individual implementation
of the `delay` procedure. Generally it is a macro or syntax extension in GNU Guile.

Using streams to simulate designated increments in time.

```scheme
(define int 
  (stream-cons initial-value
               (add-streams (scale-stream integrand dt)
                            int)))

(define (solve f y0 dt)
  (define y (integral dy d0 dt))
  (define dy (stream-map f y))
  y)

(define (integral delayed-integrand initial-value dt)
  (define int
    (stream-cons initial-value
                 (let [(integrand (force delayed-integrand))]
                   (add-streams (scale-stream integrand dt)
                                int)))))
```

New definition of the `solve` procedure.

```scheme
(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)
```

#### Normal Order Evaluation

Creating separate classes of procedures requires the creation of a separate
class of higher order procedures, procedures that return other procedures. This
section describes some problems that the introduction of lazy evaluation introduces
into a programming language. One obvious issue is types. Lisp is a dynamically typed
but some typed programming languages cannot express higher order procedures due
to the ambiguity of types. Mutability and delayed evaluation do not mix well in
programming languages.

Imbedding the primitive of `delay` is a headache since, now we are implicitly
dealing with state. We have no idea wether or not a particular `delay` section,
down in deeper levels of the stream, is in a position in which we have code that
returns data that we need, or is it just a *promise* object.

TBH I have no idea what the author is talking about

### 3.5.5 Modularity of Functional Programs and Modularity of Objects

Modularity is easier with assignment in scheme. Mixing the assignment and delayed
evaluation in a controlled manner allows for some cool stuff I guess. It is possible
to containerize the assignment and delay into separate sections to get the best
both worlds.

State can be hidden by simply hiding it behind a stream. Instead of mutating a
variable, we simply say that are pulling from an infinite stream of values, and
performing calculations based on that. Either making a new stream or taking the
necessary number of values from the stream.

Which is the theme in the code provided. Where a stream is created to generate
random numbers. Which is fed to a Monte-Carlo procedure that uses the random
number stream to conduct the required experiments.

#### A Functional Programming View of Time

Streams are used to model that changing state of an object, with defined time
intervals. Now the state of object is decoupled from environment or some shit.
Each time a procedure is called it generates a new stream representing the possible
changes in a state. There is a way to represent state without explicit assignment
or side effects, Using streams. It is possible to model state with computational
objects.

```scheme
(define (make-simplified-withdraw balance)
  (lambda (amount)
    (set! balance (- balance amount))
    balance))
```

So what happens is that we have a stream, it represents the current state of the
account. In order to represent time, can say that we are pulling elements from
the stream. The `delay` special form and `memo-proc` procedure allow for the
language itself to hold the state, and the user defined program can work with
a purely functional mental model.

```scheme
(define (stream-withdraw balance amount-stream)
  (stream-cons balance (stream-withdraw (- balance (stream-car amount-stream))
                                        (stream-cdr amount-stream))))
```

Even the interactions a hypothetical bank user would have with the bank account,
amounts to merely a stream of itself, to a stream that takes a long time to
compute mostly because we are mostly waiting for the user to actually do
something.

SICP talks about the research going to the development of functional languages,
where they take the concepts of no state, first class functions and immutability
to create a new method of expressing pure mathematical truths.

The research is spurred on by the problem of synchronization. Where different
streams would differ one what the value of a certain thing actually be. This is
race conditions and the quirks of multiprocessing.

As such, another problem becomes that maybe one stream that represents a sensor
that only rarely activates and another that is constantly reading values. We
cannot have a system in which both take turns updating a particular values, we we
would be stuck waiting for the slower one. 

## Self Study Section

From what I can garner, we have to think about the stream as less code and
procedures but rather as mathematical truths. The big picture with the section
on streams is that we are translating mathematical expression of truth into
code in a way that the computer can then figure out on its own. The `exp-series`
is a stream that can be used to calculate the values of $e^x$ to some arbitrary
precision(with caveats on floating point precision) with some arbitrary value
for $x$.

What I now lack is the ability to actually translate this mathematical ideas
into code.

#### Skipped exercises

I want to have fun doing stuff, not getting depressed for not being able to
figure stuff out.

- 60,61,62,63,

64 just iterates until the difference between and last and second to last
numbers are below the tolerance. I don't really know if it allows for
calculating to arbitrary precision.

65 asks to implement the series, and the evaluate it for a set number of
iterations or to reach a tolerance. It depends on scheme implementation.

66 I don't get it

67 I goal is to go into 2 dimensions. I don't get it.

Honestly I don't get anything here. I am ready the answers and they all blow
over my head.

73 Is a small project in of itself. **NO**. It is simple as heck. Frick.
