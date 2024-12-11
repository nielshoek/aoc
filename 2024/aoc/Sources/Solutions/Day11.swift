class Day11 {
    func A() -> Int {
        var numbers = FileHelpers.ReadFileToString(path: "Sources/Inputs/day11.txt")!
            .split(separator: " ")
            .map { Int($0)! }

        for _ in 0..<30 {
            for i in stride(from: numbers.count - 1, through: 0, by: -1) {
                let strVal = Array(String(numbers[i]))
                if strVal.count % 2 == 0 {
                    numbers[i] = Int(String(strVal[0..<(strVal.count / 2)]))!
                    numbers.insert(
                        Int(String(strVal[(strVal.count / 2)..<strVal.count]))!, at: i + 1)
                } else if numbers[i] == 0 {
                    numbers[i] = 1
                } else {
                    numbers[i] *= 2024
                }
            }
        }

        return numbers.count
    }

    func B() -> Int {
        let numbers =
            FileHelpers.ReadFileToString(path: "Sources/Inputs/day11.txt")!
            .split(separator: " ")
            .map { Int($0)! }

        var cache = [Int: [Int: Int]]()
        var acc = 0
        for i in 0..<numbers.count {
            acc += 1
            bHelper(&cache, numbers[i], 75, &acc)
        }

        return acc
    }

    func bHelper(_ cache: inout [Int: [Int: Int]], _ stone: Int, _ blinks: Int, _ acc: inout Int) {
        if blinks == 0 {
            return
        }
        if let val = cache[stone, default: [:]][blinks] {
            acc += val
            return
        }
        let strVal = Array(String(stone))
        if strVal.count % 2 == 0 {
            let left = Int(String(strVal[0..<(strVal.count / 2)]))!
            let right = Int(String(strVal[(strVal.count / 2)..<strVal.count]))!
            let accBef = acc
            acc += 1
            bHelper(&cache, left, blinks - 1, &acc)
            bHelper(&cache, right, blinks - 1, &acc)
            cache[stone, default: [:]][blinks] = acc - accBef
        } else if stone == 0 {
            let accBef = acc
            bHelper(&cache, 1, blinks - 1, &acc)
            cache[stone, default: [:]][blinks] = acc - accBef
        } else {
            let accBef = acc
            bHelper(&cache, stone * 2024, blinks - 1, &acc)
            cache[stone, default: [:]][blinks] = acc - accBef
        }
    }
}
