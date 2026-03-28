-- PA5.hs
-- Crysta McDonald
-- Module for CS 331 programming assignment 5

-- start date: 3/19/26
-- last updated: 3/21/26

-- PA5.hs was written using Glenn G. Chappells PA5.hs skeleton as a base


module PA5 where


-- =====================================================================


-- collatzCounts
collatzCounts :: [Integer]
collatzCounts = map collatzSteps [1..]

collatzSteps n
  | n == 1 = 0
  | even n = 1 + collatzSteps(div n 2)
  |otherwise = 1 + collatzSteps(3 * n + 1)
    

-- =====================================================================


-- operator #<
(#<) :: Ord a => [a] -> [a] -> Int
[] #< _ = 0
_ #< [] = 0
(a:as) #< (b:bs)
  | a < b = 1 + (as #< bs)
  | otherwise = (as #< bs)

-- =====================================================================


-- filterOther
filterOther :: (a -> Bool) -> [a] -> [b] -> [b]
filterOther _ _ [] = []
filterOther _ [] _ = []
filterOther p (a:as) (b:bs)
  | p a = (b: filterOther p as bs)
  | otherwise = filterOther p as bs

-- =====================================================================


-- sublist
sublist :: Eq a => [a] -> [a] -> Maybe Int
sublist [] _ = Just 0



-- =====================================================================


-- concatAlternate
concatAlternate :: [String] -> (String, String)
{-
  The assignment requires concatAlternate to be written as a fold.
  Like this:

    concatAlternate xs = fold* ... xs  where
        ...

  Above, "..." needs to be replaced by other code. "fold*" must be one
  of the following: foldl, foldr, foldl1, foldr1.

  The code below will work, but it does not meet the above requirement.
  So it would not be graded, if it were turned in.
-}

-- REWRITE THE FOLLOWING!!!
concatAlternate [] = ("", "")
concatAlternate (s:ss) = (s ++ b, a)  where
    (a, b) = concatAlternate ss