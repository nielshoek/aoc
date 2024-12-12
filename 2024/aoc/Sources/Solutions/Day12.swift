import Collections

class Day12 {
    func A() -> Int {
        var grid = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day12.txt")
            .map(Array.init)

        var result = 0
        var visited = [[Bool]](
            repeating: [Bool](repeating: false, count: grid[0].count),
            count: grid.count)
        for r in 0..<grid.count {
            for c in 0..<grid[0].count {
                if visited[r][c] {
                    continue
                }
                var region = 0
                var area = 0
                result += dfsA(&grid, &visited, grid[r][c], r, c, &region, &area)
            }
        }

        return result
    }

    func dfsA(
        _ grid: inout [[Character]],
        _ visited: inout [[Bool]],
        _ char: Character,
        _ r: Int,
        _ c: Int,
        _ perimeter: inout Int,
        _ area: inout Int
    ) -> Int {
        if !grid.indices.contains(r) || !grid[0].indices.contains(c) || visited[r][c] {
            return 0
        }
        if grid[r][c] != char {
            return 0
        }
        visited[r][c] = true
        let dirs = [0, 1, 0, -1, 0]
        for i in 1..<dirs.count {
            let r = r + dirs[i - 1]
            let c = c + dirs[i]
            if !grid.indices.contains(r) || !grid[0].indices.contains(c) {
                perimeter += 1
                continue
            }
            perimeter += (grid[r][c] != char) ? 1 : 0
        }
        area += 1

        for i in 1..<dirs.count {
            let r = r + dirs[i - 1]
            let c = c + dirs[i]
            if !grid.indices.contains(r) || !grid[0].indices.contains(c) { continue }
            _ = dfsA(&grid, &visited, char, r, c, &perimeter, &area)
        }

        return perimeter * area
    }

    func B() -> Int {
        var grid = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day12.txt")
            .map(Array.init)

        var result = 0
        var visited = [[Bool]](
            repeating: [Bool](repeating: false, count: grid[0].count),
            count: grid.count)
        for r in 0..<grid.count {
            for c in 0..<grid[0].count {
                if visited[r][c] {
                    continue
                }
                
            }
        }

        return result
    }
}
