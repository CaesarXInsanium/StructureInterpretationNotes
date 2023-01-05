# 2.1 Introduction to Data Abstraction

Procedures whose purpose was to create higher level and more complex procedures
were learned in chapter 1. Data abstraction can be achieved using similar methods.
Abstraction allow for a separation between the usage of the data structures and
the actual implementation.

The code that is written that work with data structures should assume that the implementation
of does not matter and in fact should ignore it altogether. `Selectors` and `contructors`
should be used that only takes into consideration the abstract idea of the data structure.

## 2.1.1 Arithmetic Operations for Rational Numbers

The simplest example is the need to design scheme code to work with the abstract
concept of rational numbers. The lecture gives a strategy known as wishful thinking
in which instead of starting with implementation we instead imagine that the implementation
is already finished and ready to be used. The question is, how is this imaginary
data structure as actually used? For that we define some scheme functions.

```scheme
(make-rat 3 4) ;; returns an abstract data structure that represents a rational number
(numer a) ;; returns numrator of rational number
(denom a) ;; return denominator.
```

Using these procedures we can already imagine ways of adding, subtracting, multiplying

```scheme
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denon y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))
```

### Pairs

Scheme has a set of different function that allows for constructing of abstract
data structures and joining of different pieces of data. The one being used is
*pair*. This works with function `cons` which take two arguments and returns
a container that contains both of those things.

```scheme
(define x (cons 1 2))
```

This function returns a pair, a joining of two things into one thing. And if we
can have two things in one thing we can have as many things are we want.

Individual components can be extracted using `car` and `cdr`.

```scheme
(display (car x))
(display (cdr x))
```

### Representing Rational Numbers

Using the `cons` function for creating pairs and related `car` and `cdr` it is
possible to implement the rational number abstract data structure.

```scheme
(define (make-rat n d) (cons n d))
(define (numer a) (car a))
(define (denom a) (cdr a))
```

When working with rational numbers it is always good to reduce them whenever possible.
So we define a procedure for reducing rational numbers to the lowest terms. Only
works since the implementations of the operators of rational numbers all make use
of the make-rat procedure.

```scheme
(define (make-rat n d)
  (let ((g (gcd n d)))
       (cons (/ n g) (/ d g))))
```

## 2.1.2 Abstraction Barriers

There are some barriers to understanding and comprehension of the above methods.
Higher levels of abstraction hide away implementation details in order to reduce
complexity. Leading to user to only think about their own problem domain. Some details
have to be decided at either construction time of evaluation time. For example
when we need to find the greatest common divisor, do we reduce it at construction
or evaluate it whenever we need to access to perform some other action.

These questions have be answered by the one implementing an abstract data interface.
