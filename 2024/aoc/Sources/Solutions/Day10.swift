class Day10 {
    func A() -> Int {
        let grid = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day10.txt")
            .map { $0.compactMap(\.wholeNumberValue) }

        var result = 0
        for r in 0..<grid.count {
            for c in 0..<grid.count {
                if grid[r][c] == 0 {
                    var found = Set<[Int]>()
                    result += dfsA(grid, r, c, -1, &found)
                }
            }
        }

        return result
    }

    func dfsA(_ grid: [[Int]], _ r: Int, _ c: Int, _ last: Int, _ found: inout Set<[Int]>) -> Int {
        guard (0..<grid.count).contains(r), (0..<grid[0].count).contains(c) else {
            return 0
        }
        let cur = grid[r][c]
        if cur != last + 1 {
            return 0
        }
        if cur == 9, !found.contains([r, c]) {
            found.insert([r, c])
            return 1
        }
        let dirs = [0, 1, 0, -1, 0]
        var result = 0
        for i in 1..<dirs.count {
            let r = r + dirs[i - 1]
            let c = c + dirs[i]
            result += dfsA(grid, r, c, cur, &found)
        }
        return result
    }

    func B() -> Int {
        let grid = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day10.txt")
            .map { $0.compactMap(\.wholeNumberValue) }

        var result = 0
        for r in 0..<grid.count {
            for c in 0..<grid.count {
                if grid[r][c] == 0 {
                    result += dfsB(grid, r, c, -1)
                }
            }
        }

        return result
    }

    func dfsB(_ grid: [[Int]], _ r: Int, _ c: Int, _ last: Int) -> Int {
        guard (0..<grid.count).contains(r), (0..<grid[0].count).contains(c) else {
            return 0
        }
        let cur = grid[r][c]
        if cur != last + 1 {
            return 0
        }
        if cur == 9 {
            return 1
        }
        let dirs = [0, 1, 0, -1, 0]
        var result = 0
        for i in 1..<dirs.count {
            result += dfsB(grid, r + dirs[i - 1], c + dirs[i], cur)
        }
        return result
    }
}
