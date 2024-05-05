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

### 3.3.4 A Simulator for Digital Circuits

This is the section where electrical circuits are studied and created. As an application
of *event driven simulations*, it showcases the power of the environment model of
execution and the power of assignment. The circuit simulator will begin with describing
what wires are, agendas, before moving on to basic gates and then to circuit components.

Wires are things that have internal state and have pointers to them. Passing them
to a gate will read their state and write to output wire.

What is happening is that lisp defines a method for creating a language for dealing
with the simulation of wired connections. It has the full closure property.

#### Primitive Function Boxes

What needs to happen is to define a set of primitive procedures to describe manipulations
of wires. Which includes reading signal, changing the signal, adding connections,
and managing delay callbacks.

Code is at `code/Circuits.scm`

#### Representing Wires

The internal representation of wires is a simple dispatch procedure object,
that returns the correct action procedure. On each action of setting signal,
the procedure checks if it is actually changing changing anything and if so it
runs the action procedures.

#### The Agenda

The agenda is merely a list of things to do after a wire has been updated. Functions
associated with agendas include a constructor, predicate, getters and setters. The
most important function to implement the agenda is the `current-time` procedure.
The implementation defines a global agenda variable.

The `propagate` function calls each procedure in the global agenda object and removes
each item until their is nothing left to do.

#### A Sample Simulation

Here a way to see the simulator in action is shown as a virtual probe to check
value of wire on each update. At this point I give up on both exercises and code.
This is just cool exercise but I am not getting any inspiration or motivation from
this section to write some code. Yet.

#### Implementing the Agenda

An agenda is comprised of *time segments* in which a time is declared and a set of
agenda entries to be executed at that time. It should be possible to set many of
the definitions here and place them into separate modules as opposed having them
all in a single file. But that sort of functionality is not present yet

### 3.3.5 Propagation of Constraints

In order to model relationships that can go in multiple ways in which the variables
can affect one another, it is necessary to design a language to solve it.
There are instances in which equations allow for omnidirectional computations
but a computational model is difficult to imagine since it is linear.

Primitive Constrains
: primitive elements of a language for constraints and relations.

Here the book describes a way to describe an equation as a set of boxes and constraints
in order to compute a conversion between Celsius and Fahrenheit and vice versa.
Different contains, connections and arguments are required to allow for data to
flow in different directions. And I don't get it.

#### Using the Constraint System

Here is where the code is written and not understood: `code/Contraints.scm`
Non-directionality of computation is a feature of constraint based systems.

#### Implementing the Constraint System

Here is where more code is shown. I am just typing in the code and not really learning
anything. That coolest thing I have learned is representing objects with procedures.

#### Representing Connectors

Here is the representation of the connector type.
