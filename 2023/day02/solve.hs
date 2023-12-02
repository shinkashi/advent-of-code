import Text.Regex.TDFA
import Data.List.Split (splitOn)
import Data.Text.Internal.Fusion (Stream)

extractGroups :: String -> String -> Maybe [String]
extractGroups text pattern =
    let (_, _, _, groups) = text =~ pattern :: (String, String, String, [String])
    in if null groups then Nothing else Just groups

processText :: String -> (String, String)
processText text = 
    case extractGroups text "Game ([0-9]+): (.*)" of
        Just [gameNum, details] -> (gameNum, details)
        _                       -> ("", "")


getValue (Just x) = x
getValue Nothing  = error "no value"

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
checkBag (gameNum, tries) = do
    all checkTry tries


main :: IO ()
main = do
    let filename = "input1.txt"
    let pathname = "/Users/skash/advent-of-code/2023/day02/"
    content <- readFile (pathname ++ filename)
    let contentLines = lines content
    let result = map (parseDetail . processText) contentLines

    print $ sum $ map fst (filter checkBag result)