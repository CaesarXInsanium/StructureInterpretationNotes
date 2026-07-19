## 5.1 Designing Resgister Machines

Data paths. Controller. It is series of instructions that can change the value
of only one register per single instruction. Data to peform operations can only
be done in values stored in registers, except for save and load operations that
talk to memory/cache.

### 5.1.1 A Language for Describing Register Machines

Here the books is describing an abstract language for a register machine DSL
that can describe a machine that is specifically built to compute a single
algorithm. This abstract DSL will describe a machine with specified number of
registers, available operations and means for interfacing with the machine.

There is even buttons and means to input values into the machine and have some
sort of display on the output of values.

> Even here exercises are skipped.


### 5.1.2 Abstraction in Machine Design

I am having a hard timeunderstanding and being intuitive about the graphical
control flow diagrams that are being displayed and the DSL that is being used to
describe them. There is also the data path to think about.

> If rereading: do exercise 5.3, very interesting. I just need a means to test
> my answer. Of which I am currently not a good enough programmer to try it.

### 5.1.3 Subroutines

The book introduces the concept of other more specialized routines for
calculating the value of GCD. There is also special registers, that can
determine the control flow of the program.

I get it now, these weird instgructions are representing assembly code, that
pure logic and reasoning behind the design of assembly programs.

### 5.1.4 Using a Stack to Implement Recursion

There comes a time in which recursive processes cannot be implemented inside of
the abstract machine that was discussed purely because the DSL cannot express
the ability for an infinite number of machines expressing itself inside of
itself. It would be a fractal like thing. Therefore the solution is to use stack
to build on the machine on itself, to invoke another instance of itself with
with new arguments. However the recursion cannot be implemented in terms of
loops, as the same problem just rears its ugly head.

> 5.5 5.6 are very interesting. I might need a different resource

### 5.1.5 Instruction Summary

- assign: registers and immediate value
- arithmetic operations
- equality tests, relative operators
- goto labels
- save
- restore
