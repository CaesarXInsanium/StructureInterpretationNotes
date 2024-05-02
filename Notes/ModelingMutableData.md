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
