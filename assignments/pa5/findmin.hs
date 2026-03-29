-- PA5.hs
-- Crysta McDonald

-- Stand-alone program that takes a sequence of integers
-- and finds the minimum value in the sequence.

-- start date: 3/28/26
-- last updated: 3/28/26


-- convert line to integer, add to list? 

module Main where

import System.IO
import Text.Read (readMaybe)

handleInput -- I dunno what i doing and I scared :()

main = do
    putStr "enter a number or a space to end: "
    hFlush stdout
    input <- getLine
    handleInput input
    