class Day04 {
    func A() -> Int {
        var arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day04.txt").map {
            Array($0)
        }
        arr =
            Array(
                repeating: Array(repeating: "_", count: arr[0].count + 6),
                count: 3
            ) + arr
        for i in 3..<arr.count {
            arr[i] = ["_", "_", "_"] + arr[i] + ["_", "_", "_"]
        }
        arr += Array(
            repeating: Array(repeating: "_", count: arr[0].count),
            count: 3)

        let dirs: [(rd: Int, cd: Int)] = [
            (-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1),
        ]
        var result = 0
        for r in 3..<arr.count - 3 {
            for c in 3..<arr[0].count - 3 {
                if arr[r][c] == "X" {
                    for dir in dirs {
                        if arr[r + dir.rd][c + dir.cd] == "M",
                            arr[r + dir.rd * 2][c + dir.cd * 2] == "A",
                            arr[r + dir.rd * 3][c + dir.cd * 3] == "S"
                        {
                            result += 1
                        }
                    }
                }
            }
        }

        return result
    }

    func B() -> Int {
        let arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day04.txt").map{Array($0)}
        let dirs: [(rd: Int, cd: Int)] = [(-1, 1), (1, 1), (1, -1), (-1, -1)]
        let neededChars: [Character] = ["M", "M", "S", "S"]
        var result = 0
        for r in 1..<arr.count - 1 {
            for c in 1..<arr[0].count - 1 where arr[r][c] == "A" {
                let diagonalChars = dirs.map { arr[r + $0.rd][c + $0.cd] }.sorted()
                let opposingCharsNotEqual = arr[r + 1][c + 1] != arr[r - 1][c - 1]
                if diagonalChars == neededChars && opposingCharsNotEqual {
                    result += 1
                }
            }
        }
        return result
    }
}
