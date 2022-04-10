{.warning[UnusedImport]: off.}

import strutils, strformat, strscans, options, sugar, sequtils

var nums: seq[int] = readFile("day9.input").strip.splitWhitespace.map(parseInt)

# var numsSample = [
# 35,
# 20,
# 15,
# 25,
# 47,
# 40,
# 62,
# 55,
# 65,
# 95,
# 102,
# 117,
# 150,
# 182,
# 127,
# 219,
# 299,
# 277,
# 309,
# 576
# ]


proc findMagic(nums: openArray[int], preamble: int): int =
    for i in preamble..<nums.len:
        block round:
            for j in (i-preamble)..<i:
                for k in j..<i:
                    if nums[j]+nums[k] == nums[i]:
                        break round
            echo &"not matching {nums[i]}"
            return nums[i]

proc PartOne =
    discard findMagic(nums, 25)

proc PartTwo =
    var magic = findMagic(nums, 25)

    var a, b: int
    var sum = nums[0]

    while true:
        echo (a: a, b: b, sum: sum)

        if sum == magic:
            echo "found!"
            debugEcho(nums[a..b])
            debugEcho(nums[a..b].max() + nums[a..b].min())
            break

        if sum < magic:
            b += 1
            sum += nums[b]

        else:
            sum -= nums[a]
            a += 1

PartTwo()
