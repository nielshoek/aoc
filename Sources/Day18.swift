public struct Day18 {
    public func Run() {
        let data = "Inputs/day18.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        let instructions = parse(input)
        return Logic(instructions: instructions)
    }

    public func LogicB(input: [String]) -> Int {
        let instructions = parse2(input)
        return Logic(instructions: instructions)
    }

    private func Logic(instructions: [Instruction]) -> Int {
        let directions = instructions.map { $0.direction }
        let leftRightBalance = directions.dropFirst().enumerated().reduce(0) { acc, cur in
            let lastDirection = directions[cur.offset]
            return acc + lastDirection.LeftRight(newDirection: cur.element)
        }

        var cp = (x: 0, y: 0)
        var points = [(x: Int, y: Int)](arrayLiteral: cp)
        // Clockwise
        if leftRightBalance > 0 {
            // If clockwise turn +1, If counter clockwise turn -1
            var lastDir = instructions.last?.direction.LeftRight(newDirection: instructions.first!.direction)
            for (i, instr) in instructions.enumerated() {
                let dirTrans = instr.direction.transformation
                var transf = dirTrans * instr.distance
                let nextDir = instructions.getNextDirection(i)
                let dirBalance = instr.direction.LeftRight(newDirection: nextDir)
                // Goes right next
                if dirBalance > 0 && lastDir == 1 {
                    transf.x += dirTrans.x
                    transf.y += dirTrans.y
                }
                // Goes left next
                else if dirBalance < 0 && lastDir == -1 {
                    transf.x -= dirTrans.x
                    transf.y -= dirTrans.y
                }
                cp = (x: cp.x + transf.x,
                      y: cp.y + transf.y)
                lastDir = dirBalance
                points.append(cp)
            }
        }
        // Counter clockwise
        else {
            // If clockwise turn +1, If counter clockwise turn -1
            var lastDir = instructions.last?.direction.LeftRight(newDirection: instructions.first!.direction)
            for (i, instr) in instructions.enumerated() {
                let dirTrans = instr.direction.transformation
                var transf = dirTrans * instr.distance
                let nextDir = instructions.getNextDirection(i)
                let dirBalance = instr.direction.LeftRight(newDirection: nextDir)
                // Goes left next
                if dirBalance < 0 && lastDir == -1 {
                    transf.x += dirTrans.x
                    transf.y += dirTrans.y
                }
                // Goes left next
                else if dirBalance > 0 && lastDir == 1 {
                    transf.x -= dirTrans.x
                    transf.y -= dirTrans.y
                }
                cp = (x: cp.x + transf.x,
                      y: cp.y + transf.y)
                lastDir = dirBalance
                points.append(cp)
            }
        }

        return Polygon(points: points).area.1
    }

    private func parse(_ instructionStrings: [String]) -> [Instruction] {
        return instructionStrings.map {
            let parts = $0.components(separatedBy: " ")
            return Instruction(
                direction: .from(char: Character(parts[0])),
                distance: Int(parts[1])!
            )
        }
    }

    private func parse2(_ instructionStrings: [String]) -> [Instruction] {
        return instructionStrings.map {
            let parts = $0.components(separatedBy: " ")[2].dropFirst(2).dropLast(1)
            let directionChar = parts.last!
            let hexDistance = parts.prefix(5)
            return Instruction(
                direction: .from(char: directionChar),
                distance: Int(hexDistance, radix: 16)!
            )
        }
    }

    struct Polygon {
        struct PointP {
            var x: Int
            var y: Int
        }

        var points: [PointP]

        var area: (Int, Int) {
            let xx = points.map { $0.x }
            let yy = points.map { $0.y }
            let overlace = zip(xx, yy.dropFirst() + yy.prefix(1)).map { $0.0 * $0.1 }.reduce(0, +)
            let underlace = zip(yy, xx.dropFirst() + xx.prefix(1)).map { $0.0 * $0.1 }.reduce(0, +)

            return (abs(overlace - underlace), abs(overlace - underlace) / 2)
        }

        init(points: [PointP]) {
            self.points = points
        }

        init(points: [(Int, Int)]) {
            self.init(points: points.map { PointP(x: $0.0, y: $0.1) })
        }
    }
}

private enum Direction {
    case Up
    case Right
    case Down
    case Left
    case Default

    static func from(char: Character) -> Direction {
        return switch char {
        case "U", "3":
            .Up
        case "R", "0":
            .Right
        case "D", "1":
            .Down
        case "L", "2":
            .Left
        default:
            .Default
        }
    }

    var transformation: (x: Int, y: Int) {
        return switch self {
        case .Up:
            (0, 1)
        case .Right:
            (1, 0)
        case .Down:
            (0, -1)
        case .Left:
            (-1, 0)
        default:
            (0, 0)
        }
    }

    func LeftRight(newDirection: Direction) -> Int {
        switch self {
        case .Up:
            if newDirection == .Right {
                return 1
            } else if newDirection == .Left {
                return -1
            }
        case .Right:
            if newDirection == .Down {
                return 1
            } else if newDirection == .Up {
                return -1
            }
        case .Down:
            if newDirection == .Left {
                return 1
            } else if newDirection == .Right {
                return -1
            }
        case .Left:
            if newDirection == .Up {
                return 1
            } else if newDirection == .Down {
                return -1
            }
        default:
            return 0
        }
        return 0
    }
}

private extension Int {
    static func * (op1: (Int, Int), op2: Int) -> (x: Int, y: Int) {
        (x: op1.0 * op2, y: op1.1 * op2)
    }
}

private extension [Instruction] {
    func getNextDirection(_ i: Int) -> Direction {
        if i < count - 1 {
            return self[i + 1].direction
        }
        return self[0].direction
    }
}

private struct Instruction {
    let direction: Direction
    let distance: Int
}
