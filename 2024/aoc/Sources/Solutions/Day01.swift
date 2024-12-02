class Day01 {
    func A() -> Int {
        let arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day01.txt")
            .map {
                let parts = $0.components(separatedBy: "   ").compactMap { Int($0) }
                return (left: parts[0], right: parts[1])
            }
        var arr1 = [Int]()
        var arr2 = [Int]()
        for (left, right) in arr {
            arr1.append(left)
            arr2.append(right)
        }

        return zip(arr1.sorted(), arr2.sorted()).reduce(0) { acc, cur in
            acc + abs(cur.0 - cur.1)
        }
    }

    func B() -> Int {
        var occurrences = [Int: Int]()
        let arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day01.txt")
            .map {
                let parts = $0.components(separatedBy: "   ").compactMap { Int($0) }
                occurrences[parts[1], default: 0] += 1
                return parts[0]
            }
            
        return arr.reduce(0) { acc, cur in
            let nrOfTimesOccurring = occurrences[cur, default: 0]
            return acc + (cur * nrOfTimesOccurring)
        }
    }
}