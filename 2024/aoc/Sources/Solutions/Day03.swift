class Day03 {
    func A() -> Int {
        let arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day03.txt")
        var result = 0
        for line in arr {
            let matches = line.matches(of: /mul\([\d]{1,3},[\d]{1,3}\)/)
            for m in matches {
                let instruct = line[m.range]
                let numbers = instruct.drop { c in
                    c.isLetter || c == "("
                }
                .dropLast()
                .components(separatedBy: ",")
                .compactMap { Int($0) }
                result += (numbers[0] * numbers[1])

            }
        }

        return result
    }

    func B() -> Int {
        let line = FileHelpers.ReadFileToString(path: "Sources/Inputs/day03.txt")!
        var result = 0


        let muls = line.matches(of: /mul\([\d]{1,3},[\d]{1,3}\)/)
        let dos = Set(line.matches(of: /do\(\)/).map { $0.endIndex })
        let donts = Set(line.matches(of: /don't\(\)/).map { $0.endIndex })
        var isOn = [String.Index: Bool]()
        var on = true
        for idx in line.indices {
            if dos.contains(idx) { on = true }
            if donts.contains(idx) { on = false }
            isOn[idx] = on
        }
        for m in muls {
            if !isOn[m.endIndex]! { continue }
            
            let instruct = line[m.range]
            let numbers = instruct.drop { c in
                c.isLetter || c == "("
            }
            .dropLast()
            .components(separatedBy: ",")
            .compactMap { Int($0) }
            result += (numbers[0] * numbers[1])
        }

        return result
    }
}
