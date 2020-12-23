echo "*** START"

{.experimental: "codeReordering".}
{.warning[UnusedImport]: off.}
import strutils, strformat, sequtils, strscans, sugar, math, tables, algorithm, parseutils, re, sets
import hashes

#const input = inputTest
const input = inputReal

const blocks = input.strip.split("\n\n").mapIt(it.splitLines).mapIt(it[1..^1].map(parseInt))

var (player1, player2) = (blocks[0], blocks[1])

type Player = enum Player1, Player2

PartTwo()

proc PartTwo =
    
    proc play(player1, player2: var seq[int], game = 1): Player =
        var p1hist, p2hist: HashSet[seq[int]]
        var round = 1;

        while (player1.len > 0 and player2.len > 0):
            var winner: Player

            echo &"G{game} R{round} P1 {player1.len} P2 {player2.len}"
            inc round

            if player1 in p1hist or player2 in p2hist:
                return Player1

            p1hist.incl(player1)
            p2hist.incl(player2)

            var t1 = player1[0]
            var t2 = player2[0]

            player1.delete(0)
            player2.delete(0)

            if (player1.len >= t1 and player2.len >= t2):
                var p1 = player1[0..<t1]
                var p2 = player2[0..<t2]
                winner = play(p1, p2, game + 1)
            else:
                winner = if t1 > t2: Player1 else: Player2

            case winner:
                of Player1: 
                    player1.add(t1)
                    player1.add(t2)
                of Player2:
                    player2.add(t2)
                    player2.add(t1)

        return if player1.len > 0: Player1 else: Player2

    var winnerPlayer = play(player1, player2)
    echo "winner ", winnerPlayer

    var winnerCards = case winnerPlayer:
        of Player1: player1
        of Player2: player2

    echo winnerCards

    var pt = 0
    for i, x in winnerCards:
        pt += (winnerCards.len-i) * winnerCards[i]

    echo "points: ", pt

proc PartOne =
    while (player1.len > 0 and player2.len > 0):
        var t1 = player1[0]
        var t2 = player2[0]

        player1.delete(0)
        player2.delete(0)

        if t1 > t2:
            player1.add(t1)
            player1.add(t2)
        elif t1 < t2:
            player2.add(t2)
            player2.add(t1)
        else:
            raiseAssert("draw..")

    var winner = if player1.len > 0: player1 else: player2

    echo winner

    var pt = 0
    for i, x in winner:
        pt += (winner.len-i) * winner[i]

    echo "points: ", pt


const inputTest = """
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10
"""

const inputReal = """
Player 1:
18
19
16
11
47
38
6
27
9
22
15
42
3
4
21
41
14
8
23
30
40
13
35
46
50

Player 2:
39
1
29
20
45
43
12
2
37
33
49
32
10
26
36
17
34
44
25
28
24
5
48
31
7
"""
