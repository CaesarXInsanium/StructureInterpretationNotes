# Hierarchical Data and Closure Property

> Relevant Lecture section start at 3A 8:00, current time 28:38

We have learned that the `cons` function can be used to build simple data representations
and abstractions of which individual parts can be accessed with `car` and `cdr`.
Numbers and other pairs can be combined in this method.

The closure property of cons refers to its ability to represent abstract data and
concepts. In accordance to specification. Hierarchical structures are made up of
smaller parts coming together in order to make bigger parts.

## 2.2.1 Representing Sequences

The logical extension is that `cons` can be used to build arbitrary long sequences
of which, lists can be built. A collection of different items that end in a nil
item.

```scheme
(define l (cons 1 (cons 2 (cons 3 (cons 3 nil)))))
```

Scheme defines this as a `list` can can be defined with a function and a series of
arguments. Merely syntactic sugar for the above code segment.

```scheme
(define 1-to-4 (list 1 2 3 4))
```

Individual elements can be accessed individually by using `car` and `cdr`.

```scheme
(car (cdr (cdr 1-to-4)))
;; => 3
```

Certain list operations have been defined by Scheme such as `list-ref` which inputs
a list and an index.

```scheme
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
```

Finding the length of a list is easy as well since we only need to recurse down
a list until we find a null element, all the while adding one to a counter every
time we recurse.

```scheme
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

It is also possible to define another procedure that takes in a list and generates
a new list with a new element added.

```scheme
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))
```

### Mapping Over Lists

One useful function is to take a list and apply a transformation on each item and
generate a new list. The scheme `map` function is for this purpose. This is a higher
order procedure.

```scheme
(define nil '())
(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

;; Scheme Standard defines a map function that takes in a procedure of n parameters
;; and with n lists of same length
(map (lambda (x y z) (+ x y z)) (list 1 2 3) (list 4 5 6) (list 7 8 9))
```

Other functions can then be defined in terms of this map function.

```scheme
(define (scale-list items factor)
  (map (lambda (x) (* factor x)) items))
```

The key concept here are the layers of abstraction that hides away the complexities
in order to allow programmer to work on their program instead of their implementation.

Abstraction allows for using a high level concept without regards to implementation
and allows and a change in implementation should not result in change in behavior
for the use to deal with.

### 2.2.2 Hierarchical Structures

The `cons` function allows for the holding of more than just numbers, other cons
boxes can hold more cons boxes. This allows for a rudimentary tree to be defined
and used. Cons boxes can hold indefinite levels of cons boxes.

```scheme
(cons (cons 1 2)
      (cons 3 4))
```

Tree structures lend themselves easily to recursion since operations on entire trees
can be simplified to operations on branches and then to leaves. Deciding weather
or not an object is a pair can be made easy with the scheme function `pair?`

```scheme
(pair? (cons 1 2)) => #t
```

A simple procedure for recursively counting the number of leaves on a tree is shown.

```scheme
(define (count-leaves x)
  (cond ((null? x) o)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
```

#### Mapping Over Trees

The `map` procedure is a powerful concept that can be used in order to define
a way to create a new list using the elements of an existing list and applying
a procedure to build it. A procedure to apply the same idea to trees should not
be difficult to imagine.

```scheme
;; Here is test procedure to apply an operation accrross every object in a tree
(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))
```

Then we can build a procedure that abstract away from of the details and leaves
a simple interface.

```scheme
(define (tree-map proc tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (proc tree))
        (else (cons (tree-map proc (car tree))
                    (tree-map proc (cdr tree))))))
```

### 2.2.3 Sequences as Conditional Interfaces

Conventional Interfaces are used in order to design data in a way to solve a partifular
problem without regards to underlying implementations. This allows for internal
representation to change and as long as behavior does not change this allows for
user to continue using the data with no worry.

For example given the two programs.

```scheme
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

- travel through the different leaves
- selects them based on criteria
- accumulates the results

In there are steps of enumeration, mapping and accumulation. However, the different
is the order in which steps are done.

#### Sequence Operations

One way to think about this is laid out big the book in which each number or
leave that is traversed is a signal, and they must be processed, filtered and measured
in order to be useful.

Defining signals as simply lists allow us to simply `map` over them in order to
process them.

```scheme
(map square (list 1 2 3 4 5))
```

Filtering can be easily implemented for lists.

```scheme
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

```scheme
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(accumulate + 0 nums);; => 21
```

Final thing need for implementation of signal processing is the enumeration for
numbers and trees.

```scheme
(define (enumurate-interval low high)
  (if (> low high)
    nil
    (cons low (enumurate-interval (+ low 1) high))))

(define (enumurate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumurate-tree (car tree))
                      (enumurate-tree (cdr tree))))))
```

The same procedures can now be implemented in terms of these functions.
One may notice that each procedure is a sequence of operations. Designing
programs in a modular and sequential way allows for easy modularity in by allowing
a library of components that can then be stringed together in order to solve a
problem.

```scheme
;; Gives of the squares of fibanacchi numbers
(define (list-of-fib-square n)
  (accumulate cons nil (map square
                            (map fib (enumurate-interval 0 n)))))

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

Moral of the story here, if one sees a low of repeating code the goal is to abstract
what is possible into a modular procedure that can be called with arguments
being the differentiation part of the thing.

#### Nested Mappings

It is possible to use the mapping and accumulated procedures in order to device
a way of implementing nested for loops. For each value of _i_ and then for each
value of _j_. The method for applying this is to generate a list of the relevant
indexes, then mapping over and filtering relevant values and finally generate
a sequence of the answers that we are looking for.

In the example problem, we are trying to find all the unique pairs of _i_ and _j_
such that their sum is a prime number.

```scheme
;; Generate pairs of indices
(define (gen-pairs n)
  (accumulate append
              nil
              (map (lambda (i)
                     (map (lambda (j)
                            (list i j))
                          (enumurate-interval 1 (- i 1))))
                   (enumurate-interval 1 n))))

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
                                             (enumurate-interval 1 (- i 1))))
                                      (enumurate-interval 1 n)))))
```

Using nested mapping allow for easy generation of permutations and combinations.
Generating permutations can be achieved with this simple procedure.

```scheme
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

This allows use to more easily work with nested mappings so that the code
the deals with the nested mapping is separate from the code the deals with
generating the nested data structures that the nested maps work with.

#### Example: A Picture Language
