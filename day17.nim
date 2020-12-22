{.experimental: "codeReordering".}
{.warning[UnusedImport]: off.}

import strutils, strformat, sequtils, strscans, re, sugar, math, tables, algorithm, parseutils


const input = inputReal

const maxRound = 7

const sz = input.strip.splitLines.len

type Cube = 
    array[-maxRound..maxRound + sz, 
        array[-maxRound..maxRound + sz, 
            array[-maxRound..maxRound + sz, 
                array[-maxRound..maxRound + sz, char]]]]

var cube: Cube

var lines: seq[string] = input.strip.splitLines

for y, ln in lines:
    for x, ch in ln:
        cube[0][0][y][x] = ch

proc echo(c: Cube) =
    for w in c.low..c.high:
        for z in c.low..c.high:
            echo &"w={w}, z={z}"
            for y in c[0].low..c[0].high:
                if not c[w][z][y].anyIt(it == '#'): continue
                for x in c[0][0][0].low..c[0][0][0].high:
                    stdout.write c[w][z][y][x]
                stdout.write "\n"
            stdout.write "\n"



proc cycle(c: Cube): Cube =
    var nc = c

    for w in c.low..c.high:
        for z in c.low..c.high:
            for y in c[0].low..c[0].high:
                for x in c[0][0].low..c[0][0].high:
                    var adj = countAdjacent(c, w, z, y, x)

                    var nch: char
                    nch = case c[w][z][y][x]:
                        of '#':
                            if adj in 2..3: '#' else: '.'
                        else:
                            if adj == 3: '#' else: '.'

                    nc[w][z][y][x] = nch

    return nc

proc countAdjacent(c: Cube, w, z, y, x: int): int =
    for dw in -1..1:
        if w+dw notin c.low..c.high: continue            
        for dz in -1..1:
            if z+dz notin c.low..c.high: continue            
            for dy in -1..1:
                if y+dy notin c[0].low..c[0].high: continue
                for dx in -1..1:
                    if x+dx notin c[0][0].low..c[0][0].high: continue
                    if (dw or dx or dy or dz) == 0: continue
                    if c[w+dw][z+dz][y+dy][x+dx] == '#': result += 1

proc countActive(c: Cube): int =
    for w in c.low..c.high:
        for z in c.low..c.high:
            for y in c[0].low..c[0].high:
                for x in c[0][0].low..c[0][0].high:
                    if c[w][z][y][x] == '#': result += 1

proc PartOne =

    echo cube

    for i in 1..6:
        cube = cube.cycle
        # echo cube

    echo "active ", cube.countActive


PartOne()


const inputTest = """
.#.
..#
###
"""

const inputReal = """
.###.###
.#.#...#
..##.#..
..##..##
........
##.#.#.#
..###...
.####...
"""
