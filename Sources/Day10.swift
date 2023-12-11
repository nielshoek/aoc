import Foundation

public struct Day10 {
    mutating public func Run() {
        let data = "Inputs/day10.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    var grid = [[Character]]()
    // Visited field : Visited from field
    var visitedFields = [String: Int]()

    mutating public func LogicA(input: [String]) -> Int {
        let inputWithBorder = input.AddBorder()
        grid = parse(input: inputWithBorder)
        let point = findSPosition(input: grid)
        
        helper(row: point.row, col: point.col, count: 0)


        return visitedFields.count
    }

    // | - L J 7 F 
    // Implement with queue

    mutating private func helper(row: Int, col: Int, count: Int) {
        // let signature = String(point.row) + String(point.col)
        let curChar = grid[row][col]
        print(row, col)
        

        // Up: | 7 F
        if curChar == "|" || curChar == "L" || curChar == "J" || curChar == "S" {
            let up = (row: row - 1, col: col)
            let upChar = getField(point: up)
            if upChar == "|" || upChar == "7" || upChar == "F" {
                let upSig = String(up.row) + ":" + String(up.col)
                if visitedFields[upSig] == nil {
                    visitedFields[upSig] = count + 1
                    // Put on queue
                    helper(row: up.row, col: up.col, count: count + 1)
                }
            }
        }

        // Right: - J 7
        if curChar == "-" || curChar == "L" || curChar == "F" || curChar == "S" {
            let right = (row: row, col: col + 1)
            let rightChar = getField(point: right)
            if rightChar == "-" || rightChar == "J" || rightChar == "7" {
                let rightSig = String(right.row) + ":" + String(right.col)
                if visitedFields[rightSig] == nil {
                    visitedFields[rightSig] = count + 1
                    helper(row: right.row, col: right.col, count: count + 1)
                }
            }
        }

        // Down: | L J
        if curChar == "|" || curChar == "7" || curChar == "F" || curChar == "S" {
            let down = (row: row + 1, col: col)
            let downChar = getField(point: down)
            if downChar == "|" || downChar == "J" || downChar == "L" {
                let downSig = String(down.row) + ":" + String(down.col)
                if visitedFields[downSig] == nil {
                    visitedFields[downSig] = count + 1
                    helper(row: down.row, col: down.col, count: count + 1)
                }
            }
        }

        // Left: - L F
        if curChar == "-" || curChar == "7" || curChar == "J" || curChar == "S" {
            let left = (row: row, col: col - 1)
            let leftChar = getField(point: left)
            if leftChar == "-" || leftChar == "F" || leftChar == "L" {
                let leftSig = String(left.row) + ":" + String(left.col)
                if visitedFields[leftSig] == nil {   
                    visitedFields[leftSig] = count + 1
                    helper(row: left.row, col: left.col, count: count + 1)
                }
            }
        }
    }

    public func LogicB(input: [String]) -> Int {
        0
    }

    mutating private func parse(input: [String]) -> [[Character]] {
        var result = [[Character]]()
        for line in input {
            result.append(line.map(Character.init))
        }
        return result
    }

    mutating private func findSPosition(input: [[Character]]) -> (row: Int, col: Int) {
        for row in 0..<input.count {
            for col in 0..<input[row].count {
                if input[row][col] == "S" {
                    return (row, col)
                }
            }
        }

        return (-1, -1)
    }

    mutating private func getField(point: (row: Int, col: Int)) -> Character {
        if point.row > 0 && point.row < grid.count 
            && point.col > 0 && point.col < grid[point.row].count {
            return grid[point.row][point.col]
        }

        return "."
    }

}
