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
in order to allow programmer to work on the their program instead of their implementation.

Abstraction allows for using a high level concept without regards to implementation
and allows and a change in implementation should not result in change in behaviour
for the use to deal with.
