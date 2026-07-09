## 4.2 Variations on A Scheme - Lazy Evaluation

This section appears to be more about the implementation of fancy features in
this base high level implementaion of features from a high level prespective.
This section seems to be more about being able to steal features from the high
level implementation language of scheme, and lower them down into the
interpreteted level.

### 4.2.1 Normal Order and Applicative Order

This is what we mean by lazy evaluation. Normal order IS lazy evaluation. Some
languages need the arguments to a function to be evaluated before the function
call, and that is applicative order.

Strict evaluation is the same as applicative order, the arguments to a procedure
are evaluated before the execution of the body of the procedure.

Lazy evaluation allows for fancy and fast behaviour, such as the ability to
count elements in a list without even known what items are in the list.

### 4.2.2 An Interpreter with Lazy Evaluation

This section appears to now focus on the ability for our scheme interpreter to
implement actual lazy evaluation. It will be done by wrapping expressions to be
evaluated inside of thunks, which contain type information, the body of the
lambda, a copy of the environment in which the code inside is to be evaluated.

To get the value from a thunk, we are to `force` it, which to say evaluate it.
This method of implementing lazy evaluation, allows for easy memoization, values
do not have to be evaluated more than once. But it comes at the cost of space.

The code is now in `code/LazyEvaluation.scm`. Most of which is copied and
modified slightly.

### 4.2.3 Streams as Lazy Lists

Special forms and macros are not first class objects like the normal compound
procedures. What must happen instead is that some features for other featurs
must be implemented in terms of basic procedures in order to to get other things
working. WTF.

Ok so on a more thoughough reading, I have come to the understanding that this
section is actually about implementing some more basic features of the
interpreted language scheme, such as `cons` in terms of other features. To not
have something like the `cons` pairs be a sort of primitive feature, but rather
be implemented in terms of the language itself.

> So basically remove the 'cons' and 'cdr' and 'car' from the list over here

```scheme
(define primitive-procedures
  (list (list 'car car) 
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? '())
        (list '+ +)))
```

And define them in the `the-global-enviroment` variable

```scheme
(define the-global-enviroment (standard-library (setup-enviroment)))
```

Where standard library goes trough all the definitions inside the standard
initial enviroment like so.

```scheme
(define (cons x y) (lambda (m) (m x y)))
(define (car z) (z (lambda (p q) p)))
(define (cdr z) (z (lambda (p q) q)))
```

It is only from there that we then begin to accept user code. Of course we might
want to implement other useful functions just so that the user does not have to
do so themselves. As seen in the rest of the code in
  `code/InitialEnviroment.scm`.

I was going to try and get the code provided here to be evaluated, but I have
no I idea how the machinary is supposed to work. Specially since it seems that
some of the more important things have side effects. I give up.

There is more code in the book. But I refuse to actually write it down.
