

data BT vt = BTEmpty | BTNode vt (BT vt) (BT vt)

bstInsert :: (Ord vt) => [vt]

bstInsert BTEmpty x = BTNode x BTEmpty BTEmpty
bstInsert (BTNode root lsub rsub) x
    | x < root = BTNode root (bstInsert x lsub) rsub
    | otherwise = BTNode root lsub (bstInsert rsub x)


treesort : (ord vt) => [vt]
