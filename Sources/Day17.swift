import DequeModule

public struct Day17 {
    public func Run() {
        print()
        let data = "Inputs/day17.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    fileprivate struct Walker {
        var row: Int
        var col: Int
        var lastSteps: [Direction]
        var score: Int

        fileprivate func canMove(to direction: Direction) -> Bool {
            let lastThree = lastSteps.dropFirst(max(0, lastSteps.count - 3))
            return lastThree.filter { $0 == direction }.count < 3 &&
                lastSteps.last != direction.opposite
        }

        fileprivate func canMove2(to direction: Direction) -> Bool {
            let last10 = lastSteps.dropFirst(max(0, lastSteps.count - 10))
            let index = last10.lastIndex(where: { $0 != last10.last })
            let nrOfSteps = if let index = index {
                lastSteps.count - index - 1
            } else {
                last10.count
            }

            if nrOfSteps < 4 {
                return lastSteps.count == 0 || direction == lastSteps.last
            }

            if nrOfSteps < 10 {
                return lastSteps.last != direction.opposite
            }

            if nrOfSteps >= 10 {
                return lastSteps.last != direction.opposite &&
                    lastSteps.last != direction
            }

            print("THIS SHOULD NOT HAPPEN |||| THIS SHOULD NOT HAPPEN |||| THIS SHOULD NOT HAPPEN")
            exit(0)
        }

        func getPossibleMovesSignature() -> String {
            var result = ""
            let lastThreeDirections = lastSteps.dropFirst(max(0, lastSteps.count - 3))
            for direction in lastThreeDirections {
                result += String(direction.char)
            }
            return result
        }

        func getPossibleMovesSignature2() -> String {
            var result = ""
            let lastTen = lastSteps.dropFirst(max(0, lastSteps.count - 10))
            for direction in lastTen {
                result += String(direction.char)
            }
            return result
        }
    }

    public func LogicA(input: [String]) -> Int {
        let grid = input.map {
            $0.map { Int(String($0))! }
        }
        var walkerQueue = Deque<Walker>(arrayLiteral:
            Walker(row: 0, col: 0, lastSteps: [Direction](), score: 0))
        var fieldScores = [String: Int]()
        var uniqueFieldScores = [String: Int]()
        while let walker = walkerQueue.popFirst() {
            // Check score. Stop if lower score exists.
            let fieldKey = "\(walker.row):\(walker.col)"
            let uniqueKey = "\(walker.row):\(walker.col):\(walker.getPossibleMovesSignature())"
            if let fieldScore = fieldScores[uniqueKey] {
                if fieldScore <= walker.score {
                    continue
                }
            }
            fieldScores[uniqueKey] = walker.score

            if let fieldScore = uniqueFieldScores[fieldKey] {
                if walker.score <= fieldScore {
                    uniqueFieldScores[fieldKey] = walker.score
                }
            } else {
                uniqueFieldScores[fieldKey] = walker.score
            }

            // North
            if walker.row > 0 && walker.canMove(to: .North) {
                let newWalker = Walker(
                    row: walker.row - 1,
                    col: walker.col,
                    lastSteps: walker.lastSteps + [.North],
                    score: walker.score + grid[walker.row - 1][walker.col]
                )
                walkerQueue.append(newWalker)
            }
            // East
            if walker.col < grid[walker.row].count - 1 && walker.canMove(to: .East) {
                let newWalker = Walker(
                    row: walker.row,
                    col: walker.col + 1,
                    lastSteps: walker.lastSteps + [.East],
                    score: walker.score + grid[walker.row][walker.col + 1]
                )
                walkerQueue.append(newWalker)
            }
            // South
            if walker.row < grid.count - 1 && walker.canMove(to: .South) {
                let newWalker = Walker(
                    row: walker.row + 1,
                    col: walker.col,
                    lastSteps: walker.lastSteps + [.South],
                    score: walker.score + grid[walker.row + 1][walker.col]
                )
                walkerQueue.append(newWalker)
            }
            // West
            if walker.col > 0 && walker.canMove(to: .West) {
                let newWalker = Walker(
                    row: walker.row,
                    col: walker.col - 1,
                    lastSteps: walker.lastSteps + [.West],
                    score: walker.score + grid[walker.row][walker.col - 1]
                )
                walkerQueue.append(newWalker)
            }
        }

        return uniqueFieldScores["\(grid.count - 1):\(grid[grid.count - 1].count - 1)"]!
    }

    public func LogicB(input: [String]) -> Int {
        let grid = input.map {
            $0.map { Int(String($0))! }
        }
        var walkerQueue = Deque<Walker>(arrayLiteral:
            Walker(row: 0, col: 0, lastSteps: [Direction](), score: 0))
        var fieldScores = [String: Int]()
        var uniqueFieldScores = [String: Int]()
        while let walker = walkerQueue.popFirst() {
            // Check score. Stop (continue) if lower score exists.
            let fieldKey = "\(walker.row):\(walker.col)"
            let uniqueKey = "\(walker.row):\(walker.col):\(walker.getPossibleMovesSignature2())"
            if let fieldScore = fieldScores[uniqueKey] {
                if fieldScore <= walker.score {
                    continue
                }
            }
            fieldScores[uniqueKey] = walker.score

            if let fieldScore = uniqueFieldScores[fieldKey] {
                if walker.score <= fieldScore {
                    uniqueFieldScores[fieldKey] = walker.score
                }
            } else {
                uniqueFieldScores[fieldKey] = walker.score
            }

            // North
            if walker.row > 0 && walker.canMove2(to: .North) {
                let newWalker = Walker(
                    row: walker.row - 1,
                    col: walker.col,
                    lastSteps: walker.lastSteps + [.North],
                    score: walker.score + grid[walker.row - 1][walker.col]
                )
                walkerQueue.append(newWalker)
            }
            // East
            if walker.col < grid[walker.row].count - 1 && walker.canMove2(to: .East) {
                let newWalker = Walker(
                    row: walker.row,
                    col: walker.col + 1,
                    lastSteps: walker.lastSteps + [.East],
                    score: walker.score + grid[walker.row][walker.col + 1]
                )
                walkerQueue.append(newWalker)
            }
            // South
            if walker.row < grid.count - 1 && walker.canMove2(to: .South) {
                let newWalker = Walker(
                    row: walker.row + 1,
                    col: walker.col,
                    lastSteps: walker.lastSteps + [.South],
                    score: walker.score + grid[walker.row + 1][walker.col]
                )
                walkerQueue.append(newWalker)
            }
            // West
            if walker.col > 0 && walker.canMove2(to: .West) {
                let newWalker = Walker(
                    row: walker.row,
                    col: walker.col - 1,
                    lastSteps: walker.lastSteps + [.West],
                    score: walker.score + grid[walker.row][walker.col - 1]
                )
                walkerQueue.append(newWalker)
            }
        }

        return uniqueFieldScores["\(grid.count - 1):\(grid[grid.count - 1].count - 1)"]!
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