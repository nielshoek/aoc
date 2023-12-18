let test = [
    "O....#....",
    "O.OO#....#",
    ".....##...",
    "OO.#O....O",
    ".O.....O#.",
    "O.#..O.#.#",
    "..O..#O..O",
    ".......O..",
    "#....###..",
    "#OO..#....",
]

public struct Day14 {
    public func Run() {
        let data = "Inputs/day14.txt".ToStringArray()
        print("Part TEST: \(LogicA(input: test))")
        print("Part 1: \(LogicA(input: data))")
        // print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        var grid = input.map([Character].init)
        grid.printCompact()
        for (i, row) in grid.enumerated() {
            for (j, char) in row.enumerated() {
                if char == "O" {
                    grid.move(row: i, col: j, direction: .North)
                }
            }
        }
        var count = 0
        for i in 0..<grid.count {
            count += grid[i].filter({ $0 == "O" }).count * (grid.count - i)
        }

        grid.printCompact()

        return count
    }

    public func LogicB(input _: [String]) -> Int {
        0
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
