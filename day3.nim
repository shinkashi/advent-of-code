import strutils, sequtils, strformat

var field: seq[seq[char]]

for ln in readFile("aoc-rust/src/input.txt").splitWhitespace:
    field.add(toSeq(ln.items))

proc countTrees(dx, dy: int): int =
    var
        x = 0
        y = 0
    while true:
        echo &"{y},{x}"
        if field[y][x] == '#': result += 1
        if y == field.len-1: break
        x += dx
        y += dy
        x = x mod (field[y].len)


echo (
    countTrees(1, 1) *
    countTrees(3, 1) *
    countTrees(5, 1) *
    countTrees(7, 1) *
    countTrees(1, 2)
)
