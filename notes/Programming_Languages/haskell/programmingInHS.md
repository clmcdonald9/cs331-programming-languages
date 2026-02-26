# Flow of control
(the way a pl determines what code is executed)

pattern matching, choose one of a number of function defs

haskel does have if else, not used as much

no loops, recursion
recursion is less costly in haskell than others because of tail-call optimization

lazy evaluation
can make infinite lissts

``` listFrom n = n:(listFrom (n+1)) ```

corecursion - generate a sequence recursively, access in a lazy way

write your own if-else

## selecton

flow of control that allows to choose one of multiple options to execute

cpp uses if-else, and switch, and dynamic dispatch of class methosd

haskell, pattern matching works as selection


## guards

myAbs x
    | x>0 =x
    |otherwise =-x

otherwise is a variable, = true?

## encapsulated loops

many flow of control constructs can be encapsulated as functions

```
var w: [Int] = []
for n in v {
 w.append(n % 3)
}
```

```
w = map (\ n -> n `mod` 3) v
w = [ n `mod` 3 | n <- v ] -- Alternate form, using a
```

## fold operations
loop involving processing sequence.
return can be sum of all nums, greatest in sequence, etc
called fold or reduce

foldl, fold1, foldr, fold l1

l adn r are left and right


## other
### seq
primitive function, cannot be written
acts similar to ``` seq x y = y ```
returns second arg
but it evaluates the first arg even though it is unnecessary

the only exception to lazy evaluation

used to control evaluation

a user written list length func can crash with stack overflow for large lists
make the function tail-recursive
use seq to prevent the construction of inc complex unevaluated expressions

### do-expressions

do leads to a block that doesnt look like haskell
???
