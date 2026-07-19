# Chapter 5: Register Machines

Writing the metacircular evaluator allows for the understanding of how the list
system works. However it is too high level and abstract in the sense that we
don't know the exact mechanisms by which it works at a hardware level. This
chapter will deal with writing a register machine VM, and then writing a
compiler/translator that changes the S expressions down to register machine
commands/operations. While not explicitly a correct emulation of physical
hardware, it serves as a means to understanding the ways data flow and
operations translate from source code down to machine instructions.

Register machines are a sequence of very primitive instructions that act on
provided data. Operations are peformed on registers and on provided immediate
data from the machine code provided. Instead of writing assembly for a
particular machine, a simulator for a generic register machine will be worked
with instead.

Arithmetic is very simple to implement. `cons` sell are a bit more complicated.

> Do not read again until a Computer Design and Architecture book is read and
> mastery of concepts.

- Computer Design and Architecture: RISC V edition
- TIS 100
- CHIP 8
- MSP430
- RISC V
