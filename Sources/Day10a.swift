import DequeModule
import Foundation

struct Point {
    static var grid = [[Character]]()
    let row: Int
    let col: Int
}

public struct Day10 {
    public mutating func Run() {
        let data = "Inputs/day10.txt".ToStringArray()
        // print("Part 1: \(LogicA(input: data))")
        print("Part 2 (test): \(LogicB(input: test))")
        print("Part 2: \(LogicB(input: data))")
    }

    var grid = [[Character]]()
    var visitedFields = [String: Int]()
    var queue = Deque<(Point, Int)>()

    public mutating func LogicA(input: [String]) -> Int {
        // let inputWithBorder = input.AddBorder()
        grid = parse(input: input)
        Point.grid = grid
        let point = findSPosition(input: grid)

        solve(point: Point(row: point.row, col: point.col))
        let values = visitedFields.values.map { Int($0) }.sorted()

        return values.last!
    }

    private mutating func solve(point: Point) {
        queue.append((point, 0))
        while !queue.isEmpty {
            let pointAndCount = queue.popFirst()!
            let cur = pointAndCount.0
            let count = pointAndCount.1
            let signature = String(cur.row) + ":" + String(cur.col)
            visitedFields[signature] = count
            let curChar = grid[cur.row][cur.col]
            // Up: | 7 F
            if curChar == "|" || curChar == "L" || curChar == "J" || curChar == "S" {
                let up = Point(row: cur.row - 1, col: cur.col)
                let upChar = up.char()
                if upChar == "|" || upChar == "7" || upChar == "F" {
                    let upSig = String(up.row) + ":" + String(up.col)
                    if visitedFields[upSig] == nil {
                        queue.append((up, count + 1))
                    }
                }
            }

            // Right: - J 7
            if curChar == "-" || curChar == "L" || curChar == "F" || curChar == "S" {
                let right = Point(row: cur.row, col: cur.col + 1)
                let rightChar = right.char()
                if rightChar == "-" || rightChar == "J" || rightChar == "7" {
                    let rightSig = String(right.row) + ":" + String(right.col)
                    if visitedFields[rightSig] == nil {
                        queue.append((right, count + 1))
                    }
                }
            }

            // Down: | L J
            if curChar == "|" || curChar == "7" || curChar == "F" || curChar == "S" {
                let down = Point(row: cur.row + 1, col: cur.col)
                let downChar = down.char()
                if downChar == "|" || downChar == "J" || downChar == "L" {
                    let downSig = String(down.row) + ":" + String(down.col)
                    if visitedFields[downSig] == nil {
                        queue.append((down, count + 1))
                    }
                }
            }

            // Left: - L F
            if curChar == "-" || curChar == "7" || curChar == "J" || curChar == "S" {
                let left = Point(row: cur.row, col: cur.col - 1)
                let leftChar = left.char()
                if leftChar == "-" || leftChar == "F" || leftChar == "L" {
                    let leftSig = String(left.row) + ":" + String(left.col)
                    if visitedFields[leftSig] == nil {
                        queue.append((left, count + 1))
                    }
                }
            }
        }
    }

    mutating func parse(input: [String]) -> [[Character]] {
        var result = [[Character]]()
        for line in input {
            result.append(line.map(Character.init))
        }
        return result
    }

    mutating func findSPosition(input: [[Character]]) -> Point {
        for row in 0 ..< input.count {
            for col in 0 ..< input[row].count {
                if input[row][col] == "S" {
                    return Point(row: row, col: col)
                }
            }
        }

        return Point(row: -1, col: -1)
    }
}

extension Point {
    func char() -> Character {
        if row > -1 && row < Point.grid.count
            && col > -1 && col < Point.grid[row].count
        {
            return Point.grid[row][col]
        }
        return "."
    }
}
