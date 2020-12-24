echo "*** START"

{.experimental: "codeReordering".}
{.warning[UnusedImport]: off.}
import strutils, strformat, sequtils, strscans, sugar, math, tables, algorithm, parseutils, re, sets

type Cups = object
    pre: seq[int]
    lo: int
    hi: int
    post: seq[int]
    total: int

proc newCups(pre: seq[int], total: int): Cups =
    result.pre = pre
    result.lo = 10
    result.hi = total
    result.total = total

proc postLoc(c: var Cups): int =
    if c.lo <= c.hi:
        c.pre.len + (c.hi-c.lo+1)
    else:
        c.pre.len

proc shift(c: var Cups): int =
    if c.pre.len > 0:
        result = c.pre[0]
        c.pre.delete(0)
        return

    if c.lo <= c.hi:
        result = c.lo
        inc c.lo
        if c.lo <= c.hi:
            return

        echo "brick fully consumed"
        c.lo = 0
        c.hi = -1

    result = c.post[0]
    c.post.delete(0)
    return

proc find(c: var Cups, v: int): int =
    if v in c.lo..c.hi:
        result = c.pre.len + (v - c.lo)
    else:
        result = c.pre.find(v)
        if result == -1:
            result = c.post.find(v)
            if result != -1:
                result += c.postLoc()

proc insert(c: var Cups, v: int, pos: int) =
    # echo &"  inserting {v} at pos {pos}"
    if c.postLoc() <= pos:
        c.post.insert(v, pos - c.postLoc())
    elif pos <= c.pre.len:
        c.pre.insert(v, pos)
    else:
        echo "really? inserting in the middle of brick?"
        quit()

proc add(c: var Cups, v: int) =
    c.post.add(v)

var cups = newCups(@[3,8,9,1,2,5,4,6,7], 1_000_000) # test
#var cups = @[2,1,5,6,9,4,7,8,3]  # real


proc PartTwo =

    proc move(cups: var Cups) =
        var cur = cups.shift

        var (n1, n2, n3) = (cups.shift, cups.shift, cups.shift)
        # echo &"took {n1} {n2} {n3}"

        var dest = cur - 1
        var destPos: int

        while true:
            # echo "  finding ", dest
            destPos = cups.find(dest)
            if destPos != -1: break
            if dest <= 1:
                dest = cups.total
            else:
                dec dest 

        # echo &"  found at pos {destPos}"

        cups.insert(n3, destPos + 1)
        cups.insert(n2, destPos + 1)
        cups.insert(n1, destPos + 1)

        cups.add(cur)

    echo cups
    for i in 1..10000:
        move(cups)

    echo cups

const total = 1000

type CupsArray = array[total, int]

proc createCupsArray(c: var seq[int]): CupsArray =
    for i, x in c:
        result[i] = x

proc PartOne =
    var cups = @[3,8,9,1,2,5,4,6,7] # test
    # var cups = @[2,1,5,6,9,4,7,8,3]  # real

    cups.add((10..total).toSeq)
    proc shift(a: var seq[int]): int =
        result = a[0]
        a.delete(0)

    proc move(cups: var seq[int]) =
        var cur = cups.shift

        var (n1, n2, n3) = (cups.shift, cups.shift, cups.shift)

        var dest = cur - 1
        var destPos: int

        while true:
            # echo "  checking ", dest
            destPos = cups.find(dest)
            if destPos != -1: break
            if dest <= 1:
                dest = total
            else:
                dec dest 

        cups.insert(@[n1, n2, n3], destPos + 1)

        cups.add(cur)

    var prevMsg: string

    var rec: CountTable[CupsArray]

    for i in 1..10000:
        move(cups)
        var 
            pos = cups.find(1)
            pos2 = (pos + 1) mod total
            pos3 = (pos + 2) mod total

        var msg = &"[ {cups[pos]}, {cups[pos2]}, {cups[pos3]} ]"

        rec.inc(createCupsArray(cups))

        if prevMsg != msg:
            echo &"{i}: at {pos} > " & msg

        prevMsg = msg

    # var pos1 = cups.find(1)
    # for i in 1..8:
    #     stdout.write cups[(pos1 + i) mod cups.len]
    # echo ""

    # echo cups
    
    echo rec




PartOne()
# PartTwo()

echo "*** END"
