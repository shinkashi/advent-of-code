{.experimental: "codeReordering".}
{.warning[UnusedImport]: off.}

import strutils, strformat, sequtils, strscans, re, sugar, math, tables, algorithm


var inputStr = input

var lines = inputStr.strip.splitLines

proc PartOne =
    var t = lines[0].parseInt
    var buses = lines[1].split(',').filterIt(it != "x").map(parseInt)
    echo t
    echo buses

    var timetable =  buses.mapIt((waiting: it - (t mod it), bus: it))
    echo timetable
    echo timetable.min
    echo timetable.min.bus * timetable.min.waiting


proc PartTwo =
    var buses: Table[int, int] # id -> idx(delay)
    var busIDs: seq[int]
    var busMods: seq[int]

    for i, x in lines[1].split(",").pairs():
        if x != "x":
            buses[parseInt(x)] = i
            busIDs.add(parseInt(x))
            busMods.add(i)


    echo "buses ", buses
    
    var r, p, q: int64

    r = chineseRemainderR(
        busIDs,
        busMods,
    )
    echo busIDs.foldl(a*b) - r


#[     (r, p) = ChineseReminder(0, 17, 2, 13)
    echo (r,p)

    (r, p) = ChineseReminder(r, p, 3, 19)
    echo (r,p)
 ]#
#[ proc extGcd(a, b: int64, p, q: var int64): int64 = 
    var p, q, d: int64
    if b == 0:
        p = 1
        q = 0
        return a
    d = extGcd(b, a mod b, q, p)
    q -= (a div b * p)
    return d





proc ChineseReminder(b1, m1, b2, m2: int64): (int64, int64) =

    proc modMinus(a, m: int64): int64 = ((a mod m) + m) mod m

    var p, q, d, m, tmp, r: int64
    d = extGcd(m1, m2, p, q)
    if (b2 - b1) mod d != 0:
        return (int64(0), int64(-1))
    m = m1 * (m2 div d)
    #m = lcm(m1, m2)
    tmp = (b2 - b1) div d * p mod (m2 div d)
    r = modMinus(b1 + m1 * tmp, m)
    return (r, m)

 ]#
#[ proc BruteForce =
    var loc: Table[int, int] # id -> loc
    for busID in buses.keys:
        loc[busID] = 0

    var t = 0
    # find lowest bus

    proc checkBusesAreAligned(t: int): bool =
        var s = collect(newSeq, for p in loc.pairs: p)
        return s.allIt(it[1] - buses[it[0]] == t)

    while not checkBusesAreAligned(t):
        # echo "t ", t,  "loc ", loc    
        var minBus: int
        (t, minBus) = collect(newSeq, for p in loc.pairs: (p[1],p[0])).min()
        # echo "lowest bus ", minBus
        loc[minBus] += minBus
        (t, minBus) = collect(newSeq, for p in loc.pairs: (p[1],p[0])).min()

    echo t
 ]#    

# From Rosetta code

proc mulInv(a0, b0: int): int =
  var (a, b, x0) = (a0, b0, 0)
  result = 1
  if b == 1: return
  while a > 1:
    let q = a div b
    a = a mod b
    swap a, b
    result = result - q * x0
    swap x0, result
  if result < 0: result += b0
 
proc chineseRemainderR[T](n, a: T): int =
  var prod = 1
  var sum = 0
  for x in n: prod *= x
 
  for i in 0..<n.len:
    let p = prod div n[i]
    sum += a[i] * mulInv(p, n[i]) * p
 
  sum mod prod



proc lcmPlus(a: int, b: int, bi: int): int =
    var ax, bx: int;
    while (ax != bx + bi):
        # echo &"{ax}, {bx}"
        if ax < bx + bi:
            ax += a
            # ax = ((bx-bi-1) div a) * a + a
        else:
            bx += b
            # bx = ((ax-1) div b) * b
            # while bx - bi < ax:
            #     bx += b

    return ax


echo "=".repeat(40)

PartTwo()

echo "=".repeat(40)
echo "end"


const input0 = """
939
7,13,x,x,59,x,31,19
"""

const input = """
1003681
23,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,431,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,19,x,x,x,x,x,x,x,x,x,x,x,409,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29
"""
