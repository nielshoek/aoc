import Foundation

public struct Day4 {
    public func Run() {
        let data = "Inputs/day4.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        var count = 0
        for line in input {
            let splitString = line.components(separatedBy: " | ")
            let myNumbers = splitString[0]
                .components(separatedBy: ": ")[1]
                .split(separator: #/\s/#)
            let winningNumbers = splitString[1].split(separator: #/\s/#)
            let matchCount = myNumbers.reduce(0) { acc, val in
                acc + (winningNumbers.contains(val) ? 1 : 0)
            }
            count += 1 << (matchCount - 1)
        }

        return count
    }

    public func LogicB(input: [String]) -> Int {
        var count = 0
        let original = input
            .enumerated()
            .map { index, line in
                Card(index: index, line: line)
            }
        var cards = original
        while let card = cards.popLast() {
            count += 1
            for i in card.givesCopies {
                cards.append(original[i])
            }
        }

        return count
    }
}

class Card {
    let index: Int
    let line: String
    let givesCopies: [Int]

    init(index: Int, line: String) {
        self.index = index
        self.line = line
        givesCopies = Card.determineCopies(index: index, line: line)
    }
}

extension Card {
    static func determineCopies(index: Int, line: String) -> [Int] {
        let splitString = line.components(separatedBy: " | ")
        let myNumbers = splitString[0]
            .components(separatedBy: ": ")[1]
            .split(separator: #/\s/#)
        let winningNumbers = splitString[1].split(separator: #/\s/#)
        let matchCount = myNumbers.reduce(0) { acc, val in
            acc + (winningNumbers.contains(val) ? 1 : 0)
        }
        var result = [Int]()
        if matchCount > 0 {
            for i in 1 ... matchCount {
                result.append(index + i)
            }
        }

        return result
    }
}
