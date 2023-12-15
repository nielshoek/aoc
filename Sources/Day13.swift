let test13 = [
    "#.######.#.", // 1
    "....##.#...", // 2
    "..######...", // 3
    "###....###.", // 4
    "#..####..##", // 5
    ".#.#..#.#.#", // 6
    ".#.#..#.#.#", // 7
    "##......###", // 8
    "..........#", // 9
    ".#.####.#.#", // 10
    ".#......#.#", // 11
    ".#......#.#", // 12
    ".#.####.#.#", // 13
]

public struct Day13 {
    public func Run() {
        let data = "Inputs/day13.txt".ToStringArray()
        print("Part Test: \(LogicA(input: test13))")
        print("Part 1: \(LogicA(input: data))")
        // print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        let blocks = input.split(separator: "")

        var totalScore = 0
        for block in blocks {
            let rowScore = getRowScore(block: Array(block))
            let colScore = getColScore(block: Array(block))
            totalScore += rowScore + colScore
        }

        return totalScore
    }

    private func getRowScore(block: [String]) -> Int {
        var result = 0
        for i in 0 ..< block.count - 1 {
            let row1 = block[i]
            let row2 = block[i + 1]
            if row1 == row2 {
                var i1 = i - 1
                var i2 = i + 2
                var isMirror = true
                while i1 >= 0 && i2 < block.count {
                    if block[i1] == block[i2] {
                        i1 -= 1
                        i2 += 1
                    } else {
                        isMirror = false
                        break
                    }
                }
                if isMirror {
                    return (i + 1) * 100
                }
            }
        }

        return result
    }

    private func getColScore(block: [String]) -> Int {
        var result = 0
        for i in 0 ..< block[0].count - 1 {
            var col1 = i
            var col2 = i + 1
            var isMirror = true
            outer: while col1 >= 0 && col2 < block[0].count {
                for j in 0 ..< block.count {
                    let row = block[j]
                    if row[col1] != row[col2] {
                        isMirror = false
                        break outer
                    }
                }
                col1 -= 1
                col2 += 1
            }

            if isMirror {
                return i + 1
            }
        }

        return result
    }

    public func LogicB(input _: [String]) -> Int {
        0
    }
}

extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
}
