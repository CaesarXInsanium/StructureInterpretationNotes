## 3.1 Assignment and Local State

> [Relevant Lecture 5A](https://youtu.be/a2Qt9uxhNSM?si=bnAnEcuD6LOevxlz)

Sometimes previous values are not important, the 'enviroment model' of computation
allows not needed the history of value to make use of it now. Computational objects
must be decoupled from time and an assignment operation is required, to change
value associated with a variable.

### 3.1.1 Local State Variables

Here is where the example Bank Account program is used to show the idea of state
and setting the values of a variable, associated with a symbol. 

[Code](code/AssignmentAndLocalState.scm)

We see a function that returns a different value each time that it is called.
Because it has a side effect.

`begin` form is introduced, only value of last expression is returned.

Encapsulation needs to happen in order to protect values of one section of a program
from being modified in another section. A new model of computation if required
in order to make sense of the intricacies of `set!`.
