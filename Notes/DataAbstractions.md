# Chapter 2

Relevant lectures

-   [Lecture 2B](https://www.youtube.com/watch?v=DrFkf-T-6Co&t=3722s)
-   [Lecture
    3A](https://www.youtube.com/watch?v=PEwZL3H2oKg&list=PLE18841CABEA24090&index=5)
-   [Lecture
    3B](https://www.youtube.com/watch?v=bV87UzKMRtE&list=PLE18841CABEA24090&index=6&t=17s)
-   [Lecture 4A](https://www.youtube.com/watch?v=_fXQ1SwKjDg)
-   [Lecture 4B](https://www.youtube.com/watch?v=OscT4N2qq7o&t=18s)

I might be lost on where I am supposed to be at with the lectures. Never mind
the lecture is separate, or a prefix to 2.3 Its seems I was correct

Current location 4B start

## 2.1 Introduction of Data Abstraction

Chapter one focused on using elementary data and procedures to construct higher
order functions and can be used to express some higher level algorithms and
processes using simple functions.

However, everything that has been learned use only integers, float and ratios.
Even more complex behavior require the use to computational objects that have
different parts. `Compound Data`{.verbatim} is the building of abstraction by
combining data objects. Compound procedures allow for elevated procedures and is
the same with compound data.

A simple example is in designing a system that allows for addition of rational
numbers by acting on compound data that have a component of denominator and
numerator. Designing procedures that kept track of individual primitive data
would be a hassle to maintain, so components must be glued together in order to
be managed.

Compound data also allow for separation of the actions and procedures that act
on the data from the actual implementation and background of the compound data.
`Data Abstraction`{.verbatim} is the idea that the true nature of how data ideas
are represented in the hardware is hidden from user in order for easier design
and management.

Linear Combinations can be expressed as such.

``` scheme
(define (linear-combination a b x y)
  (+ (* a x) (* b y)))
```

This implementation take is 4 numbers, However, we can define using data
abstraction a procedure that takes 4 anything and performs the appropriate
procedures defined for the data object on the data provided. The `add` and `mul`
procedures determine the data type in question and use correct procedure for
addition and multiplication respectably

``` scheme
(define (linear-combination a b x y)
  (add (mul a x) (mul b y)))
```

Abstraction is a technique that can be used to manage complexity and this
chapter will focus on the use of data abstraction in order to separate different
sections for program.

Programming languages provide the glue for allowing this forms of abstractions.
From the way that data is stored and represented in computer to expression data
as nothing more than procedures on primitive data. `Closure`{.verbatim} is the
idea that a language allows for the combining of both primitive data and
compound data. `Symbolic`{.verbatim} expression is augmentation of language
expressive power by arbitrary symbols as opposed to numbers in which they are
not defined and called until they are used store some data.

`Generic Operations`{.verbatim} allow for defining generic operations that can
be applied to different data types and a `data oriented programming`{.verbatim}
approach. This in technique, data is the most important concept and data
representations are defined separately and combined `additively`{.verbatim}

## 2.2 Hierarchical Data and Closure Property

> Relevant Lecture section start at 3B 8:00, current time 28:38

We have learned that the `cons`{.verbatim} function can be used to build simple
data representations and abstractions of which individual parts can be accessed
with `car`{.verbatim} and `cdr`{.verbatim}. Numbers and other pairs can be
combined in this method.

The closure property of cons refers to its ability to represent abstract data
and concepts. In accordance to specification. Hierarchical structures are made
up of smaller parts coming together in order to make bigger parts.

### 2.2.1 Representing Sequences

The logical extension is that `cons`{.verbatim} can be used to build arbitrary
long sequences of which, lists can be built. A collection of different items
that end in a nil item.

``` scheme
(define l (cons 1 (cons 2 (cons 3 (cons 3 nil)))))
```

Scheme defines this as a `list`{.verbatim} can can be defined with a function
and a series of arguments. Merely syntactic sugar for the above code segment.

``` scheme
(define 1-to-4 (list 1 2 3 4))
```

Individual elements can be accessed individually by using `car`{.verbatim} and
`cdr`{.verbatim}.

``` scheme
(car (cdr (cdr 1-to-4)))
;; => 3
```

Certain list operations have been defined by Scheme such as
`list-ref`{.verbatim} which inputs a list and an index.

``` scheme
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
```

Finding the length of a list is easy as well since we only need to recurse down
a list until we find a null element, all the while adding one to a counter every
time we recurse.

``` scheme
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define (length-iter items)
  (define (iter a count)
    (if (null? a)
        count
        (iter (cdr a) (+ 1 count))))
  (iter items 0))
```

It is also possible to define another procedure that takes in a list and
generates a new list with a new element added.

``` scheme
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))
```

#### Mapping Over Lists

One useful function is to take a list and apply a transformation on each item
and generate a new list. The scheme `map`{.verbatim} function is for this
purpose. This is a higher order procedure.

``` scheme
(define nil '())
(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

;; Scheme Standard defines a map function that takes in a procedure of n parameters
;; and with n lists of same length
(map (lambda (x y z)
       (+ x y z))
     (list 1 2 3)
     (list 4 5 6)
     (list 7 8 9))
```

Other functions can then be defined in terms of this map function. This function
would take a list of numbers and return a new list with all the numbers
multiplied against another value.

```scheme
(define (scale-list items factor) (map (lambda (x) (\* factor x))
items))
```

The key concept here are the layers of abstraction that hides away the
complexities in order to allow programmer to work on their program instead of
their implementation.

Abstraction allows for using a high level concept without regards to
implementation and allows and a change in implementation should not result in
change in behavior for the use to deal with.

### 2.2.2 Hierarchical Structures

The `cons`{.verbatim} function allows for the holding of more than just numbers,
other cons boxes can hold more cons boxes. This allows for a rudimentary tree to
be defined and used. Cons boxes can hold indefinite levels of cons boxes.
Restricted only by the amount of memory a computer holds.

``` scheme
(cons (cons 1 2)
      (cons 3 4))
```

Tree structures lend themselves easily to recursion since operations on entire
trees can be simplified to operations on branches and then to leaves. Deciding
weather or not an object is a pair can be made easy with the scheme function
`pair?`{.verbatim}

``` scheme
(pair? (cons 1 2)) ; => #t
```

A simple procedure for recursively counting the number of leaves on a tree is
shown.

``` scheme
(define (count-leaves x)
  (cond ((null? x) o)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
```

Mapping Over Trees

The `map`{.verbatim} procedure is a powerful concept that can be used in order
to define a way to create a new list using the elements of an existing list and
applying a procedure to build it. A procedure to apply the same idea to trees
should not be difficult to imagine.

``` scheme
;; Here is test procedure to apply an operation across every object in a tree
(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))
```

Then we can build a procedure that abstract away from of the details and leaves
a simple interface.

``` scheme
(define (tree-map proc tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (proc tree))
        (else (cons (tree-map proc (car tree))
                    (tree-map proc (cdr tree))))))
```

### 2.2.3 Sequences as Conditional Interfaces

Conventional Interfaces are used in order to design data in a way to solve a
particular problem without regards to underlying implementations. This allows
for internal representation to change and as long as behavior does not change
this allows for user to continue using the data with no worry.

For example given the two programs.

``` scheme
(define (even-fibs n)
  (define (next k)
    (if (> k n)
        nil
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))
```

These follow a similar pattern in that follow similar steps

-   travel through the different leaves
-   selects them based on criteria
-   accumulates the results

In there are steps of enumeration, mapping and accumulation. However, the
different is the order in which steps are done.

Sequence Operations

One way to think about this is laid out big the book in which each number or
leave that is traversed is a signal, and they must be processed, filtered and
measured in order to be useful.

Defining signals as simply lists allow us to simply `map`{.verbatim} over them
in order to process them.

``` scheme
(map square (list 1 2 3 4 5))
```

Filtering can be easily implemented for lists.

``` scheme
(define nums (list 1 2 3 4 5 6))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

;; usage like so
(filter odd? nums) ;; => (1 3 5)
```

Accumulation

``` scheme
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(accumulate + 0 nums);; => 21
```

Final thing need for implementation of signal processing is the enumeration for
numbers and trees.

``` scheme
(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
```

The same procedures can now be implemented in terms of these functions. One may
notice that each procedure is a sequence of operations. Designing programs in a
modular and sequential way allows for easy modularity in by allowing a library
of components that can then be stringed together in order to solve a problem.

``` scheme
;; Gives of the squares of Fibonacci numbers
(define (list-of-fib-square n)
  (accumulate cons nil (map square
                            (map fib (enumerate-interval 0 n)))))

;; Squares the odd elements and multiplies them together
(define (product-of-squares-of-odd-elements sequence)
  (accumulate * 1 (map square
                       (filter odd? sequence))))

;; Example on how joining these operations can be used in order to solve real
;; world problems. This reminds me of SQL selector operations
(define (salary-of-higher-paid-programmer records)
  (accumulate max 0 (map salary
                         (filter programmer? record))))
```

Moral of the story here, if one sees a low of repeating code the goal is to
abstract what is possible into a modular procedure that can be called with
arguments being the differentiation part of the thing.

Nested Mappings

It is possible to use the mapping and accumulated procedures in order to device
a way of implementing nested for loops. For each value of *i* and then for each
value of *j*. The method for applying this is to generate a list of the relevant
indexes, then mapping over and filtering relevant values and finally generate a
sequence of the answers that we are looking for.

In the example problem, we are trying to find all the unique pairs of *i* and
*j* such that their sum is a prime number.

``` scheme
;; Generate pairs of indices
(define (gen-pairs n)
  (accumulate append
              nil
              (map (lambda (i)
                     (map (lambda (j)
                            (list i j))
                          (enumerate-interval 1 (- i 1))))
                   (enumerate-interval 1 n))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

;; Filter Function
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

;; Generate list with pairs and their sum
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

;; Final Generate the actual list, final answer
(define (prime-sum-pairs n)
  (map make-pair-sum (filter prime-sum?
                             (flatmap (lambda (i)
                                        (map (lambda (j) (list i j))
                                             (enumerate-interval 1 (- i 1))))
                                      (enumerate-interval 1 n)))))
```

Using nested mapping allow for easy generation of permutations and combinations.
Generating permutations can be achieved with this simple procedure.

``` scheme
(define (remove item sequence)
  (filter (lambda (x) (not (= x item))) sequence))

(define (permutations s)
  (if (null? s)
      (list nil)
      (flatmap (lambda (x)
                 (map (lambda (p)
                        (cons x p))
                      (permutations (remove x s))))
               s)))

(permutations (list 1 2 3))
```

This allows use to more easily work with nested mappings so that the code the
deals with the nested mapping is separate from the code the deals with
generating the nested data structures that the nested maps work with.

#### 2.2.4 Example: A Picture Language

We are introduced to a hypothetical picture language that makes use of the
concept of a painter. If a painter is given a rectangle, it will attempt to draw
an image on it given a set definitions of a rectangle and treats it as a canvas.
Painters can be stacked on top of each other in a form of closure. It can use
the lisp programming language in order to satisfy this closure property.

The closure property refers to ability of express the idea that complex things
can be built using simple things. It is possible to generate very complex
patterns by the different procedures that act on the painter.

Higher order operations can be achieved with procedure generators. The power
lies in lisp\'s ability to create entirely new languages.

I am able to use the picture language and test it out using Dr-Racket and the
SCIP package.

The lecture talks about the closure property. From I can follow I only need to
implement some very basic primitives in order to implement the full stack of the
picture language.

Frames are a definition of rectangles/canvas that are painter. A painter is an
object that when painted draws a picture.

``` scheme
;; Allows for creation of a new procedure that represents a linear transformation
(define (frame-coord-map frame)
  (lambda (v)
    (add-vec (origin-frame frame)
             (add-vec (scale-vec (vecx v)
                                 (edge1-frame frame))
                      (scale-vec (vecy v)
                                 (edge2-frame frame))))))

;; takes list of segments and create a painter that draws line in those represented segments
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each (lambda (segment)
                (draw-line ((frame-coord-map frame) (start-segment segment))
                           ((frame-coord-map frame) (end-segment segment))))
              segment-list)))
```

Using these functions it is possible to define new ways of creating painter
objects in terms of other painter objects.

``` scheme
;; This will create a new painter that will flip the image upside down
(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

;; self explanatory
(define (shrink-to-upper-right painter)
  (transform-painter painter
                     (make-vect 0.5 0.5)
                     (make-vect 1.0 0.5)
                     (make-vect 0.5 1.0)))

(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (squash-invards painter)
  (transform-painter painter
                     (make-vect 0.0 0.0)
                     (make-vect 0.65 0.35)
                     (make-vect 0.35 0.65)))
```

And now the all important beside function.

``` scheme
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left (transform-painter painter1
                                         (make-vect 0.0 0.0)
                                         split-point
                                         (make-vect 0.0 1.0)))
          (paint-right (transform-painter painter2
                                          split-point
                                          (make-vect 1.0 0.0)
                                          (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))
```

All of this satisfies the closure property. The closure property seems to be an
ability for lower level primitives

This idea of closure property allows for a `stratified`{.verbatim} design in
which one level solely depends on the lower levels. All computer science is
based off of layers of abstraction. Lisp allows for language levels to be
designed and use based one simple primitives the are provides on lower levels.

In theory a change in design or implementation should not have a significant
effect on the upper layers of the language. There are many examples of this, but
the picture language is the example given by the book.

Also the last exercise is skipped.

## 2.3 Symbolic Data

Scheme allows for the use of arbitrary symbols in as a means to work with data.

#### 2.3.1 Quotation

Allows for expressing literal symbols inside of an expression and not the
values the symbols themselves are supposed to represent. This can be
accomplished with the quotation operator.

``` scheme
(define symbol 'define)
(define list-of-symbols '(a b c d))
;; quote function is possible. This allows for a keeping of standards
(define symbol2 (quote 'display))
(define other-list-of-symbols (quote (1 2 3 4)))
```

Allows for a differentiation between expressions to be evaluated and data
representation that can be manipulated and explored. The `eq?`{.verbatim}
function allows for testing for the equality of symbols.

``` scheme
(define s 'a)
(eq? 'a s)
```

An implementation of `memq`{.verbatim} is possible which checks a list for the
presence of a specific symbol inside of it. If it is not contained then the
function returns false. If it is contained then the function returns a sub-list
which the item as first entry.

``` scheme
(define (memq item x)
  (cond ((null? x) #f)
        ((eq? item (car x) )x)
        (else (memq item (cdr x)))))

(memq 'a (list  '0 'banana 'a 'b 'c))
```

#### 2.3.2 Example: Symbolic Differentiation

> Relevant Lecture section continues at 3B 29:24

One main goals of symbol manipulation using a computer language was the quest
for algebraic manipulation by a computer. To be more specific the question to
find a way to find the derivative of a function and symbolic differentiation.
This started the development of systems used by physicists and mathematicians.
The book will now begin to describe the thought process in creating a system for
symbol manipulation.

1.  Differentiation with Abstract Data

The SICP implementation defines a set of differential properties that are
kept in mind when beginning to implement a way to find derivative
expressions.

$-- no space after open $, no space before $

- $\frac{dc}{dx} = 0$ for any value
- $\frac{dx}{dx} = 1$ identity
- $\frac{d(u + v)}{dx} = \frac{du}{dv} + \frac{dv}{dx}$
- $\frac{d(u  v)}{dx} = u  \frac{dv}{dx} + v  \frac{du}{dx}$

The third and fourth rules are recursive in nature, it allows for
splitting a problem into smaller, more solvable chunks. Further
decomposing will produce very simple problems that are easily solvable.

The most important technique to use is wishful thinking. The first we
define a representation for algebraic expressions. Then a way to compose
the representations into more complex expressions. Think of this as a
way to parse expressions.

``` scheme
;; Wishful thinking to start off with
(variable? e)
(same-variable? v1 v2)
(sum? e)
(addend e)
(augend e)
(make-sum a1 a2)
(product? e)
(multiplier e)
(multiplicand e)
(make-product m1 m2)
```

All of these functions must be defined. If we assume that all of these
functions are defined then we can create a function.

```{.scheme tangle="code/diffentiation.scm" mkdirp="yes"}
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp-var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum (make-product (multiplier exp)
                                 (deriv (multiplicand exp) var))
                   (make-product (deriv (multiplier exp) var)
                                 (multiplicand exp))))
        (else (error "Unknown expression type -- DERIV"))))
```

    Now all that we need to do is define all of these relevant functions and
    values now we have a pretty good thing going on. We also need to define the
    representation for the algebraic expressions.

2. Representing Algebraic Expressions

    Scheme\'s symbols are a straight forward way to define the expressions.
    $ ax + b $ becomes `(+ (* a x) b)`{.verbatim} very easily. And so they can
    be defined using merely scheme primitives.

```scheme
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2) (list '+ a1 a2))
(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (addend x) (cadr x))
(define (augend x) (caddr x))

(define (make-product m1 m2) (list '* m1 m2))
(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))
```

Once we have define all of the functions that we wish to exist, we can how
we want them to behave and how to organize them in a way that makes sense.
We can start defining tests for them.

Here is one such example of a test.

``` scheme
;; derivative of 3x is 1
(deriv '(+ x 3) 'x)
;; (+ 1 0)
(deriv '(* x y) 'x)
;; (+ (* x 0) (* 1 y))
(deriv '(* (x y) (+ x 3)) 'x)
;; (+ (* (* x y) (+ 1 0)
;;    (* (+ (* x 0) (* 1 y))
;;       (+ x 3)))
```

The tests here are technically correct however they need to be simplified in
order to be accepted as proper answers. In order to properly make amends for
this issue changing that function `deriv`{.verbatim} is not necessary since
we can instead change the other functions, the lower levels to account for
the technicality.

```scheme
;; required function
(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
```

This change allows for a better following of arithmetic and algebraic rules
that make sense in a way and allows for simplification of expressions.

```scheme
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
```

These functions allow easier simplification.

#### 2.3.3 Example: Representing Sets

The representation for rational numbers and algebraic expressions might of have
been straight forward but it would not be for things such as sets. For a set is
a collection of unique elements. The book will begin with defining possible
operations and selectors in sets. A set representation in scheme will require
the implementation of some ideas. It the primitive ideas are implemented then
more complex ideas based around set theory can be very easily be built with
those concepts.

Here are some basic procedures for interacting with sets.

```scheme
(define true #t)
(define false #f)

(define (element-of-set? x set)
  (cond ((null? set) false)             ; elements cannot be part of empty sets
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

;; create new set with added element
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

;; elements that exist in both sets
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

;; Answer to 2.59, add elements in both sets into one
(define (union-set a b)
  (cond ((or (null? a) (null? b)) '())
        ((element-of-set? (car a) b)
         (union-set (cdr a) b))
        (else (cons (car a)
                    (union-set (cdr a) b)))))
```

Efficiency if a require thing to think about since number of steps to do
anything useful would in theory hamper what sort of things can be done in a
reasonable amount of time. Here is where asymptotic notation rears its ugly head
once again since set could be anything.

1.  Sets as Ordered Lists

One way to improve the efficiency of the set representation is to maintain
it in sorted order. This requires a function that can be used to compare any
two elements. Such a procedure will need to have a specification in order to
deal with any define universe of elements. The book will focus on numbers. I
have seen this code before it is simple binary search.

```scheme
(define false #f)
(define true #t)

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))
```

Blah blah blah the time savings are roughly one half of the expected time
spent with the previous implementation. The time saving are most apparent
with the procedure `intersection-set`{.verbatim} as as soon as an elements
if found to not exist in a set, it stop searching for it and begins with the
next element.

```scheme
(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2)
               (cond ((= x1 x2)
                      (cons x1
                            (intersection-set (cdr set1)
                                              (cdr set2))))
                     ((< x1 x2)
                      (intersection-set (cdr set1) set2))
                     ((< x2 x1)
                      (intersection-set set1 (cdr set2)))))))))
```

The book claims the increase in efficiency is linear. I will now do the
61st exercise.

2.  Sets as Binary Trees

    Just as the title suggests the book now represent sets as a binary trees
    with each node having a number and a two branches, one side has values less
    than node and other side has values greater than node. This would be a
    binary heap or a binary search tree. Nope its a tree. With a tree
    representation, it is possible to cut the search size in half with each
    comparison, if the key is present in tree at all.

    The nodes themselves are lists of three items, the item, and the two
    sub-trees. With this idea it is possible to immediately begin representing
    trees.

    ``` {.scheme tangle="code/binary_tree.scm"}
    (define (entry tree) (car tree))
    (define (left-branch tree) (cadr tree))
    (define (right-branch tree) (caddr tree))

    (define (make-tree entry left right)
      (list entry left right))
    ```

    With this it is already possible to reimplement the
    `element-of-set`{.verbatim} procedure.

    ``` {.scheme tangle="code/binary_tree.scm"}
    (define false #f)
    (define true #t)
    (define (element-of-set? x set)
      (cond ((null? set) false)
            ((= x (entry set)) true)
            ((< (entry set)) (element-of-set? x (left-branch set)))
            ((> x (entry set)) (element-of-set? x (right-branch set)))))
    ```

    The procedures work. These are the building blocks in order to create fun
    things such as `adjoin-set`{.verbatim}

    ``` {.scheme tangle="code/binary_tree.scm"}
    (define (adjoin-set x set)
      (cond ((null? set) (make-tree x '() '()))
            ((= x (entry set)) set)
            ((< x (entry set)) (make-tree (entry set)
                                          (adjoin-set x (left-branch set))
                                          (right-branch set)))
            ((> x (entry set)) (make-tree (entry set)
                                          (left-branch set)
                                          (adjoin-set x (right-branch set))))))
    ```

    The tree can be searched in logarithmic time but that is under the
    assumption that the tree itself is balanced, meaning that one side has
    roughly the same number of elements as the other. It could lead to time
    complexity that is on par with a simple sorted linked list, which it is. The
    solution is to create a method for keeping the tree balanced in some form.
    Here we start getting into the exercises.

3.  Sets and Information Retrieval

    Look at different methods to implement the idea of a set can show how much
    of an impact that the choice of data representation strategy can have an
    impact on the performance on the program.

    When creating a system for managing and searching large volumes of data it
    is helpful to define a method by which a *key* can be used to search a
    value. Examples exists but the most obvious one is a dictionary. A lookup
    function is required to make use of the key with the dataset.

    This implementation assumes that the `set-of-records`{.verbatim} is
    implemented as an unordered list. Actual performance system will have more
    thought put into their system with a strategy such as a binary search tree.

    ``` {.scheme tangle="code/information_retrieval.scm"}
    (define key nil)
    (define (lookup given-key set-of-records)
      (cond ((null? set-of-records) #f)
            ((equal? given-key (key (car set-of-records)))
             (car set-of-records))
            (else (lookup given-key (cdr set-of-records)))))
    ```

#### 2.3.4 Example: Huffman Encoding Trees

Section focuses on a possible useful use of the sets and binary representation
using a Huffman encoding tree. The main idea with this is the fact in order to
represent *n* unique bits of data it requires $\log{2}{n}$ bits in order to
represent it. 8 unique data points requires 3 bits to represent them all,
minimum.

These are *fixed length* codes, where each set number of bits represent one data
point. *Variable length* codes can required a different number of bits to
represent them. This is done to save space and time. Knowing when one data point
ends and another begins can be solved by having unique sequences that only occur
on certain conditions.

Huffman codes use this idea in combination with binary trees, whose leaves are
the different symbols that are being dealt with. The branches are based on the
frequency of each symbol. We sort the frequency of these symbols and then, go
right and left adding a zero or a one based on going right or left in tree.
Going down the tree is down by comparing each bit until a symbol is reached.

1.  Generating Huffman Trees

    Generating a Huffman tree requires the Huffman algorithm for encoding the
    maximum amount of information in the fewest number of bits. In generating a
    tree, the goal is to set the furthest leaves to represent the least common
    symbols. The algorithm requires a set of nodes, each representing a symbol
    and a weight denoting its frequency.

    The tree is generated by comparing each node, one after the other merging
    until the optimum combination is found.

2.  Representing Huffman Trees

    The scheme representation is very rudimentary since it is a least containing
    a scheme symbol.

    ``` {.scheme tangle="code/huffman.scm"}
    (define (make-leaf symbol weight)
      (list 'leaf symbol weight))

    (define (leaf? object)
      (eq? (car object) 'leaf))

    (define (symbol-leaf x) (cadr x))

    (define (weight-leaf x) (caddr x))
    ```

    This is not very complicated.

    ``` {.scheme tangle="code/huffman.scm"}
    (define (make-code-tree left right)
      (list left
            right
            (append (symbols left) (symbols right))
            (+ (weight left) (weight right))))

    (define (left-branch tree) (car tree))
    (define (right-branch tree) (cadr tree))

    (define  (symbols tree)
      (if (leaf? tree)
          (list (symbol-leaf tree))
          (caddr tree)))

    (define (weight tree)
      (if (leaf? tree)
          (weight-leaf tree)
          (cadddr tree)))
    ```

    Apparently these are examples of *generic procedures* that work on a
    multitude of different types of data.

3.  The Decoding Procedure

    I am just going to copy the decoding procedure that is listed in the thing.

    ``` {.scheme tangle="code/huffman.scm"}
    (define (decode bits tree)
      (define (decode-1 bits current-branch)
        (if (null? bits)
            '()
            (let ((next-branch (choose-branch (car bits) current-branch)))
              (if (leaf? next-branch)
                  (cons (symbol-leaf next-branch)
                        (decode-1 (cdr bits) tree))
                  (decode-1 (cdr bits) next-branch)))))
      (decode-1 bits tree))

    (define (choose-branch  bit branch)
      (cond ((= bit 0) (left-branch branch))
            ((= bit 1) (right-branch branch))
            (else (error "bad bit -- CHOSE BRANCH" bit))))
    ```

    I don\'t like the function raises an exception as opposed to returning a
    result or option type. But I guess that is because the Rust programming
    language exists.

4.  Sets of Weighted Elements

    Given the first paragraph it seems that the algorithm for generating the
    tree representation of the set requires some sort of sorting algorithm. We
    can copy an answer from exercise 2.61 or simply copy the implementation that
    is given.

    ``` {.scheme tangle="code/huffman.scm"}
    (define (adjoin-set x set)

      (cond ((null? set) (list x))
            ((< (weight x) (weight (car set)))  (cons x set))
            (else (cons (car set)
                        (adjoin-set x (cdr set))))))

    (define (make-leaf-set pairs)
      (if (null? pairs)
          '()
          (let ((pair (car pairs)))
            (adjoin-set (make-leaf (car pair)
                                   (cadr pair))
                        (make-leaf-set (cdr pairs))))))
    ```

## 2.4 Multiple Representations for Abstract Data

> Relevant lecture: [Lecture 4B: Generic
Operators](https://www.youtube.com/watch?v=OscT4N2qq7o&list=PLE18841CABEA24090&t=18)

This section deals with the more power to the abstract data representation. The
main idea was separating the representation of the data way from the usage and
API that is present. The lecture talked about allowing for the system to have
multiple different representations of the same data.

The example giving of multiple different representations for the same data is
seen with a representation of complex numbers.

``` scheme
;; standard rectangular representation
(define (make-complex real imagi) (cons real imagi))

;; polar representation
(define (make-complex magnitude angle) (cons magnitude angle))
```

Scheme would allow use to write *generic procedures* which is simply procedures
designed in such a way that allow them to operate on any form of data. Abstract
implementation of generics that are so common in modern programming. Interfaces,
traits and contracts.

This scheme implementation would use `type tags`{.verbatim}.

Data Oriented Programming
:   implementation strategy that uses a global table to lookup items and decide
    what to do based on what is found.

Type Tags
:   tagged unions. Data objects with type information embedded.

The goal in being able to create multiple packages with separate implementations
of an abstract data type and have generic procedures able to act on all of
them.

### 2.4.1 Representations of for Complex Numbers

Here in this section is when the book begins to show the example of complex
numbers.

Adding complex numbers is easier with rectangular representations and
multiplying complex numbers is easier with polar presentation. Same is
subtracting and dividing respectively. There are two functions that deal with
conversion.

``` {.scheme tangle="code/complex.scm"}
(make-from-real-imag (real-part z) (imag-part z))
(make-from-mag-ang (magnitude z) (angle z))
```

Assuming these functions exist we can then implement some more functions.

``` {.scheme tangle="code/complex.scm"}
(define (add-complex z1 z2)
  ((make-from-real-imag (+ (real-part z1) (real-part z2))
                        (+ (imag-part z1) (imag-part z2)))))

(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))

;; multiplication and division is easier with polar representation

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))


(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))
```

This design of the API requires that necessity to define some other functions.

These are that the functions look like when dealing with a rectangular
representation.

``` {.scheme tangle="code/complex.scm"}
;; Can only deal with the Rectangular representation
(define (real-part) (car z))
(define (imag-part z) (cdr z))

(define (magnitude z) (sqrt (+ (square (real-part z)) (square (imag-part z)))))

(define (angle z) (atan (imag-part z) (real-part z)))

(define (make-from-real-imag x y) (cons x y))

;; conversion from polar
(define (make-from-mag-ang r a) (cons (* r (cos z)) (* (sin a))))
```

Here are what the functions look like to deal with a polar representation.

``` {.scheme tangle="code/complex.scm"}
(define (real-part z) (* (magnitude z) (cos (angle z))))

(define (imag-part z) (* (magnitude z) (sin (angle z))))

(define (magnitude z) (car z))

(define (angle z) (cdr z))

(define (make-from-real-img x y)
  (cons (sqrt (+ (Square x) (square y)))
        (atan y x)))

 (define (make-from-mag-ang r a) (cons r a))
```

### 2.4.2 Tagged Data

That view seen in SICP is the idea that implementations should do the minimum
amount of work required in order to get something represented and worked out.
Selectors and tagged data allows for the deferral of actual implementation to
more and more select packages and procedures.

The example given by the book assumes that each piece of data is actual tagged
with a symbol.

``` scheme
(cons <symbol>
      <datum>)
```

This would allow for a way to differentiate between the two implementations.
These require two procedures.

``` {.scheme tangle="code/arithmetic.scm"}
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad Tagged Datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (error "Bad Tagged datum -- CONTENTS" datum)))

;; These allow for easy type checking at runtime.
(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))

(define (polar? z)
  (eq? (type-tag z) 'polar))
```

From here on out it is possible for the two representations of the complex
number type to exist simultaneously. How we are still not done since each
individual function still has to check the type of each item in order to do any
sort of work.

\> code is on page 177, I\'m not typing that in.

Each \'generic\' operation that can be done requires individual checks for the
relevant types. Adding any new implementation requires editing each individual
procedure.

### 2.4.3 Data-Directed Programming and Additivity

Dispatching on Type
:   checking on type of datum and calling the appropriate procedure is the very
    essence of data oriented programming

Extendability requires that each implementation requires as little work as
possible. Another weakness in given implementation is that requirement to give
each procedure an unique name in order to reduce change of name collision.

The solution to the complex number problem is given with two abstract
procedures.

``` scheme
(put <op> <type> <item>)
(get <op> <type>)
```

We pretend that there are two procedures, `put`{.verbatim} and `get`{.verbatim}.
`put`{.verbatim} places an item, a procedure on a table of procedures. Each
column deals with a data type. Each row is an unique generic operation. The
entries are unique procedures. Here is the new code.

``` {.scheme tangle="code/complex-packages.scm"}
(define (install-rectangular-package)
  (define (real-part z) (car z))
  (put 'real-part '(rectangular) real-part)
  ...)


(define (install-polar-package)
  (define (real-part z) (* (magnitude z) (cos (angle z))))
  (put 'real-part '(polar) real-part)
  ...)
```

The book contains a lot more code but this is enough to get the idea across.
Assuming that there exists functions known as `put`{.verbatim} and
`get`{.verbatim} we can allow for the easy table directed installation and usage
of multiple representation of the same data and their respective generic
operators. Usage can be done with following code.

``` {.scheme tangle="code/arithmetic.scm"}
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No Method for these types -- APPLY-GENERIC"
           (list op type-tag))))))

;; This function allows for the real usage of API

(define (real-part z) (apply-generic 'real-part z))

;; ALl of this rests on the existance of function

(define (get op datum) <exp>)
```

Constructors can be defined in terms of the procedures available in the table.

``` scheme
(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))
```

It is at this point when we can start with the exercises. Best of luck to future
Caesar.

#### Message Passing

Alternative implementation is to have table where types are actually procedures
that take in a datum and a procedure to operate on and then the dispatching is
done by the datums. I don\'t get it.

``` scheme
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else (error "Unknown op -- MAKE_FROM-REAL-IMAG" op))))
  dispatch)

;; new apply-generic
(define (apply-generic op arg) (arg op))
```

This is the essence of message passing.

## 2.5 Systems with Generic Operations

This section deals with extending the idea of data directed programming in order
to implement the full arithmetic package and allow for a full generic interface
for all of the different data types. It will show all of the code and then
exercises will ask to extend the ideas. The goal is to create a general
arithmetic system.

### 2.5.1 Generic Arithmetic Operations

First thing that must be defined is the generic procedures themselves.

``` {.scheme tangle="code/arithmetic.scm"}
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
```

Ordinary numbers (integers) are the first things that are defined.

``` {.scheme tangle="code/arithmetic.scm"}
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number  scheme-number)
       (lambda (x y) (tag (/ x y))))
  'done)
;; constructor must be available
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))
```

Rational numbers can be added in the same way that ordinary numbers are added.

``` {.scheme tangle="code/arithmetic.scm"}
(define (install-rational-package)
  (define (number x) (car x))
  (define (denom x) (cdr x))
  (define (`make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (denom x) (denom y)))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  (define (tag x) (attach-tag 'rational x))
  'done)
```

The complex number package can also be added. For some reason.

``` {.scheme tangle="code/arithmetic.scm"}
(define (install-complex-package)
  ;; private functions
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  (define (add-complex z1 z2) (make-from-real-imag (+ (real-part z1) (real-part z2)) (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))

  (define (tag z) (attach-tag 'complex z))
  ;; external interface
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
```

All of this requires the definition of external constructors that actual just
call the real constructors.

``` {.scheme tangle="code/arithmetic.scm"}
(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))
```

The book talks about having two levels of abstraction from arithmetic package
down to the actual complex number implementation

### 2.5.2 Combining Data of Different Types

Here in this section it is beginning to talk about adding the ability to support
operations between types. That way different types can be operated on together.

Book details this naive implementation.

``` scheme
(define (add-complex-to-schemenum z x)
  (make-from-real-imag (+ (real-part z) x)
                       (imag-part z)))
(put 'add (complex scheme-number)
     (lambda (z x) (tag (add-complex-to-schemenum z x))))
```

The question becomes whose responsibility is it to define code to allow for
conversion between different types.

#### Coercion

The solution it to change the problem to one where. This is where *coercion*
comes into play. The book introduces the idea of simply viewing an object of one
type as an object of another.

``` scheme
(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))
(put-coercion 'scheme-number 'complex scheme-number->complex)
```

Now we have a new procedure to implement that allows for this magic to occur.
`put-coercion`{.verbatim} and `get-coercion`{.verbatim} would allow the casting
between types. There are some holes available. It is not possible to treat a
complex number as an integer. Unless we ignore the imaginary part, losing
information in the process.

``` scheme
(define (apply-generic op . args)
  (let ((type-tags (map (type-tag args)))
        (let ((proc (get op type-tags)))
          (if proc
            (apply proc (map contents args))
            (if (= (lenght args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                        (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                        (else (error "No Method for these types"
                                     (list op type-tags))))))
              (error "No Method for these types"
                     (list op type-tags))))))))
```

The only thing holding this back is a way to get a sort of implicit tower or
chain of conversion definition in order define a path to say convert a natural
number down to integer, rational, down to complex. And to then have the system
automatically convert an integer to a complex number.

#### Hierarchies of Types

The logical next step is to define a *hierarchy* of types. When each level
defines a type which is represents a subset of the type over it. Like integers
are a subset of rational numbers. It is here where things are getting
interesting. It seems that we are getting to a point where we can implement
Scheme\'s numerical tower. The entire book is leading to building a scheme
compiler.

What is then mentioned is the idea of designing a path of coercions for the
language to take in order to find a path. From one type to another.

What is also suggested is adding the ability to lower down from the hierarchy of
types. If a object can be transformed from a rational number to integer then it
will.

#### Inadequacies of Hierarchies

The system described in the book is not good for relationships of types
representable with trees and graphs. Or even instances where an object can have
multiple *parent* types. Object oriented programming is an attempt to solve this
problem but it sucks hard.

### 2.5.3 Example: Symbolic Algebra

Book describes the reasoning behind using algebraic expressions in order to show
hierarchical types and recursive structures and trees that can be defined in terms
of themselves. The lecture actually ended with this idea as a sort of thinking
point for the students. The book shows this equation.

$$
x^2 \sin(y^2 + 1) + x \cos(2y) + \cos(y^3 - 2y^2)
$$

Book talks about how it is going to show a partial implementation of the algebraic
system with focus on polynomial arithmetic.

#### Arithmetic on Polynomials

 Indeterminate
: Variables of a polynomial

Book will focus on polynomials of a single variable, *univariate polynomial*.
Polynomials will be a particular syntactic form, with no other considerations.
Some restrictions must be applied.

Some more code is defined, creating a  polynomial package. I will no longer copy
it over in this document.

> page 205 [code](../code/symbolic_algebra.scm)

What was missing from the given code is ways to simply the expressions and add terms
that have same power into one term with added coefficient. `add-terms` is defined

From the `add-term` function there is a call to `add` which allows for more power
in recursive nature of structures that it allows. Coercion works by simply raising
the lower polynomial to sufficient rank with coefficient zero.

I should really read the code provided to try and understand it.

#### Representing Term Lists

Term lists must have unique terms as well as be ordered from most significant to
least. Ordered sets are required of the representation of terms. There is also
*dense* $x^5 + 2x^4 +3x^2 - 2x - 5$ versus 
*sparse* $x^100 + 2x^2 + 1$ term lists. Representing one would be less efficient
for representing the other. So both types are going to be represented in the implementation.

#### Hierarchies of Types in Symbolic Algebra

Everything goes to show the power of generic operations and hash maps. Algebraic
expressions can be used to show limitations of a tower hierarchy of types since
sometimes relationships and Hierarchies cannot be expressed linearly. The important
thing is the idea of structures and modularity principles.

#### Extended Exercise: Rational Functions

Rational Function
: fractions whose numerator and denominator are polynomials.

The book gives this example.

$$
\frac{x+2}{x^3 - 1}
$$

The goal would be to support `add`, `sub`, `mul` and all of the other basic
arithmetic operations as shown with other data types.
