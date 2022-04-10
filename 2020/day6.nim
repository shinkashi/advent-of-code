import strutils, sequtils, strformat, tables, sugar, sets, strscans, regex, math

var groups: seq[string] = readFile("day6.input").strip.split("\n\n")

# Part one

# var groupsAllAnswers = mapIt(replace(it, "\n",""))
# echo groupsAllAnswers.mapIt(toSeq(it).toHashSet.len).sum

# Part two

#[ 
var groups = """
abc

a
b
c

ab
ac

a
a
a
a

b

""".strip.split("\n\n")
]#

var groupIndiviuals = groups.mapIt(splitWhitespace(it))

echo groupIndiviuals.map(group => 
    group.map(card => toSeq(card).toHashSet)
        .foldl(a * b)
        .len
).sum
