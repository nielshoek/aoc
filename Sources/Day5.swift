import Foundation

public struct Day5 {
    public func Run() {
        let data = "Inputs/day5.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    struct MappingRange {
        let range: Range<Int>
        let diff: Int
    }

    public func LogicA(input: [String]) -> Int {
        let parts = input.split(separator: "")
        let seeds = getSeeds(line: input[0])
        var mappings = [[MappingRange]]()
        for mappingConfig in parts[1...] {
            let mappingRange = createMappingRanges(lines: mappingConfig)
            mappings.append(mappingRange)
        }

        var minValue = Int.max
        for seed in seeds {
            var currentValue = seed
            for mapping in mappings {
                for mappingRange in mapping {
                    if mappingRange.range.contains(currentValue) {
                        currentValue +=  mappingRange.diff
                        break
                    }
                }
            }
            if currentValue < minValue {
                minValue = currentValue
            }
        }

        return minValue
    }

    public func LogicB(input _: [String]) -> Int {
        return 0
    }

    private func createMappingRanges(lines: ArraySlice<String>) -> [MappingRange] {
        lines.dropFirst().map { line in
            let values = line.components(separatedBy: " ")
            let dest = Int(values[0])!
            let src = Int(values[1])!
            let rangeLength = Int(values[2])!
            let range = src ..< src + rangeLength
            let diff = dest - src
            return MappingRange(range: range, diff: diff)
        }
    }

    private func getSeeds(line: String) -> [Int] {
        line.split(separator: ": ")[1].split(separator: " ").map { Int($0)! }
    }
}
