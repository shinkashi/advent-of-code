import strutils, strformat, strscans, options

var inputLines: seq[string] = readFile("day8.input").strip.splitLines

proc execute(program: seq[string]): Option[int] =
    var 
        pc = 0
        acc = 0
        op: string
        arg: int
        executed = newSeq[bool](program.len)

    while pc < program.len:

        if not scanf(program[pc], "$w $i$.", op, arg):
            echo "malformed input"
            return

        # echo &"{pc}: {op} {arg:+} (acc {acc})"

        if executed[pc]:
            echo "already executed"
            return

        executed[pc] = true

        case op:
            of "jmp":
                pc += arg
                continue
            of "acc":
                acc += arg
            of "nop":
                discard
            else:
                echo "unkonwn instruction"
                return

        pc += 1 

    echo "completed successfully: ", acc
    return some(acc)


proc partOne = 
    discard execute(inputLines)


proc partTwo = 
    for i, ln in inputLines:
        echo &"checking {i}"
        if ln.startsWith("jmp"):
            inputLines[i] = ln.replace("jmp", "nop")
            var res =  execute(inputLines)
            if res.isSome: return
        elif ln.startsWith("nop"):
            inputLines[i] = ln.replace("nop", "jmp")
            var res =  execute(inputLines)
            if res.isSome: return                            
        inputLines[i] = ln

partTwo()
