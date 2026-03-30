-- PA5.hs
-- Crysta McDonald

-- Stand-alone program that takes a sequence of integers
-- and finds the minimum value in the sequence.

-- start date: 3/28/26
-- last updated: 3/28/26


-- convert line to integer, add to list? 

module Main where

-- next step:
--      instead of adding to a list, 
--      I want to just keep track of the minimum value

import System.IO
import Text.Read (readMaybe)
handleInput :: String -> [Int] -> [Int]
handleInput i list = 
    case readMaybe i of
        Nothing -> list
        Just n -> list ++ [n]
endLoop :: String -> [Int] -> IO [Int]
endLoop input list
    | input == " " = return list
    | otherwise = do
        let newList = handleInput input list
        compareLists list newList where
            compareLists as bs
                | length as == length bs = do
                    putStrLn "Only integer inputs will be added to the list."
                    putStrLn ""
                    loop as
                | otherwise = do
                    putStrLn $ "your list so far: " ++ show bs
                    putStrLn ""
                    loop bs

loop :: [Int] -> IO [Int]
loop list = do
    putStr "enter an integer, or a space to end: "
    hFlush stdout
    input <- getLine
    endLoop input list

minimumValue :: [Int] -> Int

    

main = do
    result <- loop []
    putStrLn $ "This is your finished list: " ++ show result
    

    