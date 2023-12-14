import Foundation

struct SpringRow {
    let original: String
    var row: String
    let groups: [Int]

    init(row: String, groups: [Int]) {
        original = row
        self.row = row
        self.groups = groups
    }
}

extension SpringRow {
    var isValid: Bool {
        let regex = try! Regex("[#]+")
        let ranges = original.ranges(of: regex)
        if ranges.count != groups.count {
            return false
        }
        for i in 0 ..< ranges.count {
            let range = ranges[i]
            if original[range].count != groups.reversed()[i] {
                return false
            }
        }
        return true
    }
}

let test12 = [
    "??????.??#. 2,3",
    "??.?###????????? 2,4,4",
    "?????????.??##? 1,2,1,1,5",
]

public struct Day12 {
    public func Run() {
        print()
        let data = "Inputs/day12.txt".ToStringArray()
        // print("Part 1: \(LogicA(input: data))")
        // print("Part 1 Test: \(LogicA(input: test12))")
        // print()
        // print("Part 2 Test: \(LogicB(input: test12))")
        print("Part 2: \(LogicB(input: data)))")
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

        let newRow = springRow.row
        let rgx = try! Regex("[#]+")
        let rngs = newRow.ranges(of: rgx)
        if rngs.count > springRow.groups.count {
            return 0
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
            var leftChar = Character(".")
            if range.lowerBound > 0 {
                leftChar = chars[range.lowerBound - 1]
            }
            var rightChar = Character(".")
            if range.upperBound + 1 < chars.count {
                rightChar = chars[range.upperBound]
            }
            if leftChar != "#", rightChar != "#" {
                for i in range {
                    chars[i] = "#"
                }

                result += helper(SpringRow(row: String(chars), groups: springRow.groups),
                                 groups,
                                 range.upperBound)
            }
        }

        return result
    }

    public func LogicB(input: [String]) -> Int {
        var count = 0
        for (_, line) in input.enumerated() {
            count += checkPossibilities2(for: line)
        }

        return count
    }

    private func checkPossibilities2(for line: String) -> Int {
        let parts = line.split(separator: " ")
        let row = String(parts[0])
        let groups = parseGroups(line: parts[1])
        return helper2(SpringRow(row: row, groups: groups), groups)
    }

    private func helper2(_ springRow: SpringRow, _ groups: [Int]) -> Int {
        var result = 0
        if groups.isEmpty {
            if springRow.row.filter({ $0 == "#" }).isEmpty {
                return 1
            }
            return 0
        }

        // 1. Calculate length of other groups
        // 2. Determine range of possible positions
        // 3. Loop over range and check for each position if possible
        // 4. If possible -> 1. Cut of part where placed
        //                   2. Call helper with leftover and less groups
        //                   3. Check leftover / groups

        var groups = groups
        let originalRow = springRow.row
        let len = groups.removeLast()

        let indexOfLowestNumberSign = originalRow
            .firstIndex(of: "#")?
            .distance(in: originalRow) ?? Int.max
        let minLenForOtherGroups = groups.reduce(0) { acc, cur in acc + cur + 1 }
        let indexBasedOnLengthOfOthers = originalRow.count - (minLenForOtherGroups + len)
        let minLowestIndex = min(indexOfLowestNumberSign, indexBasedOnLengthOfOthers)
        let endIndex = minLowestIndex + len
        var rowForRegex = springRow.row.dropLast(springRow.row.count - endIndex)

        let regex = try! Regex("[?#]{\(len)}")
        var ranges = [Range<Int>]()
        while let regexMatch = rowForRegex.firstMatch(of: regex) {
            let low = regexMatch.range.lowerBound.distance(in: rowForRegex)
            let high = regexMatch.range.upperBound.distance(in: rowForRegex)
            ranges.append(low ..< high)
            var chars = [Character](rowForRegex)
            chars[low] = "_"
            rowForRegex = String.SubSequence(chars)
        }

        for range in ranges {
            let chars = [Character](originalRow)
            let rightNeighbor = range.upperBound < chars.count
                ? chars[range.upperBound]
                : Character(".")
            let leftNeighbor = range.lowerBound > 0
                ? chars[range.lowerBound - 1]
                : Character(".")
            if leftNeighbor != "#" && rightNeighbor != "#" {
                var springRow = springRow
                if (range.upperBound) < chars.count {
                    springRow.row = String(chars[(range.upperBound + 1)...])
                    result += helper2(springRow, groups)
                } else if range.upperBound == chars.count && groups.isEmpty {
                    result += 1
                }
            }
        }

        return result
    }

    private func parseGroups(line: String.SubSequence) -> [Int] {
        line.split(separator: ",").reversed().map { Int($0)! }
    }
}

private extension String {
    var timesFive: String {
        let left = components(separatedBy: " ")[0]
        var newLeft = left
        let right = components(separatedBy: " ")[1]
        var newRight = right
        for _ in 0 ..< 4 {
            newLeft += "?" + left
            newRight += "," + right
        }
        return newLeft + " " + newRight
    }
}
