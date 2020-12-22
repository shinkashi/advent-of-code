import sequtils, strutils, sets, strformat
var input = readFile("day1.input").splitWhitespace.map(parseInt)

var s: HashSet[int] = input.toHashSet()

for i in 0..input.high:
    var ni = 2020 - input[i]
    for j in i + 1..input.high:
        var nj = ni - input[j]
        if nj in s:
            echo &"{input[i]} * {nj} * {input[j]} = {input[i]*nj*input[j]}"
            quit()

