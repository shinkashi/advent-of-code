import strutils, sequtils, strformat, tables, sugar, sets, strscans, regex

# var passports: seq[Table]

proc toTuple(s: string): (string, string) =
    var a = s.split(':')
    return (a[0], a[1])


var passports = readFile("day4.input").split("\n\n").mapIt(
    it.splitWhitespace.toSeq.map(toTuple).toTable
)


proc check(passport: Table[string, string]): bool =
    const necessaryFields = toHashSet([
        "byr",
        "iyr",
        "eyr",
        "hgt",
        "hcl",
        "ecl",
        "pid"
    ])

    result = false

    let passportFields = toSeq(passport.keys).toHashSet
    if not (necessaryFields <= passportFields and
        contains(1920..2002, passport["byr"].parseInt) and
        contains(2010..2020, passport["iyr"].parseInt) and
        contains(2020..2030, passport["eyr"].parseInt)
    ): return 
    
    var 
        heightLen: int
        heightUnit: string

    if not scanf(passport["hgt"], "$i$w$.", heightLen, heightUnit): return 
    case heightUnit:
        of "cm":
            if not contains(150..193, heightLen): return
        of "in":
            if not contains(59..76, heightLen): return
        else: return

    if not passport["hcl"].match(re"^#[0-9a-f]{6}$"): return

    if not ["amb", "blu" ,"brn", "gry", "grn", "hzl", "oth"].contains(passport["ecl"]): return

    if not passport["pid"].match(re"^[0-9]{9}$"): return
    

    return true
        


echo passports.countIt(check(it))
