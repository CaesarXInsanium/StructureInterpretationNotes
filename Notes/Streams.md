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
