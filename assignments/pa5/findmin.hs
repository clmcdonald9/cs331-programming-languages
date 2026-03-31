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

updateMin :: Int -> Maybe Int -> Maybe Int
updateMin new Nothing = Just new
updateMin new (Just old)
    | new < old = Just new
    | otherwise = Just old
    


loop :: Maybe Int -> IO (Maybe Int)
loop currentMin = do
    putStr "enter an integer, or a space to end: "
    hFlush stdout
    input <- getLine
    checkInput input where
        checkInput str
            | str == " " = return currentMin
            | otherwise = case readMaybe str of 
                Nothing -> do
                    putStrLn "only integer inputs are allowed"
                    loop currentMin
                Just n -> do
                    let newMin = updateMin n currentMin
                    loop newMin
    -- ask to go again

showMin :: Maybe Int -> IO ()
showMin n = case n of
    Nothing -> putStrLn "You did not enter any integers"
    Just n -> do
        putStr "The smallest entered integer is: "
        putStrLn (show n)

main = do
    result <- loop Nothing
    showMin result


    