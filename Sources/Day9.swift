import Foundation

public struct Day9 {
    public func Run() {
        let data = "Inputs/day9.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        var count = 0
        let ints = parse(input: input)
        for range in ints {
            var seq = range
            var last = [Int]()
            while seq.filter({ $0 != 0 }).count != 0 {
                var next = [Int]()
                last.append(seq.last!)
                for i in 0..<seq.count-1 {
                    next.append(seq[i+1]-seq[i])
                }
                seq = next
            }
            let nextValue = last.reduce(0) { acc, cur in acc+cur }
            count += nextValue
        }

        return count
    }

    public func LogicB(input: [String]) -> Int {
        0
    }

    private func parse(input: [String]) -> [[Int]] {
        var result = [[Int]]()
        for line in input {
            result.append(line.split(separator: " ").map { Int($0)! })
        }

        return result
    }
}
