import Foundation

class Day02 {
    func A() -> Int {
        let arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day02.txt")
            .map { $0.components(separatedBy: " ").compactMap { Int($0) } }

        return arr.reduce(0) { acc, cur in
            if cur[1] > cur[0] {
                for i in 1..<cur.count {
                    if cur[i] - cur[i - 1] > 0 && cur[i] - cur[i - 1] < 4 {
                        continue
                    }
                    return acc
                }
                return acc + 1
            } else if cur[0] > cur[1] {
                for i in 1..<cur.count {
                    if cur[i - 1] - cur[i] > 0 && cur[i - 1] - cur[i] < 4 {
                        continue
                    }
                    return acc
                }
                return acc + 1
            } else {
                return acc
            }
        }
    }

    func B() -> Int {
        let arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day02.txt")
            .map { $0.components(separatedBy: " ").compactMap { Int($0) } }

        return arr.reduce(0) { acc, cur in
            outer: for idxToRemove in 0..<cur.count {
                let cur = cur.enumerated().compactMap { i, v in i == idxToRemove ? nil : v }
                if cur[1] > cur[0] {
                    for i in 1..<cur.count {
                        if cur[i] - cur[i - 1] > 0 && cur[i] - cur[i - 1] < 4 {
                            continue
                        }
                        continue outer
                    }
                    return acc + 1
                } else if cur[0] > cur[1] {
                    for i in 1..<cur.count {
                        if cur[i - 1] - cur[i] > 0 && cur[i - 1] - cur[i] < 4 {
                            continue
                        }
                        continue outer
                    }
                    return acc + 1
                } else {
                    continue outer
                }
            }
            return acc
        }
    }
}
