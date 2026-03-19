# history

scheme follows a minimalst design with small simple core and versatile tools

differs before  differs from trad lisp, so some deny that it is a dialect of lisp (but it is a part of the family)

plt scheme, renamed racket. drRacket is an ide

# characteristics
## intro

scheme code is parenthesized lists, containing atoms or other lists. items separated by space, blanks and nl are the same

procedure same as function 

## type system

basically just like lua

dynamic, implicit, type annot are unnecessary

structural typechecking
type safety

fixed set of types, lot of them (somewhere around 36?)

pair, null, and a bunch of atoms

some atoms:
- bool, literals are #t and #f
- strings, literals use ""
- chars, a is #\a
- symbols, an identifier, symbols are not the name of the thing, they ARE the thing
- numbers, 7 types of numbers
    * ints
    * floats
    * exact rational nums
    * complex nums,
- procedure, a first class function. can be bound to a symbol or unnamed

## flow of conttrol

no special syntax for flow of control, if


## misc


local and global like lua
local is lexically scoped
global is dynamic scoped

not pure functional pl
    mutable data

syntax and