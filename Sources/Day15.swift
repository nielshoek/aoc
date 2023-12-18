let test = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"

public struct Day15 {
    public func Run() {
        let data = "Inputs/day15.txt".ToString()
        print("Part TEST: \(LogicA(input: test))")
        print("Part 1: \(LogicA(input: data))")
        // print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: String) -> Int {
        let steps = input.components(separatedBy: ",")
        return steps.map { cur in
            cur.map(Character.init).reduce(into: 0) { acc, cur in
                acc += Int(cur.asciiValue!)
                acc *= 17
                acc %= 256
            }
        }.reduce(0) { $0 + $1 }
    }

    public func LogicB(input _: String) -> Int {
        0
    }
}
