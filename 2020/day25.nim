{.experimental: "codeReordering".}
{.warning[UnusedImport]: off.}

import strutils, strformat, sequtils, strscans, re, sugar, math, tables, algorithm, parseutils, sets

#var input = [5764801, 17807724]  # test
var input = [12092626, 4707356]  # real

var 
    cardPK = input[0]
    doorPK = input[1]


proc trans(sn: int, v: var int) = 
    v = v * sn mod 20201227

proc transform(sn, loop: int): int {.discardable.} =
    result = 1
    for i in 1..loop:
        trans(sn, result)

echo "START"

# Find card loop

proc findLoop(pk: int): int = 
    var 
        i = 0
        v = 1

    while v != pk:
        inc i
        trans(7, v)
        # echo &"{i=} {v=}"

    return i

var cardLoop = findLoop(cardPK)
dump cardLoop

var doorLoop = findLoop(doorPK)
dump doorLoop

dump transform(doorPK, cardLoop)
dump transform(cardPK, doorLoop)

echo "END"
