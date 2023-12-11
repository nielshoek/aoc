import DequeModule
import Foundation

public struct Day10 {
    public mutating func Run() {
        let data = "Inputs/day10.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    typealias Point = (row: Int, col: Int)
    var grid = [[Character]]()
    var visitedFields = [String: Int]()
    var queue = Deque<(Point, Int)>()

    public mutating func LogicA(input: [String]) -> Int {
        // let inputWithBorder = input.AddBorder()
        grid = parse(input: input)
        let point = findSPosition(input: grid)

        solve(point: (row: point.row, col: point.col))
        let values = visitedFields.values.map { Int($0) }.sorted()
        
        return values.last!
    }

    // | - L J 7 F
    // Implement with queue

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
                let up = (row: cur.row - 1, col: cur.col)
                let upChar = getField(point: up)
                if upChar == "|" || upChar == "7" || upChar == "F" {
                    let upSig = String(up.row) + ":" + String(up.col)
                    if visitedFields[upSig] == nil {
                        queue.append((up, count + 1))
                    }
                }
            }

            // Right: - J 7
            if curChar == "-" || curChar == "L" || curChar == "F" || curChar == "S" {
                let right = (row: cur.row, col: cur.col + 1)
                let rightChar = getField(point: right)
                if rightChar == "-" || rightChar == "J" || rightChar == "7" {
                    let rightSig = String(right.row) + ":" + String(right.col)
                    if visitedFields[rightSig] == nil {
                        queue.append((right, count + 1))
                    }
                }
            }

            // Down: | L J
            if curChar == "|" || curChar == "7" || curChar == "F" || curChar == "S" {
                let down = (row: cur.row + 1, col: cur.col)
                let downChar = getField(point: down)
                if downChar == "|" || downChar == "J" || downChar == "L" {
                    let downSig = String(down.row) + ":" + String(down.col)
                    if visitedFields[downSig] == nil {
                        queue.append((down, count + 1))
                    }
                }
            }

            // Left: - L F
            if curChar == "-" || curChar == "7" || curChar == "J" || curChar == "S" {
                let left = (row: cur.row, col: cur.col - 1)
                let leftChar = getField(point: left)
                if leftChar == "-" || leftChar == "F" || leftChar == "L" {
                    let leftSig = String(left.row) + ":" + String(left.col)
                    if visitedFields[leftSig] == nil {
                        queue.append((left, count + 1))
                    }
                }
            }
        }
    }

    public func LogicB(input _: [String]) -> Int {
        0
    }

    private mutating func parse(input: [String]) -> [[Character]] {
        var result = [[Character]]()
        for line in input {
            result.append(line.map(Character.init))
        }
        return result
    }

    private mutating func findSPosition(input: [[Character]]) -> (row: Int, col: Int) {
        for row in 0 ..< input.count {
            for col in 0 ..< input[row].count {
                if input[row][col] == "S" {
                    return (row, col)
                }
            }
        }

        return (-1, -1)
    }

    private mutating func getField(point: (row: Int, col: Int)) -> Character {
        if point.row > -1 && point.row < grid.count
            && point.col > -1 && point.col < grid[point.row].count
        {
            return grid[point.row][point.col]
        }

        return "."
    }
}
