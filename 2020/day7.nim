import strutils, sequtils, strformat, tables, sets, strscans

type Bags = tuple[n: int, bag: string]
var tbl: Table[string, seq[Bags]]

# var input = "light salmon bags contain 5 dark brown bags, 2 dotted coral bags, 5 mirrored turquoise bags."

proc parseLine(input: string): (string, seq[Bags]) =

    var lefthand, righthand: string
    if not scanf(input, "$+ contain $+.", lefthand, righthand):
        echo "malformed input"
        quit(1)

    var leftBag = lefthand.replace("bags", "").strip
    var rightBagsStrs = righthand
        .replace("bags", "")
        .replace("bag", "")
        .split(',').mapIt(it.strip)

    if rightBagsStrs[0] == "no other":
        return (leftBag, @[])

    var rightBags = rightBagsStrs
        .map do (it: string) -> Bags:
            var n: int; var bag: string
            if not scanf(it, "$i $+$.", n, bag):
                echo "malformed input"
                quit(1)
            (n, bag)

    return (leftBag, rightBags)


var inputLines: seq[string] = readFile("day7.txt").strip.splitLines

for input in inputLines:
    # echo input
    var (leftBag, rightBags) = parseLine(input)
    tbl[leftBag] = rightBags


proc partOne() =

    var bags: HashSet[string]
    var nextBags: HashSet[string] = toHashSet(@["shiny gold"])

    var finalBags: HashSet[string]

    while (nextBags.len != 0):
        echo &"Round: {nextBags}"
        bags = nextBags
        nextBags.clear
        for bag in bags:
            for left, right in tbl.pairs:
                var rightBags = right.mapIt(it.bag)
                if bag in rightBags:
                    nextBags.incl(left)
                    finalBags.incl(left)

    echo "Final Bags"
    echo finalBags
    echo finalBags.len


proc partTwo() =
    proc countInsideBags(bag: string): int =
        result = 1
        for (n, b) in tbl[bag]:
            echo (n, b)
            result += (n * countInsideBags(b))

    echo countInsideBags("shiny gold") - 1

partTwo()
