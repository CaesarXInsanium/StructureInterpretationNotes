## 3.5 Streams

Streams are used to model state, a scheme data structure. Thinking of it as a
continuous function that does not change, it produces different values based on
the input of time. Different functions can be used to represent *infinite* streams,
sources of endless data.

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

With that what can be written is a procedure that determines if a guess if good
enough and then stop generating answers. Another strategy is to use the infinite
summation strategy.

There is a method to generate better guesses faster using Euler's Sequence Accelerator.
This transformation can easily be described in scheme code. Several procedures
are required for this, but it can increase memory requirements for an increase
in processing speed.

#### Infinite Streams of Pairs

There is a way to generate using promises and streams specific elements in
a 2D array, specific indexes. The main challenge is to write a stream definition
that would allow for a stable lazy generation of pairs, where items in one column
are not all generated at one when one element is requested from the stream.

#### Streams as Signals

Streams can be used to represent signal values in accordance to time. With this
idea integrals can be defined in terms of streams.

### 3.5.4 Streams and Delayed Evaluation

Feedback loops are possible to emulate using the `integral` procedure, which can
then be used in signal processing. It all comes back to the individual implementation
of the `delay` procedure. Generally it is a macro or syntax extension in GNU Guile.

Using streams to simulate designated increments in time.

#### Normal Order Evaluation

Creating separate classes of procedures requires the creation of a separate
class of higher order procedures, procedures that return other procedures. This
section describes some problems that the introduction of lazy evaluation introduces
into a programming language. One obvious issue is types. Lisp is a dynamically typed
but some typed programming languages cannot express higher order procedures due
to the ambiguity of types. Mutability and delayed evaluation do not mix well in
programming languages.

### 3.5.5 Modularity of Functional Programs and Modularity of Objects

Modularity is easier with assignment in scheme. Mixing the assignment and delayed
evaluation in a controlled manner allows for some cool stuff I guess. It is possible
to containerize the assignment and delay into separate sections to get the best
both worlds.

#### A Functional Programming View of Time

Streams are used to model that changing state of an object, with defined time
intervals. Now the state of object is decoupled from environment or some shit.
Each time a procedure is called it generates a new stream representing the possible
changes in a state. There is a way to represent state without explicit assignment
or side effects, Using streams. It is possible to model state with computational
objects.

Functional programming languages are developed in an attempt to solve this issue.
Time problems are not completely gone though.

In Summary, I have no idea what I just read.
