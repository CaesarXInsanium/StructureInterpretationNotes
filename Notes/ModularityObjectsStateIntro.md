# Chapter 3: Modularity, Objects and State

The lecture talks about how the `set!` function kills many of the nice
functional properties that all of the previous programs have had. But it also
allows for the separation of different concepts from one another into separate
systems that can be independently worked with.

Separating different functions would allow separate feature addition or debugging,
localized to more narrow sections. Another idea is to match the structure of
the systems that the program is supposed to emulate.

Delayed Evaluation
: decoupling the time from the order of execution, allowing for concurrency.
