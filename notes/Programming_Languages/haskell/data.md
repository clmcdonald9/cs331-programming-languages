## data declaration
defining new types and implementing data structures

data declaration

```
data Product = pr string string
-- product name, manufacturer name
``` 

product is the name of a new types
pr is a constructor

```
doNothing :: product -> product
doNothing (Pr pn mn = Pr pn mn)
```
takes product and returns the same product
```
pName :: product -> string
pName (Pr pn _) = pn
-- gets product name
```
## overloading and type classes

overloading == using typeclass Eq

place the type (product) into  the Eq type class
product is an instance of class Eq

```
instance Eq Product where
 Pr pn1 mn1 == Pr pn2 mn2 =
 (pn1 == pn2) && (mn1 == mn2)
```

## options and  parameterization


data dec can have multiple options on riight side separated by |


parameterized type is similar to a cpp class template

### maybe
allows making a value of an existing type that can also have null val

maybe can be used to make nothing indicate and error
data Maybe t - Just t  | Nothing

### Either
make a val that holds one of two specified types 


### Binary tree type

call type BT, two constructors: BTEmpty and BTNode

```
data BT vt = BTEmpty | BTNode vt (BT vt) (BT vt)
```


## Treesort

Treesort is comparison sort, given a list it:
- creates an empty bst
- inserts each list item into bst
- does inorder traversal to generate the final sorted list

