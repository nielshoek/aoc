import Foundation

public struct Day4 {
    public func Run() {
        let data = "Inputs/day4.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        var count = 0
        for line in input {
            let splitString = line.components(separatedBy: " | ")
            let myNumbers = splitString[0]
                .components(separatedBy: ": ")[1]
                .split(separator: #/\s/#)
            let winningNumbers = splitString[1].split(separator: #/\s/#)
            let matchCount = myNumbers.reduce(0) { acc, val in
                acc + (winningNumbers.contains(val) ? 1 : 0)
            }
            count += 1 << (matchCount - 1)
        }

        return count
    }

    public func LogicB(input _: [String]) -> Int {
        var count = 0
        return count
    }
}
