import Foundation

struct SpringRow {
    let row: String
    let groups: [Int]
}

extension SpringRow {
    var isValid: Bool {
        let regex = try! Regex("[#]+")
        let ranges = row.ranges(of: regex)
        if ranges.count != groups.count {
            return false
        }
        for i in 0 ..< ranges.count {
            let range = ranges[i]
            if row[range].count != groups[groups.count - i - 1] {
                return false
            }
        }
        return true
    }
}

public struct Day12 {
    public func Run() {
        print()
        let data = "Inputs/day12.txt".ToStringArray()
        // print("Part Test: \(LogicA(input: data[..<2].map { String($0) }))")
        print("Part 1: \(LogicA(input: data))")
        // print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        var count = 0
        for line in input {
            count += checkPossibilities(for: line)
        }

        return count
    }

    private func checkPossibilities(for line: String) -> Int {
        let parts = line.split(separator: " ")
        let row = String(parts[0])
        let groups = parseGroups(line: parts[1])
        return helper(SpringRow(row: row, groups: groups), groups, 0)
    }

    private func helper(_ springRow: SpringRow, _ groups: [Int], _ lower: Int) -> Int {
        var result = 0
        if groups.isEmpty {
            return springRow.isValid
                ? 1
                : 0
        }

        var groups = groups
        let originalRow = springRow.row
        var rowForRegex = springRow.row
        var chars = [Character](rowForRegex)
        for i in 0 ..< lower {
            chars[i] = "_"
        }
        rowForRegex = String(chars)
        let len = groups.removeLast()
        let regex = try! Regex("[?#]{\(len)}")
        var ranges = [Range<Int>]()
        while let regexMatch = rowForRegex.firstMatch(of: regex) {
            let low = regexMatch.range.lowerBound.distance(in: rowForRegex)
            let high = regexMatch.range.upperBound.distance(in: rowForRegex)
            ranges.append(low ..< high)
            var chars = [Character](rowForRegex)
            chars[low] = "_"
            rowForRegex = String(chars)
        }

        for range in ranges {
            var chars = [Character](originalRow)
            for i in range {
                chars[i] = "#"
            }
            var leftChar = Character(".")
            if range.lowerBound > 0 {
                leftChar = chars[range.lowerBound - 1]
            }
            var rightChar = Character(".")
            if range.upperBound + 1 < chars.count {
                rightChar = chars[range.upperBound]
            }
            if leftChar != "#", rightChar != "#" {
                // Valid
                result += helper(SpringRow(row: String(chars), groups: springRow.groups),
                                 groups,
                                 range.upperBound)
            }
        }

        return result
    }

    public func LogicB(input _: [String]) -> Int {
        0
    }

    private func parseGroups(line: String.SubSequence) -> [Int] {
        line.split(separator: ",").reversed().map { Int($0)! }
    }
}
