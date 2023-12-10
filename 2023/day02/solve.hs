import Text.Regex.TDFA
import Data.List.Split (splitOn)
import Data.Text.Internal.Fusion (Stream)
import Text.ParserCombinators.ReadP (string)
import Control.Arrow (Arrow(first))
import Control.Monad.Trans.Cont (cont)

-- Part One

parseColorset = getValue . (`extractGroups` "([0-9]+) (blue|red|green)")


-- parseDetail :: (String, String) -> [[(String, Int)]]
parseDetail (gameNum, details) = do
    let res = [
                [ parseColorset colorset | colorset <- splitOn [',', ' '] try ]
                | try <- splitOn [';', ' '] details 
                ]
    (read gameNum, res)

checkColorset :: [String] -> Bool
checkColorset [num, color] = do
    case color of
        "blue" -> read num <= 14
        "green" -> read num <= 13
        "red" -> read num <= 12
        _ -> False

checkTry try = do
    all checkColorset try

-- checkBag :: (Int, [a]) => Bool
checkBag :: (Foldable t1, Foldable t2) => (a, t1 (t2 [String])) -> Bool
checkBag (gameNum, tries) = do
    all checkTry tries

extractGroups :: String -> String -> Maybe [String]
extractGroups text pattern =
    let (_, _, _, groups) = text =~ pattern :: (String, String, String, [String])
    in if null groups then Nothing else Just groups

-- convert "Game 1: details" -> ("1", "details")
processText :: String -> (String, String)
processText text = 
    case extractGroups text "Game ([0-9]+): (.*)" of
        Just [gameNum, details] -> (gameNum, details)
        _                       -> ("", "")

-- Part Two
-- convert "try1; try2; try3" -> ["try1", "try2", "try3"]
splitTries = splitOn [';', ' ']

-- conver "3 blue, 4 red; 1 green" -> (3, "blue"), (4, "red"), (1, "green")
splitColors = splitOn [',']
splitColorset x = [(makeTuple . getValue) (extractGroups y "([0-9]+) (blue|red|green)")| y <- splitColors x]

-- convert ["3", "blue"] -> (3, blue)
makeTuple [x, y] = (read x :: Int, y)

getValue (Just x) = x
getValue Nothing  = error "no value"

-- calc max colorsets
-- [[(3,"blue"),(4,"red"),(1,"green")], [(4,"blue"),(2,"red"),(3,"green")]] -> 4,4,3

getColor col try = maximum [ if col == c then n else 0 | (n, c) <- try]


getColorMax tries = 
    maximum [ getColor "blue" try | try <- tries] * 
    maximum [ getColor "red" try | try <- tries] *
    maximum [ getColor "green" try | try <- tries]

-- get score for a line

------------------------------------------------------------------------------
-- Main


splitDetail detail = [ splitColorset try  | try <- splitTries detail ]

main :: IO ()
main = do
    let filename = "input1.txt"
    let pathname = "/Users/skash/advent-of-code/2023/day02/"
    content <- readFile (pathname ++ filename)
    let contentLines = lines content

    let details = [(snd . processText) ln | ln <- contentLines]
    
    print $ sum [getColorMax $ splitDetail detail | detail <- details]

    -- print $ sum  [getColorMax x | x <- parsedDetails]

    -- let output = sum $ map fst (filter checkBag result)

    -- print $ getColorMax [[(3,"blue"),(4,"red"),(1,"green")], [(4,"blue"),(2,"red"),(3,"green")]] 


    -- print output

