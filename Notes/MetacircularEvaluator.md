## 4.1 The Metacircular Evaluator

Metacircular refers to the idea of an interpreter written in the language
that it interprets. It is fully bootstrapped. There are two parts in the evaluator.

1. Evaluate smaller expressions to evaluate larger expression
2. to call a procedure replace arguments into formal body of procedure

Here is where `eval` and `apply` are first mentioned. The lecture also talks about
them and showed a simple implementation, both are defined in terms of the other.
There are some other functions that are mentioned.

### 4.1.1 The Core of the Evaluator

Code is at `code/MetacircularEvaluator.scm`

`Eval`
: Case analysis that takes in an expression and environment and procedures to evaluate
  the expression given the environment. If it finds a procedure call it calls `apply`

- **primitive expressions**: returns symbols and numbers, variable values
- **special forms**: macros and special syntax, and *lambda*

Here is the beautiful code.

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

`Apply`
: takes procedure and list of arguments and calls procedure with list of arguments.
  It has a base case of `apply-primitive-procedure`.

```scheme
(define (apply proc args)
  (cond ((primitive-procedure? proc)
         (apply-primitive-procedure? proc args))
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

### 4.1.2 Representing Expressions

There must be a way to differentiate between different types of expressions.
The way to do it is to first define what types of expressions are self evaluating.
Things that represent themselves.

- symbols
- numbers
- strings

Variables are symbols that are meant to be replaced with something else.
