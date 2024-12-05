import Foundation

class Day05 {
    func A() -> Int {
        let (rules, updates) = FileHelpers.ReadFileToStringArray(
            path: "Sources/Inputs/day05.txt"
        )
        .split(separator: "").tuple

        let (comesBefore, comesAfter) =
            rules
            .map { $0.components(separatedBy: "|").compactMap(Int.init) }
            .reduce(into: (comesBefore: [Int: [Int]](), comesAfter: [Int: [Int]]())) { tup, cur in
                tup.comesBefore[cur[0], default: [Int]()].append(cur[1])
                tup.comesAfter[cur[1], default: [Int]()].append(cur[0])
            }

        var result = 0
        outer: for update in updates.map({ $0.components(separatedBy: ",").compactMap(Int.init) }) {
            for i in 0..<update.count {
                let before = update[i]
                for j in (i + 1)..<update.count {
                    let after = update[j]
                    if let rules1 = comesBefore[after], rules1.contains(before) {
                        continue outer
                    }
                    if let rules2 = comesAfter[before], rules2.contains(after) {
                        continue outer
                    }
                }
            }
            result += update[update.count / 2]
        }

        return result
    }

    func B() -> Int {
        let (rules, updates) = FileHelpers.ReadFileToStringArray(
            path: "Sources/Inputs/day05.txt"
        )
        .split(separator: "").tuple

        let (comesBefore, comesAfter) =
            rules
            .map { $0.components(separatedBy: "|").compactMap(Int.init) }
            .reduce(into: (comesBefore: [Int: [Int]](), comesAfter: [Int: [Int]]())) { tup, cur in
                tup.comesBefore[cur[0], default: [Int]()].append(cur[1])
                tup.comesAfter[cur[1], default: [Int]()].append(cur[0])
            }

        var invalidUpdates = [[Int]]()
        outer: for update in updates.map({ $0.components(separatedBy: ",").compactMap(Int.init) }) {
            for i in 0..<update.count {
                let before = update[i]
                for j in (i + 1)..<update.count {
                    let after = update[j]
                    if let rules1 = comesBefore[after], rules1.contains(before) {
                        invalidUpdates.append(update)
                        continue outer
                    }
                    if let rules2 = comesAfter[before], rules2.contains(after) {
                        invalidUpdates.append(update)
                        continue outer
                    }
                }
            }
        }

        var result = 0
        for update in invalidUpdates {
            var update = update
            outer: while true {
                for i in 0..<update.count {
                    let before = update[i]
                    for j in (i + 1)..<update.count {
                        let after = update[j]
                        if let rules1 = comesBefore[after], rules1.contains(before) {
                            update.swapAt(i, j)
                            continue outer
                        }
                        if let rules2 = comesAfter[before], rules2.contains(after) {
                            update.swapAt(i, j)
                            continue outer
                        }
                    }
                }
                break
            }
            result += update[update.count / 2]
        }

        return result
    }
}
