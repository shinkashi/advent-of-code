import System.IO
import Data.Char (isDigit)
import Data.List (isPrefixOf, isSuffixOf)


-- Replace spelled-out numbers with digits in a string
getFirstDigit :: String -> Char
getFirstDigit list
    | isDigit (head list) = head list
    | "one" `isPrefixOf` list = '1'
    | "two" `isPrefixOf` list = '2'
    | "three" `isPrefixOf` list = '3'
    | "four" `isPrefixOf` list = '4'
    | "five" `isPrefixOf` list = '5'
    | "six" `isPrefixOf` list = '6'
    | "seven" `isPrefixOf` list = '7'
    | "eight" `isPrefixOf` list = '8'
    | "nine" `isPrefixOf` list = '9'
    | otherwise = getFirstDigit (drop 1 list)

getLastDigit :: String -> Char
getLastDigit list
    | isDigit (last list) = last list
    | "one" `isSuffixOf` list = '1'
    | "two" `isSuffixOf` list = '2'
    | "three" `isSuffixOf` list = '3'
    | "four" `isSuffixOf` list = '4'
    | "five" `isSuffixOf` list = '5'
    | "six" `isSuffixOf` list = '6'
    | "seven" `isSuffixOf` list = '7'
    | "eight" `isSuffixOf` list = '8'
    | "nine" `isSuffixOf` list = '9'
    | otherwise = getLastDigit (init list)

-- Find first and last digit in a string
findFirstAndLastDigit :: String -> (Char, Char)
findFirstAndLastDigit list = (getFirstDigit list, getLastDigit list)

processLines :: [String] -> Int
processLines = sum . map (readDigits . findFirstAndLastDigit)
  where
    readDigits (f, l) = read [f, l] :: Int

-- test

input :: [String]
input = 
    [ "two1nine"
    , "eightwothree"
    , "abcone2threexyz"
    , "xtwone3four"
    , "4nineeightseven2"
    , "zoneight234"
    , "7pqrstsixteen" 
    ]

-- Main function to read file and calculate the value
main :: IO ()
main = do
    
    print $ processLines input

    content <- readFile "/Users/skash/advent-of-code/2023/day01/input.txt"
    let linesOfFiles = lines content
    print $ processLines linesOfFiles
