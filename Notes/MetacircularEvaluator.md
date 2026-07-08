## 4.1 The Metacircular Evaluator

Metacircular refers to the idea of an interpreter written in the language
that it interprets. It is fully bootstrapped. There are two parts in the evaluator.

1. Evaluate smaller expressions to evaluate larger expression
2. to call a procedure replace arguments into formal body of procedure. create a
   new enviroment

Here is where `eval` and `apply` are first mentioned. The lecture also talks about
them and showed a simple implementation, both are defined in terms of the other.
There are some other functions that are mentioned.

Expresions are substituted, and simplified until we get down to symbols and
literals. The symbols are looked up in a table to get their values and the
literals are self evaluating, the are passed forward.

Evaluator must substitute symbols for values before the greater
expression/function call be collapse into a single value. `eval` deals with
procedure and arguments, `apply` deals with the expression and enviroment

### 4.1.1 The Core of the Evaluator

Code is at `code/MetacircularEvaluator.scm`

`Eval`
: Case analysis that takes in an expression and environment and procedures to evaluate
  the expression given the environment. If it finds a procedure call it calls
  `apply`. This is merely an application of pattern matching.

- **primitive expressions**: returns symbols and numbers, variable values
- **special forms**: macros and special syntax, and *lambda*

Here is the beautiful code.

> Connection to crafting interpreters: the following code is an implementation
> of the syntax/grammar rules for the language scheme. I would show the code but
> after looking at it again, I realize that I hate it. I prefer scheme's style.

```scheme
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assingment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else (error "Unknown expression type -- EVAL" exp))))
```

> From rereading chapter 3 section on streams, I have come to realize that lazy
> evaluation can be implemented using streams.

The two functions of `apply` and `eval` call each other, until some terminals
are reached. Of course we have to have a reader that gives as raw quoted symbols
and literals and stuff.

`Apply`
: takes procedure and list of arguments and calls procedure with list of arguments.
  It has a base case of `apply-primitive-procedure`.

```scheme
(define (apply proc args)
  (cond ((primitive-procedure? proc)
         (apply-primitive-procedure proc args))
        ((compound-procedure? proc)
         (eval-sequence (procedure-body proc)
                        (extend-enviroment (procedure-parameters proc)
                                           args
                                           (procedure-enviroment proc))))
        (else (error "Unknown procedure type -- APPLY" proc))))
```

- `list-of-values` : used to evaluate arguments to a procedure
- `eval-if`: only the correct branch of execution is evaluated
- `true?`: implementation define predicate, does the value of the predicate expression
  yield a value that can be interpreted as a true
- `eval-sequence`: used to evaluate list of expressions
- `eval-assignment`, `eval-definition`: modifies the current frame with values

> The code for these are in `code/MetacircularEvaluator.scm`

### 4.1.2 Representing Expressions

There must be a way to differentiate between different types of expressions.
The way to do it is to first define what types of expressions are self evaluating.
Things that represent themselves.

- symbols
- numbers
- strings
- quoted symbols
- booleans
- empty list `'()'`

Variables are symbols that are meant to be replaced with something else. They
are looked up in some sort of mapping or table, which will then be replaced
with the corresponding value in the data structure before the `eval` function.

Which means self evaluating things are terminals. Here is the relevant
predicate.

```scheme
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))
(define (variable? exp) (symbol? exp))
```

stuff that should not be immediatly evaluated

```scheme
(define (quoted? exp) (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))
(define (tagged-list? exp tag) (if (pair? exp) (eq? (car exp) tag) #f))
```

Deals with assignment.

```scheme
(define (assignment? exp) (tagged-list? exp 'set))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))
```

We already what the syntax for using the `define` keyword. We know that can be
used to defined mutable variables as well as functions. They have two syntaxes,
one is sugar for `lambda`

```scheme
(define (definition? exp) (tagged-list? exp 'define))
(define (definition-variable exp) (if (symbol? (cadr exp) (cadr exp) (caadr exp))))
(define (definition-value exp) 
  (if (symbol? cadr exp) 
    (caddr exp) 
    (make-lambda (cadadr exp) (cddr exp))))
```

`lambda` is defined directly in the interpreter, as a primitive for the
language. 

```scheme
(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
;; make a thing that can have the `eval` function work on
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))
```

> I realize the copying code over is a waste of time

So basically the books is just giving us some very basic code, some of the
intuitive fundamental blocks that would be required to build everything to
evaluate a list of code that can be worked with. Assuming that we already have
all of the tokens.

#### Derived Expression

Some expressions can merely be implemented in terms of other expressions. This
was the deal in earlier chapters. No the concept will be applied to the `cond`
form. We are dealing with semantics. It is closer to theory than the real life
world. Kind of like functional languages are actually an abtraction over the
real life computer that is running the code, which is full of state. The real
life machine is full of state.

`cond` expression are being expanded into nested `if` expression. So in a sense,
the `cond` expressions are special primitive forms. At least that is what I am
thinking while reading the code provided.

### 4.1.3 Evaluator Data Structures

The main thing there is the ability for a symbol to be associated with a value.
In predicates literally everything is true except for the explicit `false`
symbol. However, in my current scheme interpreter, Guile, that becomes something
tricky since we already define `#t` and `#f` as the boolean literals.

With procedures it becomes a mattter of differentiating between primitive
procedure and user defined procedures, syntax sugar `define` or `lambda`.

Defining variables and setting their values are operations that act on an
`enviroment` data structure. The key thing that I remember is that setters and
getters, more specifically the speed of their implementation, are really what
define the speed of the scheme implementation. Specially definitions and setters
have to both look up the value of a symbol and set the new value(or create a new
one).

Code is in the corresponding `MetacircularEvaluator.scm`. Use FZF to find it.

The type unsafety inherent in the code provided by the book is on purpose. In
the evaluator, we are forced to continously ask the variables and arguments what
type that they are. If they fail, then the code crashes in a way that might be
easier to debug. It is only at the compiler level do we iron out the type
unsafety.

I have noticed that the code for finding variables and setting variables is very
inefficient, linear in time scale. A more efficient approach would be a hash
table but that is beside the point. The recurive and iterative functions for
doing these things also have duplicative code, they loop similar enough.

### Running the Evaluator as a Program

On the first reading, it seems to be talking about the actual infrastrcuture
required to start implementing the REPL. It does so by creating a starting
enviroment object. And then making a core loop that asks for expression that it
can evaluate. This can extend to some code that can run from a file as input.

Eval reduces doing to application of procedures. Apply works by evaluating the
arguments before the procedure can actually work, and name resolve the code for
the procedures.

There has to be a starting point, a bootstrap. An initial enviroment is
required. And that in itself requires more primitive building blocks.
