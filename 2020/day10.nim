import sequtils, algorithm, strformat, strutils, sets, tables


#[
    patterns[i] = how many patterns to get i jolts

    patterns[0] = 1
    
    patterns[i] =   patterns[i-3] (if adapters[i-3] is available)
                  + patterns[i-2] (if adapters[i-2] is available)
                  + patterns[i-1] (if adapters[i-1] is available)


]#

proc PartTwo(adapters: set[int16]) =

    echo "adapters ", adapters

    var goal: int16 = adapters.toSeq.max
    echo "goal ", goal

    var patterns: seq[int] = newSeq[int](goal+1)

    patterns[0] = 1
    
    for i in int16(1)..goal:
        echo "checking ",i
        if i in adapters:
            var p: int
            if i >= 3: p += patterns[i-3]
            if i >= 2: p += patterns[i-2]
            if i >= 1: p += patterns[i-1]
            echo "  found ", p
            patterns[i] = p


    echo patterns


proc useAllAdapters(adapters: set[int16], goal: int): int =

    type Round = object
        adapters: set[int16]
        jolts: int16
        # d1: int
        # d3: int

    # var
        # rounds: seq[Round] = @[Round(adapters: adapters, jolts: 0)]
        # arrangements: int = 0

    var memo: Table[set[int16], Table[int16, int]]

    proc helper(r: Round): int =
        if memo.hasKey(r.adapters):
            if memo[r.adapters].hasKey(r.jolts):
                return memo[r.adapters][r.jolts]

        if r.jolts > goal - 3:
            return 0

        if r.jolts == goal - 3:
            return 1

        for c in r.jolts+1..r.jolts+3:
            if c notin r.adapters: continue

            # var
            #     d1 = r.d1
            #     d3 = r.d3

            # case c - r.jolts:
            #     of 1: inc d1
            #     of 3: inc d3
            #     else: discard

            var newRound: Round = Round(
                adapters: r.adapters - {c},
                jolts: c,
                # d1: d1,
                    # d3: d3
            )

            result += helper(newRound)

        return result

    return helper(Round(adapters: adapters, jolts: 0))

var input1 = """
16
10
15
5
1
11
7
19
6
12
4
"""



var input2 = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""

#var data: seq[int16] = input1.strip.splitLines.mapIt(int16(parseInt(it)))
#var data: seq[int16] = input2.strip.splitLines.mapIt(int16(parseInt(it)))
var data: seq[int16] = readFile("day10.input").strip.splitLines.mapIt(int16(parseInt(it)))
var dataSet: set[int16]
for i in data:
    dataSet.incl(i)

# echo useAllAdapters(dataSet, data.max + 3)

PartTwo(dataSet)


echo "end"
