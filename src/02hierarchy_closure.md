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
