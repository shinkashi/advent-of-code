import sequtils, strutils, sets, strformat, strscans

block: 

    echo "Part 1"
    var found = 0;


    for ln in readFile("day2.input").splitLines:
        var lo, hi:int
        var password: string
        var _: string
        var ch: string
        if scanf(ln, "$i-$i $w: $w$.", lo, hi, ch, password):
            var cnt = password.count(ch)
            if lo <= cnt and cnt <= hi:
                found += 1

    echo found

block: 

    echo "Part 2"

    var found = 0

    for ln in readFile("day2.input").splitLines:
        var lo, hi:int
        var password: string
        var _: string
        var ch: string
        if scanf(ln, "$i-$i $w: $w$.", lo, hi, ch, password):
            var chara = ch[0]
            if (
                (password[lo-1] == chara and password[hi-1] != chara) or
                (password[lo-1] != chara and password[hi-1] == chara)
            ):
                found += 1

    echo found
