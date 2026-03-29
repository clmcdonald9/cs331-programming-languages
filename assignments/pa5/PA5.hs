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
sublist (a:as) (b:bs) = findSublist (a:as) (b:bs) 0 where
  findSublist (a:as) (b:bs) n
    | (length(a:as)) > (length (b:bs)) = Nothing
    | take (length (a:as)) (b:bs) == (a:as) = Just n
    | 
    otherwise = findSublist (a:as) bs (n + 1)



-- =====================================================================


-- concatAlternate
concatAlternate :: [String] -> (String, String)
concatAlternate as = foldr helper ("","") as where
  helper item (a, b) = (item ++ b, a)
