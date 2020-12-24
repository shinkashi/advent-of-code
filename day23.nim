echo "*** START"

{.experimental: "codeReordering".}
{.warning[UnusedImport]: off.}
import strutils, strformat, sequtils, strscans, sugar, math, tables, algorithm, parseutils, re, sets

const Total = 1_000_000
const Moves = 10_000_000

type Cups = object
    nx: array[1..TOTAL, int] # next number
    cur: int

# var firstCups = @[3,8,9,1,2,5,4,6,7] # test
var firstCups = @[2,1,5,6,9,4,7,8,3]  # real

# prepare cups

proc prepareCups(firstCups: openArray[int]): Cups =
    var prev = firstCups[0]
    for x in firstCups[1..^1]:
        result.nx[prev] = x
        prev = x
    result.nx[prev] = firstCups[0]

    if TOTAL > firstCups.len:
        result.nx[prev] = firstCups.len+1
        for i in firstCups.len+1..TOTAL:
            result.nx[i] = i + 1
        result.nx[TOTAL] = firstCups[0]

    result.cur = firstCups[0]

proc print(c: var Cups): string =
    var n = c.cur
    while true:
        result.add &"{n} "
        n = c.nx[n]
        if n == c.cur: break

var cups = prepareCups(firstCups)

proc move(c: var Cups) =
    var n1 = c.nx[c.cur]
    var n2 = c.nx[n1]
    var n3 = c.nx[n2]

    # echo "pick up: ", [n1, n2, n3]
    c.nx[c.cur] = c.nx[n3]

    var dest = c.cur - 1
    if dest < 1:
        dest = TOTAL
    while dest in [n1, n2, n3]:
        dec dest    
        if dest < 1:
            dest = TOTAL

    # echo "destination: ", dest

    # echo "before insert ", c
    var destNext = c.nx[dest]
    c.nx[dest] = n1
    c.nx[n3] = destNext
    # echo "after insert ", c
    
    c.cur = c.nx[c.cur]    

for i in 1..Moves:
    # echo &"move {i}:  {cups.print}"
    move(cups)

var 
    pos2 = cups.nx[1]
    pos3 = cups.nx[pos2]

echo pos2
echo pos3
echo pos2 * pos3


echo "*** END"
