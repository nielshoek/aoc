public struct Day13 {
    public func Run() {
        let data = "Inputs/day13.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
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

    public func LogicB(input: [String]) -> Int {
        let blocks = input.split(separator: "") 
        var totalScore = 0
        for block in blocks {
            let rowScore = getRowScore2(block: Array(block))
            let colScore = getColScore2(block: Array(block))
            totalScore += rowScore + colScore
        }

        return totalScore
    }

    private func getRowScore(block: [String]) -> Int {
        for i in 0 ..< block.count - 1 {
            let rowDiff = getRowDiff(block: block, i1: i, i2: i + 1)
            if rowDiff == 0 {
                return (i + 1) * 100
            }
        }

        return 0
    }

    private func getColScore(block: [String]) -> Int {
        for i in 0 ..< block[0].count - 1 {
            let colDiff = getColDiff(block: block, i1: i, i2: i + 1)
            if colDiff == 0 {
                return i + 1
            }
        }

        return 0
    }

    private func getRowScore2(block: [String]) -> Int {
        for i in 0 ..< block.count - 1 {
            let rowDiff = getRowDiff(block: block, i1: i, i2: i + 1)
            if rowDiff == 1 {
                return (i + 1) * 100
            }
        }

        return 0
    }

    private func getColScore2(block: [String]) -> Int {
        for i in 0 ..< block[0].count - 1 {
            let colDiff = getColDiff(block: block, i1: i, i2: i + 1)
            if colDiff == 1 {
                return i + 1
            }
        }

        return 0
    }

    private func getColDiff(block: [String], i1: Int, i2: Int) -> Int {
        var col1 = i1
        var col2 = i2
        var diff = 0
        outer: while col1 >= 0 && col2 < block[0].count {
            for j in 0 ..< block.count {
                let row = block[j]
                if row[col1] != row[col2] {
                    diff += 1
                }
            }
            col1 -= 1
            col2 += 1
        }

        return diff
    }

    private func getRowDiff(block: [String], i1: Int, i2: Int) -> Int {
        var i1 = i1
        var i2 = i2
        var diff = 0
        while i1 >= 0 && i2 < block.count {
            for j in 0 ..< block[i1].count {
                if block[i1][j] != block[i2][j] {
                    diff += 1
                }
            }
            i1 -= 1
            i2 += 1
        }
        return diff
    }
}

extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
}
