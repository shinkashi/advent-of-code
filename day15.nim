{.experimental: "codeReordering".}
{.warning[UnusedImport]: off.}

import strutils, strformat, sequtils, strscans, re, sugar, math, tables, algorithm, parseutils

var input = [2,0,1,9,5,19]
#var input = [0, 3, 6]

PartTwo()

proc PartTwo =
    const maxlen = 30000000

    var n: Table[int, int]

    for idx, i in input:
        n[i] = idx + 1

    var last = input[input.len-1]

    for i in (input.len + 1)..maxlen:
        var dist = if n.hasKey(last): (i-1) - n[last] else: 0
        if i mod 100000 == 0:
            echo &"i {i} last {last} pos {n.getOrDefault(last)} dist {dist}"
        n[last] = i-1
        last = dist

proc PartOne = 
    const maxlen = 2020

    var n: array[1..maxlen, int]

    for i, x in input:
        n[i+1] = x


    for i in (input.len + 1)..maxlen:
        var 
            last = n[i-1]
            first = -1
            second = -1

        # echo "i ", i

        for j in countdown(i-1, 1):
            if n[j] == last:
                first = j
                break
                
        if first == -1:
            n[i] = 0
            continue

        # echo "first ", first

        for k in countdown(first-1, 1):
            if n[k] == last:
                second = k
                break

        if second == -1:
            n[i] = 0
            continue

        # echo "second ", second

        n[i] = first - second
        
        if i mod 1000 == 0:
            echo &"n[{i}]={n[i]}"

    echo n[maxlen]
