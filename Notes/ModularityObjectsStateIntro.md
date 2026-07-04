# Chapter 3: Modularity, Objects and State

The lecture talks about how the `set!` function kills many of the nice
functional properties that all of the previous programs have had. But it also
allows for the separation of different concepts from one another into separate
systems that can be independently worked with.

Separating different functions would allow separate feature addition or debugging,
localized to more narrow sections. Another idea is to match the structure of
the systems that the program is supposed to emulate.

> Future: While the `set!` procedure kills functional nature of the programming
> language scheme, it also allows for a whole new conceptual model of computation.
> That of
> the frame. Understanding this section, how to it connects to the closure
> property, will make the implementation of a scheme compiler make so much more
> sense.

Delayed Evaluation
: decoupling the time from the order of execution, allowing for concurrency.
