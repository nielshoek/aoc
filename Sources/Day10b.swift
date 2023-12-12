import DequeModule
import Foundation

let test = [
    "777777....", // 1
    ".F--77....",
    ".S..|7....",
    ".|..L-7...",
    ".L--7.|F-7", // 5
    "....|.LJ.|",
    "....L----J",
    "..........",
    "..........",
    "..........", // 10
]

extension Day10 {
    public mutating func LogicB(input: [String]) -> Int {
        grid = parse(input: input)
        Point.grid = grid
        let point = findSPosition(input: grid)
        let firstPoint = determineStartPoint(point: point)
        markPath(point: firstPoint)
        grid[point.row][point.col] = GetSReplacement(point: point)

        let nrs = count()
        for (i, line) in grid.enumerated() {
            print("\(i + 1): " + String(line) + " \(nrs[i])")
        }
        print()

        return nrs.reduce(0) { acc, cur in acc + cur }
    }

    private func count() -> [Int] {
        var result = [Int]()
        var count = 0
        for (i, line) in grid.enumerated() {
            count = 0
            var isInside = false
            var lastChar = Character(" ")
            for char in line {
                if char == "║" {
                    isInside = !isInside
                    continue
                }

                if char == "╗" {
                    if lastChar == "╔" {
                        isInside = !isInside
                    }
                    lastChar = char
                    continue
                }

                if char == "╝" {
                    if lastChar == "╚" {
                        isInside = !isInside
                    }
                    lastChar = char
                    continue
                }

                if char == "╔" {
                    isInside = !isInside
                    lastChar = char
                    continue
                }

                if char == "╚" {
                    isInside = !isInside
                    lastChar = char
                    continue
                }

                if char != "═", isInside {
                    count += 1
                    continue
                }
            }
            result.append(count)
            print("Line \(i + 1): \(count)")
        }
        return result
    }

    private mutating func markPath(point: Point) {
        queue.append((point, 0))
        while !queue.isEmpty {
            let pointAndCount = queue.popFirst()!
            let curPoint = pointAndCount.0
            let count = pointAndCount.1
            let signature = String(curPoint.row) + ":" + String(curPoint.col)
            visitedFields[signature] = count
            let curChar = grid[curPoint.row][curPoint.col]
            replaceChar(point: curPoint)

            if curChar == "|" || curChar == "L" || curChar == "J" || curChar == "S" {
                let up = Point(row: curPoint.row - 1, col: curPoint.col)
                let upChar = up.char()
                if upChar == "|" || upChar == "7" || upChar == "F" {
                    let upSig = String(up.row) + ":" + String(up.col)
                    if visitedFields[upSig] == nil {
                        queue.append((up, count + 1))
                    }
                }
            }

            if curChar == "-" || curChar == "L" || curChar == "F" || curChar == "S" {
                let right = Point(row: curPoint.row, col: curPoint.col + 1)
                let rightChar = right.char()
                if rightChar == "-" || rightChar == "J" || rightChar == "7" {
                    let rightSig = String(right.row) + ":" + String(right.col)
                    if visitedFields[rightSig] == nil {
                        queue.append((right, count + 1))
                    }
                }
            }

            if curChar == "|" || curChar == "7" || curChar == "F" || curChar == "S" {
                let down = Point(row: curPoint.row + 1, col: curPoint.col)
                let downChar = down.char()
                if downChar == "|" || downChar == "J" || downChar == "L" {
                    let downSig = String(down.row) + ":" + String(down.col)
                    if visitedFields[downSig] == nil {
                        queue.append((down, count + 1))
                    }
                }
            }

            if curChar == "-" || curChar == "7" || curChar == "J" || curChar == "S" {
                let left = Point(row: curPoint.row, col: curPoint.col - 1)
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

    private mutating func replaceChar(point: Point) {
        let char = point.char()
        switch char {
        case "-":
            grid[point.row][point.col] = "═"
        case "7":
            grid[point.row][point.col] = "╗"
        case "|":
            grid[point.row][point.col] = "║"
        case "J":
            grid[point.row][point.col] = "╝"
        case "L":
            grid[point.row][point.col] = "╚"
        case "F":
            grid[point.row][point.col] = "╔"
        default:
            return
        }
    }

    private mutating func determineStartPoint(point: Point) -> Point {
        let up = Point(row: point.row - 1, col: point.col)
        let upChar = up.char()
        if upChar == "|" || upChar == "7" || upChar == "F" {
            return up
        }

        let right = Point(row: point.row, col: point.col + 1)
        let rightChar = right.char()
        if rightChar == "-" || rightChar == "J" || rightChar == "7" {
            return right
        }

        let down = Point(row: point.row + 1, col: point.col)
        let downChar = down.char()
        if downChar == "|" || downChar == "J" || downChar == "L" {
            return down
        }

        let left = Point(row: point.row, col: point.col - 1)
        let leftChar = left.char()
        if leftChar == "-" || leftChar == "F" || leftChar == "L" {
            return left
        }

        return Point(row: -1, col: -1)
    }

    private mutating func GetSReplacement(point: Point) -> Character {
        var dirs: [String] = []

        let up = Point(row: point.row - 1, col: point.col)
        let upChar = up.char()
        if upChar == "|" || upChar == "7" || upChar == "F" {
            dirs.append("up")
        }

        let right = Point(row: point.row, col: point.col + 1)
        let rightChar = right.char()
        if rightChar == "-" || rightChar == "J" || rightChar == "7" {
            dirs.append("right")
        }

        let down = Point(row: point.row + 1, col: point.col)
        let downChar = down.char()
        if downChar == "|" || downChar == "J" || downChar == "L" {
            dirs.append("down")
        }

        let left = Point(row: point.row, col: point.col - 1)
        let leftChar = left.char()
        if leftChar == "-" || leftChar == "F" || leftChar == "L" {
            dirs.append("left")
        }

        if dirs.contains("up") && dirs.contains("right") {
            return "╚"
        }

        if dirs.contains("up") && dirs.contains("down") {
            return "║"
        }

        if dirs.contains("up") && dirs.contains("left") {
            return "╝"
        }

        if dirs.contains("down") && dirs.contains("right") {
            return "╔"
        }

        if dirs.contains("left") && dirs.contains("right") {
            return "═"
        }

        if dirs.contains("left") && dirs.contains("down") {
            return "╗"
        }

        return "X"
    }
}
