public enum Day_1 {
    public static func Run() -> Int {
        let data = "Inputs/day1.txt".ToStringArray()
        return LogicB(input: data)
    }

    public static func LogicA(input: [String]) -> Int {
        var count = 0
        input.forEach { line in
            let nr1 = line.first { char in
                char.isNumber
            }!
            let nr2 = line.last { char in
                char.isNumber
            }!
            count += Int(String(nr1) + String(nr2))!
        }

        return count
    }

    public static func LogicB(input: [String]) -> Int {
        var count = 0
        input.forEach { line in
            let leftNr = getLeft(line: line)
            let rightNr = getRight(line: line)
            count += Int(leftNr + rightNr)!
        }

        return count
    }

    private static func getRight(line: String) -> String {
        var firstRight = (Int.max, "")
        numbers.forEach { k, v in
            let kReversed = String(k.reversed())
            let lineReversed = String(line.reversed())
            let i = lineReversed.range(of: kReversed)?.lowerBound
            if i != nil && i!.distance(in: lineReversed) < firstRight.0 {
                firstRight = (i!.distance(in: lineReversed), v)
            }
        }
        firstRight = (line.count - firstRight.0 - 1, firstRight.1)

        let nr2 = line.lastIndex { char in
            char.isNumber
        }!.distance(in: line)
        if nr2 > firstRight.0 {
            firstRight = (nr2, String(line[String.Index(utf16Offset: nr2, in: line)]))
        }

        return firstRight.1
    }

    private static func getLeft(line: String) -> String {
        var first = (Int.max, "")
        numbers.forEach { k, v in
            let i = line.range(of: k)?.lowerBound
            if i != nil && i!.distance(in: line) < first.0 {
                first = (i!.distance(in: line), v)
            }
        }
        let nr1 = line.firstIndex { char in
            char.isNumber
        }!.distance(in: line)
        if nr1 < first.0 {
            first = (nr1, String(line[String.Index(utf16Offset: nr1, in: line)]))
        }

        return first.1
    }

    static let numbers = [
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9",
    ]
}

extension StringProtocol {
    func distance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self) }
    func distance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self) }
}

extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}

extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(to: self) }
}
