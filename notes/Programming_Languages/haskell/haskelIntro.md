## history
in 1987 the fp community met and  created a single pure functional PL, Haskel

in 1998, haskell 98
HUGS and GHC, later combined

haskel standard 2, haskell 2010, the latest

efforts to produce a third standard have stalled, ghc is its primary implementation, and there are many extensions

# characteristics

simple syntax, less than even lua
does not need parenthesis for functions call, optional

significant indentation. the usual way to indicate the start and end of a block.

## type system

sound static type system with sophisticated type inference. typng is largely implicit, optional type annotations.

type checking standards are hard to place on the nominal-structural axis

static typing like c++ and java, but it has sophisticated type inference.

type annotations allowed.
n::integer
n = 3
but not
n::integer
n = "a"


## flow of control
tail call something?

pattern matching is less conveniant then pattern matching 

factorial 0 = 1
factorial n = n*factorial

lazy evaluation
expressions are not evaluated until necessary.

# build and execution

GHC is a haskell compiler, GHCi is an interactive environment, a read eval print loop

:t EXPRESSION
gets the type of expression
