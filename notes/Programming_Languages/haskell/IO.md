# I/O

haskell doesnt do I/O, it comes up with a description of what something would do and I/O is handled by something else?


haskell keeps io and string conversion mostly separate
(not a rule)

dollar op, low precedence do nothing operator, basically same as parenthesis?

## typeclass
a collection of types that all implement some particular interface
always start with capital letter

- eq: equality comparable typed
- ord: orderable types
- num: numeric types

haskell does overloading only through typeclasses
types in class eq are the only types where == is defined

typeclasses related to string conversion:
- Show: showable types have conversion to string using function show
- Read: readable types have conversion from string using function read

## simple output

a programs return value includes a description of what the side effects the program wants to do, the runtime environment performs the side effects

a side effect desc is stored in a haskell I/O action

when expression with io action value is entered into ghci, the io is performed


>> op combines 2 io actions into one, describing the actions of both

## io actions

io action is a description of a sequence of 0 or more side effects and a wrapped value

we cannot look at waht is in an io action, but we can talk about it

io action for putStr
- print string
- ()

multiple to one io action
results in a desc of all side effects and the value of the last io action


## simple input
when input, use an io action that wraps the value we input

how to access the wrapped string
if you pull out the string, it violates pure functional programming

>>= has 2 operands
io action wrapping a value
function that takes a value and returns an io action

wrapped val is passed to the func, returning an io action
not pulling it out, pushing it into a function?

ends with a combined io aciton

getline returns io action wrapping a string
putstrln takes a string and returns io action
putting them together with >>= results in input then output

an IO action without any side effects; it is useless when wrapped with others unless it is the last io action

## Do expressions

cleaner way to write IO
```
do
    line <- getLine
    putstrln line
```

function hFlush is given a handle to open a file. returns an io action that flushes
do hFlush stdout after printing a prompt and before doing input

handle - object that identifies and allows access to an open file
flush - write any buffered characters

## return

an io action can involve no side effects

return has an io action with no side effects

getChar does single char input, returns io action wrapping a char

## let

let NAME = EXPR in a do block to bind a name to a normal value (not io wrapped)

haskell function must have a consistent return type.
if else block returns io action, then if block must also. return()