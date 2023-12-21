import DequeModule

public struct Day16 {
    public func Run() {
        print()
        let data = "Inputs/day16.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    fileprivate struct Beam {
        var row: Int
        var col: Int
        var direction: Direction
    }

    public func LogicA(input: [String]) -> Int {
        let grid = input.map([Character].init)
        let count = runBeam(grid: grid)

        return count
    }

    private func runBeam(
        grid: [[Character]],
        startBeam: Beam = Beam(row: 0, col: 0, direction: .East)
    ) -> Int {
        var beamMap = [String: [Direction]]()
        var cache = [String: Int]()
        var queue = Deque<Beam>(arrayLiteral: Beam(
            row: startBeam.row,
            col: startBeam.col,
            direction: grid[startBeam.row][startBeam.col].getNextDirection(for: startBeam.direction)
        ))
        while let cur = queue.popFirst() {
            let key = "\(cur.row):\(cur.col):\(cur.direction.rawValue)"
            if cache[key] != nil {
                continue
            }
            beamMap.add(row: cur.row, col: cur.col, direction: cur.direction)
            let direction = cur.direction
            let directionManipulation = direction.moveDirection
            let nextRow = cur.row + directionManipulation.0
            let nextCol = cur.col + directionManipulation.1
            guard nextRow >= 0, nextRow < grid.count,
                  nextCol >= 0, nextCol < grid[nextRow].count
            else {
                continue
            }
            let nextField = grid[nextRow][nextCol]
            let nextDirection = nextField.getNextDirection(for: direction)
            switch nextDirection {
            case .North, .East, .South, .West:
                queue.append(Beam(row: nextRow, col: nextCol, direction: nextDirection))
            case .NorthSouth:
                queue.append(Beam(row: nextRow, col: nextCol, direction: .North))
                queue.append(Beam(row: nextRow, col: nextCol, direction: .South))
            case .EastWest:
                queue.append(Beam(row: nextRow, col: nextCol, direction: .East))
                queue.append(Beam(row: nextRow, col: nextCol, direction: .West))
            }
            cache[key] = 1
        }
        return beamMap.count
    }

    public func LogicB(input: [String]) -> Int {
        let grid = input.map([Character].init)
        var scores = [Int]()
        for i in 0 ..< grid[0].count {
            scores.append(runBeam(grid: grid, startBeam: Beam(row: 0, col: i, direction: .South)))
        }
        for i in 0 ..< grid[grid.count - 1].count {
            scores.append(runBeam(grid: grid, startBeam: Beam(row: grid.count - 1, col: i, direction: .North)))
        }
        for i in 0 ..< grid.count {
            scores.append(runBeam(grid: grid, startBeam: Beam(row: i, col: 0, direction: .East)))
        }
        for i in 0 ..< grid.count {
            scores.append(runBeam(grid: grid, startBeam: Beam(row: i, col: grid[0].count - 1, direction: .West)))
        }

        return scores.max()!
    }
}

extension [String: [Direction]] {
    fileprivate mutating func add(row: Int, col: Int, direction: Direction) {
        let key = "\(row):\(col)"
        if self[key] != nil {
            self[key]!.append(direction)
        } else {
            self[key] = [Direction]()
            self[key]!.append(direction)
        }
    }

    fileprivate mutating func remove(row: Int, col: Int, direction: Direction) {
        let key = "\(row):\(col)"
        if let index = self[key]?.firstIndex(of: direction) {
            self[key]!.remove(at: index)
        }
    }
}

private extension Character {
    func isSpecial() -> Bool {
        [Character](arrayLiteral: "/", "\\", "-", "|").contains(self)
    }

    func getNextDirection(for direction: Direction) -> Direction {
        if direction == .North {
            if self == "\\" {
                return .West
            } else if self == "/" {
                return .East
            } else if self == "-" {
                return .EastWest
            } else if self == "|" {
                return .North
            }
        }
        if direction == .East {
            if self == "\\" {
                return .South
            } else if self == "/" {
                return .North
            } else if self == "-" {
                return .East
            } else if self == "|" {
                return .NorthSouth
            }
        }
        if direction == .South {
            if self == "\\" {
                return .East
            } else if self == "/" {
                return .West
            } else if self == "-" {
                return .EastWest
            } else if self == "|" {
                return .South
            }
        }
        if direction == .West {
            if self == "\\" {
                return .North
            } else if self == "/" {
                return .South
            } else if self == "-" {
                return .West
            } else if self == "|" {
                return .NorthSouth
            }
        }

        return direction
    }
}

fileprivate enum Direction: String {
    case North
    case East
    case South
    case West
    case NorthSouth
    case EastWest

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
        default:
            return (0, 0)
        }
    }

    var opposite: Direction {
        switch self {
        case .North:
            return .South
        case .East:
            return .West
        case .South:
            return .North
        case .West:
            return .East
        default:
            return .EastWest
        }
    }

    var mutator: Int {
        switch self {
        case .North, .West:
            return -1
        case .East, .South:
            return 1
        default:
            return 0
        }
    }

    var char: Character {
        switch self {
        case .North:
            return "N"
        case .East:
            return "E"
        case .South:
            return "S"
        case .West:
            return "W"
        default:
            return "_"
        }
    }
}