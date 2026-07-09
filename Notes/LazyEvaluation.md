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
lambda, a copy of the enviroment in which the code inside is to be evaluated.

To get the value from a thunk, we are to `force` it, which to say evaluate it.
This method of implementing lazy evaluation, allows for easy memoization, values
do not have to be evaluated more than once. But it comes at the cost of space.

The code is now in `code/LazyEvaluation.scm`. Most of which is copied and
modified slightly.
