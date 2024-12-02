import Foundation

public struct Day8 {
    public func Run() {
        let data = "Inputs/day8.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        let instrString = input[0]
        let mappings = input.dropFirst(2)
            .reduce(into: [String: (L: String, R: String)]()) { acc, cur in
                let parts = cur.components(separatedBy: " ")
                let key = parts[0]
                let l = String(parts[2].dropFirst().dropLast())
                let r = String(parts[3].dropLast())
                acc[key] = (L: l, R: r)
            }

        var cur = "AAA"
        var count = 0
        outer: while true {
            for char in instrString {
                let mapping = mappings[cur]
                if char == "L" {
                    cur = mapping!.L
                } else if char == "R" {
                    cur = mapping!.R
                }
                count += 1

                if cur == "ZZZ" {
                    break outer
                }
            }
        }

        return count
    }

    public func LogicB(input: [String]) -> Int {
        let instrString = input[0]
        let mappings = input.dropFirst(2)
            .reduce(into: [String: (L: String, R: String)]()) { acc, cur in
                let parts = cur.components(separatedBy: " ")
                let key = parts[0]
                let l = String(parts[2].dropFirst().dropLast())
                let r = String(parts[3].dropLast())
                acc[key] = (L: l, R: r)
            }

        var curKeys = mappings.keys.filter { k in k.last! == "A" }.map { String($0) }
        var count = 0
        var stepsForEachKey = [Int]()
        outer: while true {
            for char in instrString {
                count += 1
                var toRemove = -1
                for (i, key) in curKeys.enumerated() {
                    if char == "L" {
                        let mapping = mappings[key]
                        curKeys[i] = mapping!.L
                    } else if char == "R" {
                        let mapping = mappings[key]
                        curKeys[i] = mapping!.R
                    }
                    if curKeys[i].last! == "Z" {
                        stepsForEachKey.append(count)
                        toRemove = i
                    }
                }

                if toRemove != -1 {
                    curKeys.remove(at: toRemove)
                    toRemove = -1
                }

                if curKeys.count == 0 {
                    break outer
                }
            }
        }

        let highest = stepsForEachKey.sorted().first!
        for val in stride(from: highest, through: Int.max, by: highest) {
            if stepsForEachKey
                .filter({ steps in val % steps == 0 }).count == stepsForEachKey.count
            {
                return val
            }
        }

        return count
    }
}
