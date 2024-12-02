import Foundation

class Day02 {
    func A() -> Int {
        let arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day02.txt")
            .map { $0.components(separatedBy: " ").compactMap { Int($0) } }

        return arr.reduce(0) { acc, cur in
            let cur = (cur[0] > cur[1]) ? cur.reversed() : cur
            for i in 1..<cur.count {
                if (1...3).contains(cur[i] - cur[i - 1]) {
                    continue
                }
                return acc
            }
            return acc + 1
        }
    }

    func B() -> Int {
        let arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day02.txt")
            .map { $0.components(separatedBy: " ").compactMap { Int($0) } }

        return arr.reduce(0) { acc, cur in
            outer: for idxToRemove in 0..<cur.count {
                var cur = cur.enumerated().compactMap { i, v in
                    (i == idxToRemove) ? nil : v
                }
                if cur[0] > cur[1] {
                    cur.reverse()
                }

                for i in 1..<cur.count {
                    if (1...3).contains(cur[i] - cur[i - 1]) {
                        continue
                    }
                    continue outer
                }
                return acc + 1
            }
            return acc
        }
    }
}
