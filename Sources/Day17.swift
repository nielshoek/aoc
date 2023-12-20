import DequeModule
import Foundation

let test = [
    "2413432311323",
    "3215453535623",
    "3255245654254",
    "3446585845452",
    "4546657867536",
    "1438598798454",
    "4457876987766",
    "3637877979653",
    "4654967986887",
    "4564679986453",
    "1224686865563",
    "2546548887735",
    "4322674655533",
]

public struct Day17 {
    public func Run() {
        print()
        let data = "Inputs/day17.txt".ToStringArray()
        print("Part TEST: \(LogicA(input: test))")
        print("Part 1: \(LogicA(input: data))")
        // print("Part 2: \(LogicB(input: data))")
    }

    struct Walker {
        var row: Int
        var col: Int
        var lastSteps: [Direction]
        var score: Int

        mutating func addStep(direction: Direction) {
            lastSteps.append(direction)
        }

        func canMove(to direction: Direction) -> Bool {
            let lastThree = lastSteps.dropFirst(max(0, lastSteps.count - 3))
            return lastThree.filter { $0 == direction }.count < 3 &&
                lastSteps.last != direction.opposite
        }

        func getPossibleMovesSignature() -> String {
            var result = ""
            let lastThreeDirections = lastSteps.dropFirst(max(0, lastSteps.count - 3))
            for direction in lastThreeDirections {
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

    public func LogicB(input _: [String]) -> Int {
        0
    }
}
