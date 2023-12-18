public class Day14 {
    public func Run() {
        let data = "Inputs/day14.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        var grid = input.map([Character].init)
        for (i, row) in grid.enumerated() {
            for (j, char) in row.enumerated() {
                if char == "O" {
                    grid.move(row: i, col: j, direction: .East)
                }
            }
        }
        var count = 0
        for i in 0 ..< grid.count {
            count += grid[i].filter { $0 == "O" }.count * (grid.count - i)
        }

        return count
    }

    public func LogicB(input: [String]) -> Int {
        var grid = input.map([Character].init)
        while cycle < 1_000_000_000 {
            grid = Cycle(grid: &grid)
            cycle += 1
        }
        var count = 0
        for i in 0 ..< grid.count {
            count += grid[i].filter { $0 == "O" }.count * (grid.count - i)
        }
        return count
    }

    var cycle: Int64 = 0
    var cache = [[[Character]]: [[Character]]]()
    var firstTime: Int64 = -1
    var firstTimeGrid = [[Character]]()
    var cycleDetected = false

    private func Cycle(grid: inout [[Character]]) -> [[Character]] {
        let oldGrid = grid
        if let newGrid = cache[oldGrid] {
            if !cycleDetected {
                if firstTime < 0 {
                    firstTime = cycle
                    firstTimeGrid = newGrid
                } else if newGrid == firstTimeGrid {
                    let cycleSize = cycle - firstTime
                    let leftover = 1_000_000_000 - cycle
                    let mulply = leftover / cycleSize
                    let newCycle = cycle + mulply * cycleSize
                    cycle = newCycle
                }
            }
            return newGrid
        }

        // North
        for (i, row) in grid.enumerated() {
            for (j, char) in row.enumerated() {
                if char == "O" {
                    grid.move(row: i, col: j, direction: .North)
                }
            }
        }
        // West
        for i in 0 ..< grid[0].count {
            for j in 0 ..< grid.count {
                if grid[j][i] == "O" {
                    grid.move(row: j, col: i, direction: .West)
                }
            }
        }
        // South
        for i in stride(from: grid.count - 1, through: 0, by: -1) {
            for j in 0 ..< grid[i].count {
                if grid[i][j] == "O" {
                    grid.move(row: i, col: j, direction: .South)
                }
            }
        }
        // East
        for i in stride(from: grid[0].count - 1, through: 0, by: -1) {
            for j in 0 ..< grid.count {
                if grid[j][i] == "O" {
                    grid.move(row: j, col: i, direction: .East)
                }
            }
        }

        cache[oldGrid] = grid
        return grid
    }
}

private extension [[Character]] {
    mutating func move(row: Int, col: Int, direction: Direction) {
        let initialRow = row
        let initialCol = col
        let moveDir = direction.moveDirection
        let dirMutator = direction.mutator
        var from = 0
        var through = 0
        if dirMutator == 1 {
            if direction == .South {
                through = count - 1
                from = initialRow
            } else if direction == .East {
                through = self[row].count - 1
                from = initialCol
            }
        } else {
            if direction == .North {
                through = 0
                from = initialRow
            } else if direction == .West {
                through = 0
                from = initialCol
            }
        }

        let startRow = row + moveDir.0
        let startCol = col + moveDir.1
        var lastRow = row
        var lastCol = col
        for (i, _) in stride(from: from, through: through, by: dirMutator).enumerated() {
            let mutator = (moveDir.0 * i, moveDir.1 * i)
            if startRow + mutator.0 < 0 || startRow + mutator.0 >= count
                || startCol + mutator.1 < 0 || startCol + mutator.1 >= self[startRow + mutator.0].count
            {
                return
            }
            let nextFieldChar = self[startRow + mutator.0][startCol + mutator.1]
            if nextFieldChar == "." {
                self[startRow + mutator.0][startCol + mutator.1] = "O"
                self[lastRow][lastCol] = "."
                lastRow = lastRow + moveDir.0
                lastCol = lastCol + moveDir.1
            } else {
                break
            }
        }
    }
}

enum Direction {
    case North
    case East
    case South
    case West

    var moveDirection: (Int, Int) {
        switch self {
        case .North:
            return (-1, 0)
        case .East:
            return (0, 1)
        case .South:
            return (1, 0)
        case .West:
            return (0, -1)
        }
    }

    var mutator: Int {
        switch self {
        case .North, .West:
            return -1
        case .East, .South:
            return 1
        }
    }
}

extension [[Character]] {
    func printCompact() {
        for line in self {
            Swift.print(line.reduce(into: "") { acc, cur in acc += String(cur) })
        }
        Swift.print()
    }
}
