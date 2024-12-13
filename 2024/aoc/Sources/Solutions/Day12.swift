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
            .map { ["_"] + Array($0) + ["_"] }
        grid = [[Character](repeating: "_", count: grid[0].count)] + grid
        grid.append([Character](repeating: "_", count: grid[0].count))

        var result = 0
        var visited = [[Bool]](
            repeating: [Bool](repeating: false, count: grid[0].count),
            count: grid.count)
        for r in 1..<grid.count-1 {
            for c in 1..<grid[0].count-1 {
                if visited[r][c] {
                    continue
                }
                let char = grid[r][c]
                let area = flood(&grid, &visited, r, c, char, "*")
                var leftBorders = [[Bool]](
                    repeating: [Bool](repeating: false, count: grid[0].count),
                    count: grid.count)
                var rightBorders = [[Bool]](
                    repeating: [Bool](repeating: false, count: grid[0].count),
                    count: grid.count)
                var topBorders = [[Bool]](
                    repeating: [Bool](repeating: false, count: grid[0].count),
                    count: grid.count)
                var bottomBorders = [[Bool]](
                    repeating: [Bool](repeating: false, count: grid[0].count),
                    count: grid.count)
                var perimeter = 0
                for r in 1..<grid.count {
                    var last = Character("_")
                    for c in 1..<grid[0].count {
                        if last != "*" && grid[r][c] == "*" {
                            // left border
                            leftBorders[r][c] = true
                            if !leftBorders[r-1][c] {
                                perimeter += 1
                            }
                        } else if last == "*" && grid[r][c] != "*" {
                            // right border
                            rightBorders[r][c-1] = true
                            if !rightBorders[r-1][c-1] {
                                perimeter += 1
                            }
                        }
                        last = grid[r][c]
                    }
                }
                for c in 1..<grid[0].count {
                    var last = Character("_")
                    for r in 1..<grid.count {
                        if last != "*" && grid[r][c] == "*" {
                            // top border
                            topBorders[r][c] = true
                            if !topBorders[r][c-1] {
                                perimeter += 1
                            }
                        } else if last == "*" && grid[r][c] != "*" {
                            // bottom border
                            bottomBorders[r-1][c] = true
                            if !bottomBorders[r-1][c-1] {
                                perimeter += 1
                            }
                        }
                        last = grid[r][c]
                    }
                }
                result += area * perimeter
                _ = flood(&grid, &visited, r, c, "*", char)
            }
        }

        return result
    }

    func flood(
        _ grid: inout [[Character]], _ visited: inout [[Bool]], _ r: Int, _ c: Int,
        _ char: Character, _ replacement: Character
    ) -> Int {
        if !grid.indices.contains(r) || !grid[0].indices.contains(c) {
            return 0
        }
        if grid[r][c] != char {
            return 0
        }
        visited[r][c] = true
        grid[r][c] = replacement
        let dirs = [0, 1, 0, -1, 0]
        var count = 1
        for i in 1..<dirs.count {
            let (r, c) = (r + dirs[i - 1], c + dirs[i])
            count += flood(&grid, &visited, r, c, char, replacement)
        }
        return count
    }
}
