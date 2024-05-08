## 3.4 Concurrency: Time is of Essence

With the introduction of time into computer programs it is now possible to write
programs that are capable of executing in parallel, at the same time. Moments in
time allows for programs to execute in parallel and return a value.

A new idea around writing programs as if their are about to be executed in parallel
allows for forcing a way of thinking which inherently makes programs more modular.
If the program allows itself to be split into several pieces then it becomes easy
so create a parallel version of execution.

The bad news it that concurrency increases complexity even further and introduces
even more potential for bugs.

### 3.4.1 The Nature of Time in Concurrent Systems

Here is where race conditions are first encountered in SICP. Using the boring old
example of a banking system. Global/shared variables between multiple processes
must have some sort of safeguards when against those multiple processes writing
to the shared memory at the same time.

#### Correct Behaviour of Concurrent Programs

The way to ensure that concurrent programs behave correctly and produce the correct
results is to place restrictions on the execution. Such restrictions must match
the hypothetical program version that runs exclusively sequentially. Concurrent
programs are non-deterministic since there is no way to predict the result. Processes
can also update values that it itself owns and reads values from other processes.

### 3.4.2 Mechanisms for Controlling Concurrency

The order in which things can happen becomes a sort of set theory combination.
Instructions of the computer can theoretically be executed by the CPU in the
order to the number of combinations of the instructions that are to be executed.

Serializer
: Method for ordering procedures to execute in a way that follows some predefined
  order or way to restrict some sets of instructions from executing concurrently.

#### Serializing Access to Shared State

Serialization is done by restricting access to variables, prevent other processes
from writing to a variable.

#### Serializers in Scheme

Wishful thinking, however I know of a procedure in GNU Guile called `parallel`.
Which should do the same thing as `parallel-execute`, which takes a *thunk*, a
procedure with no arguments. We have to generate a procedure and then pass said
procedure to the function.

```scheme
(parallel-execute <p1> <p2> <p3> ...)
```

#### Complexity of Using Multiple Shared Resources

Serializers allow for easy restrictions on concurrent access of a single variable,
but when there are multiple values, the task of managing processes becomes difficult
one again. In order to protect all relevant values and ensure that the intended
behaviour is followed.

Of course one can offload the serialization duties to the user, make them do it.

#### Implementing Serializers

 Serializers are implemented in terms of a thing called a *mutex*.

Mutex
: Mutual exclusion, can be acquired and locked, to prevent other processes from
  accessing some sort of variable. It is a lock. 

The implementation of the mutex
is a one element list with the symbol inside either `true` or `false`. If there
are processes waiting to get access to a resource associated with the mutex then
it tests and tests again and again until it finds the right time to acquire it
as soon as it is unlocked.

Operations on mutexes must be done *atomically* to ensure that race conditions do
not occur on mutexes themselves. In single core CPUs. Mutexes work wonders, the
hardware should provide means to help keep order with multiple threads.

#### Deadlock

Deadlock refers to two threads waiting to gain access to a resource but neither
is able to get it at any point. One way to avoid deadlock is to have the threads
maintain a list of UUIDs and do a round robin attempts at accessing the resource.
Deadlock recovery can involve having the processes back out of the deadlock
situation and trying again.

#### Concurrency Time and Communication

The fundamental problem with multiprocessing is that idea of shared state, what
is part of it and what is unique to each process. Modern CPUs have more effective
means to control the concurrency, such as *barrier synchronization*.
It is not always possible to predict the order of execution in concurrent systems.
The last sentence brings up the theory of relativity.
