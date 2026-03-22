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

# Basics

## from the reading, expressions, defining

a list is a symbol that evaluates to a procedure
informally, just called a procedure

bind a symbol to a val with define
``` (define abc (+ 33 99))```

can also create a procedure with define
first arg is a picture of a procedure call
``` (define (square x) (* x x)) ```

define breaks the normal eval rule because the arguments are not evaluated before calling define. define is not a procedure, its a macro

## simple display

single quote suppresses evaluation of whatever is after it, used to display a list

begin takes 0 or more expr, evaluates all, returns last value. use begin to combine io calls

## conditionals

everything is truthy except false

cond is like if elseif or haskell guards
takes list of 2 item lists of a condition and an expr.
expression with the first truthy condition is evaluated and returned, optional last condition else

## lists
two heavily used procedures are "car" and "cdr:

for a nonempty list, car returns first item and cdr returns a list of the remaining items

cons constructs a pair. construct a list from an item and a list like : in haskell

common to use combinations of car and cdr
(car(cdr(cdr'(a b c d e)))) returns the third item

## predicates

names of scheme preds often end in a predicate

type checking preds
number?
null?
pair?
list? returns true if arg is a list, runs in linear time.