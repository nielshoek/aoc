import Foundation

public struct Day3 {
    public func Run() {
        let data = "Inputs/day3.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        var count = 0
        let grid = input.AddBorder()
        for (lineNr, line) in grid.enumerated() {
            let ranges = line.ranges(of: #/\d+/#)
            for range in ranges {
                let low = range.lowerBound.distance(in: line) - 1
                let high = range.upperBound.distance(in: line)
                var surroundingFields = ""
                // Add row above and below
                for row in -1 ... 1 {
                    if row != 0 {
                        surroundingFields += grid[lineNr + row].map(Character.init)[low ... high]
                    }
                }

                // Add characters on left and right
                let startIndex = line.index(line.startIndex, offsetBy: low)
                let endIndex = line.index(line.startIndex, offsetBy: high)
                surroundingFields += String(line[startIndex])
                surroundingFields += String(line[endIndex])

                // Check if surrounding fields have a symbol
                let hasSymbol = surroundingFields.filter { $0 != "." }.count > 0
                if hasSymbol {
                    let number = line[range]
                    count += Int(number)!
                }
            }
        }

        return count
    }

    public func LogicB(input: [String]) -> Int {
        var map = [Int: [Int]]()
        let grid = input.AddBorder()
        let rowLength = input[0].count
        for (lineNr, line) in grid.enumerated() {
            let ranges = line.ranges(of: #/\d+/#)
            for range in ranges {
                let low = range.lowerBound.distance(in: line) - 1
                let high = range.upperBound.distance(in: line)
                for row in -1 ... 1 {
                    for (i, char) in grid[lineNr + row]
                        .map(Character.init)[low ... high]
                        .enumerated()
                    {
                        if char == "*" {
                            let absolutePosition = (lineNr + row) * rowLength + low + i
                            let number = line[range]
                            map[absolutePosition] = (map[absolutePosition] ?? []) + [Int(number)!]
                        }
                    }
                }
            }
        }

        let count = map.reduce(0) { acc, kv in
            kv.value.count == 2
                ? acc + kv.value[0] * kv.value[1]
                : acc
        }

        return count
    }
}

extension [String] {
    func AddBorder() -> [String] {
        var result = [String](repeating: String(), count: self.count + 2)
        let topAndBottomRow = String(repeating: ".", count: self[0].count + 2)
        result[0] = topAndBottomRow
        for lineNr in 0 ..< self.count {
            result[lineNr + 1] = "." + self[lineNr] + "."
        }
        result[self.count + 1] = topAndBottomRow

        return result
    }
}
