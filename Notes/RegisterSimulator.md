## 5.2 A Register Machine Simulator

So here we are going into actually runnable and testable code. There will be a
simulator and make for a register machine, where operations can be defined and
tested.

```scheme
(define gcd-machine
  (make-machine
    '(a b t)
    (list (list 'rem remainder) (list '= =))
    '(test-b
       (test (op =) (reg b) (const 0))
       (branch (label gcd-done))
       (assign t (op rem) (reg a) (reg b))
       (assign a (reg b))
       (assign b (reg t))
       (goto (label test-b))
       gcd-done)))
```

- `make-machine`
- `set-register-contents!`
- `get-register-contents`
- `start`

> for earlier exercises, this is the machine that we are working with, non
> linear fancy stuff eh

### 5.2.1 The Machine Model

Here is where the code will be located `code/RegisterMachine.scm`. I hope that I
can just invoke it normally with no real changes in things. At least with minimal
compatibility changes.

I have written a simple stack, the machine constructor. However some
more primitive operations are still missing. Right now I going to implement the
driver loop, the instruction pointer, and now the actual ability to execute
instructions.

I have finished the big function

### 5.2.2 The Assembler
