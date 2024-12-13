class Day13 {
    struct Machine {
        let a: (x: Int, y: Int)
        let b: (x: Int, y: Int)
        let prize: (x: Int, y: Int)
    }

    func A() -> Int {
        let machines = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day13.txt")
            .split(separator: [""])
            .compactMap {
                if $0.count < 3 { return Machine?(nil) }
                let arr = Array($0)
                let aValues = arr[0].split(separator: " ").compactMap { Int($0) }
                let bValues = arr[1].split(separator: " ").compactMap { Int($0) }
                let prize = arr[2].split(separator: " ").compactMap { Int($0) }
                return Machine(
                    a: (aValues[0], aValues[1]),
                    b: (bValues[0], bValues[1]),
                    prize: (prize[0], prize[1]))
            }

        var tokens = 0
        for machine in machines {
            var aTokens = 0
            var bTokens = 0
            var machineTokens = Int.max
            var pos = (x: 0, y: 0)
            let (a, b, prize) = (machine.a, machine.b, machine.prize)
            var aPushes = 0
            while pos.x < prize.x, pos.y < prize.y {
                let xNeeded = prize.x - pos.x
                let yNeeded = prize.y - pos.y
                if Double(xNeeded) / Double(b.x) == Double(yNeeded) / Double(b.y) {
                    if (Double(xNeeded) / Double(b.x)).truncatingRemainder(dividingBy: 1) == 0.0 {
                        let nrOfPushes = yNeeded / b.y
                        if nrOfPushes <= 100 {
                            bTokens = yNeeded / b.y
                            machineTokens = min(machineTokens, aTokens + bTokens)
                        }
                    }
                }
                pos.x += a.x
                pos.y += a.y
                aTokens += 3
                aPushes += 1
                if aPushes > 100 {
                    break
                }
            }

            if machineTokens != Int.max {
                tokens += machineTokens
            }
        }

        return tokens
    }

    func B() -> Int {
        return -1
    }
}
