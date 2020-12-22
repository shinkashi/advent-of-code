import sequtils, strutils, sets

var boardingPasses = readFile("day5.input").splitWhitespace.toSeq

proc getSeatID(code: string): int =
    var s: string
    s = code.replace('B', '1')
    s = s.replace('F', '0')
    s = s.replace('R', '1')
    s = s.replace('L', '0')
    return parseBinInt(s)

var occupiedSeats = boardingPasses.map(getSeatID).toHashSet

var allSeats = toHashSet((0..<1024).toSeq)

var possibleSeats = allSeats - occupiedSeats

for seat in possibleSeats:
    if seat + 1 in occupiedSeats and seat - 1 in occupiedSeats:
        echo seat


