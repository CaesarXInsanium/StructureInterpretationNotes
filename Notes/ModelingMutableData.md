## 3.3 Modeling with Mutable Data

[Lecture 5B: Computational Objects"](https://youtu.be/yedzRWhi-9E?si=W2IwzrfHB3uoFwaE)

Mutators
: operation that change a value in a data structure.

Mutable Data Objects
: data structures for which mutating operations are defined.

### 3.3.1 Mutable List Structure

New operations required for defining mutating procedures for lists. `set-car` and
`set-cdr` procedures are required to define new mutating procedures for lists.
Any implementation of scheme would require a garbage collector to get clean memory
of unused data. Scheme also requires that the procedure `cons` is defined in terms
of new primitive procedure `get-new-pair`.

```scheme
(define (cons x y)
  (let ((new (get-new-pair)))
    (set-car! new x)
    (set-cdr! new y)
    new))
```

#### Sharing and Identity

There must be a way to tell if two symbols are point to the same value in memory.
If they are bound to the same object. `eq?` allows for determining if two objects
point to same memory. Which does not make sense since Scheme is a dynamic programming
language. Symbols themselves are inherently shared. Great care must be made when
procedure that alter pointer and pairs, the price that must be paid are bugs and
incorrectness.

#### Representing Queues

One use case of mutable `cons` pairs is the creation of queues ans tables.

Queue
: Sequence of items, inserted on one end and queried from another. It is an abstract
  data structure that support only PUSH, PEEK, and POP operations. It is first in
  first out data structure.

Operations to define include constructor, some predicates, data structure operations
and others.

Code is at `code/Queues.scm`

### 3.3.3 Representing Tables

It is at this point that the book finally decides to implement the `put` and the
`get` procedures detailed in the section of the algebraic data types.

Headed List
: Contains special backbone list, whose cars contains represent entries in the table
  It also contains a header in the scheme implementation.

Code is at `code/Table.scm`

Requires header to keep track of start of list. Two dimensional tables are as simple
as having to levels of table to keep track off. Sub table does not need a header
in the scheme implementation.

#### Creating Local Tables

It we mash all the code into a single procedure we can finally do the implementation.

```scheme
(define (make-table)
  (let ((local-table (list *table*)))

    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
              (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))))
          (set-cdr! local-table
                    (cons (list key-1
                                (cons key-2 value))
                          (cdr table)))))
      'ok)

    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
              (cdr record)
              false))
          false)))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))
```

> Bada bing bada boom

```scheme
(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
```
