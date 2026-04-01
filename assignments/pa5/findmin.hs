-- findmin.hs
-- Crysta McDonald

-- Stand-alone program that takes a sequence of integers
-- and finds the minimum value in the sequence.

-- start date: 3/28/26
-- last revised: 3/31/26


module Main where

import System.IO
import Text.Read (readMaybe)


updateMin :: Int -> Maybe Int -> Maybe Int
updateMin new Nothing = Just new
updateMin new (Just old)
    | new < old = Just new
    | otherwise = Just old
    

loop :: Maybe Int -> IO (Maybe Int)
loop currentMin = do
    putStrLn ""
    putStr "enter an integer, or enter a blank line to finish : "

    hFlush stdout
    input <- getLine

    checkInput input where
        checkInput str
            | str == "" = return currentMin
            | otherwise = case readMaybe str of 
                Nothing -> do
                    putStrLn "only integer inputs are allowed"
                    loop currentMin

                Just n -> do
                    let newMin = updateMin n currentMin
                    loop newMin


showMin :: Maybe Int -> IO ()
showMin n = case n of
    Nothing -> putStrLn "You did not enter any integers"
    Just n  -> do
        putStr "The smallest entered integer is: "
        putStrLn (show n)


main = do
    putStrLn ""
    putStrLn ""

    putStr   "Enter 1 integer on each line,"
    putStrLn " and the smallest number in the list will be shown."
    putStrLn "To finish the list, enter a blank line."

    result <- loop Nothing
    showMin result

    tryAgain where
        tryAgain = do
            putStrLn ""
            putStr "Would you like to try again? (y/n) "

            hFlush stdout
            answer <- getLine
            putStrLn ""

            case answer of
                "y" -> main
                "n" -> putStrLn "Goodbye."
                _   -> do
                    putStrLn "only enter 'y' or 'n' "
                    tryAgain


    