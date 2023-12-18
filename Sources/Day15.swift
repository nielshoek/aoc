let test = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"
let testB = "rn,cm,qp,cm,qp,pc,ot,ab,pc,pc,ot"

public struct Day15 {
    public func Run() {
        let data = "Inputs/day15.txt".ToString()
        print("Part TEST: \(LogicA(input: test))")
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
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

    public func LogicB(input: String) -> Int {
        var boxesMap = [[(label: String, strength: String)]](repeating: [(label: String, strength: String)](), count: 256)
        let steps = input.components(separatedBy: ",")
        for step in steps {
            let action = step.contains("=") ? "ASSIGN" : "REMOVE"
            let parts = step.components(separatedBy: ["-", "="])
            let label = parts[0]
            let strength = parts[1]
            let labelValue = label.map(Character.init).reduce(into: 0) { acc, cur in
                acc += Int(cur.asciiValue!)
                acc *= 17
                acc %= 256
            }
            var box = boxesMap[Int(labelValue)]
            if action == "ASSIGN" {
                if let i = box.firstIndex(where: { $0.label == label }) {
                    box[i] = (label: label, strength: strength)
                } else {
                    box.append((label: label, strength: strength))
                }
            } else if action == "REMOVE" {
                box.removeAll(where: { $0.label == label })
            }
            boxesMap[Int(labelValue)] = box
        }

        var count = 0
        for (i, boxes) in boxesMap.enumerated() {
            for (j, lens) in boxes.enumerated() {
                count += (i + 1) * (j + 1) * Int(lens.strength)!
            }
        }

        return count
    }
}
