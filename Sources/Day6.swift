import Foundation

public struct Day6 {
    public func Run() {
        let data = "Inputs/day6.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        let times = input[0]
            .split(separator: ":")[1]
            .split(separator: #/\s/#)
            .map { Int($0)! }
        let records = input[1]
            .split(separator: ":")[1]
            .split(separator: #/\s/#)
            .map { Int($0)! }

        var waysToBeat = [Int]()
        for (i, maxTime) in times.enumerated() {
            var ways = 0
            for s in 0 ... maxTime {
                let record = records[i]
                let speed = s
                let time = maxTime - speed
                if speed * time > record {
                    ways += 1
                }
            }
            waysToBeat.append(ways)
        }

        return waysToBeat
            .dropFirst()
            .reduce(waysToBeat[0]) { acc, val in val * acc }
    }

    public func LogicB(input: [String]) -> Int {
        let time = parse(line: input[0])
        let record = parse(line: input[1])
        var ways = 0
        for speed in 0 ... time {
            let time = time - speed
            if speed * time > record {
                ways += 1
            }
        }

        return ways
    }

    private func parse(line: String) -> Int {
        Int(line.split(separator: ":")[1]
            .split(separator: #/\s/#)
            .joined())!
    }
}
