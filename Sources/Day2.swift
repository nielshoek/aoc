public struct Day2 {
    let MAX_RED = 12
    let MAX_GREEN = 13
    let MAX_BLUE = 14

    public func Run() {
        let data = "Inputs/day2.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        var count = 0
        outerloop: for i in 0 ..< input.count {
            let line = input[i]
            let setsString = line.components(separatedBy: ": ")[1]
            let sets = setsString.components(separatedBy: "; ")
            for s in sets {
                let colors = s.components(separatedBy: ", ")
                for color in colors {
                    let parts = color.components(separatedBy: " ")
                    let amount = Int(parts[0])!
                    let color = parts[1]
                    switch color {
                    case "red":
                        if amount > MAX_RED {
                            continue outerloop
                        }
                    case "green":
                        if amount > MAX_GREEN {
                            continue outerloop
                        }
                    case "blue":
                        if amount > MAX_BLUE {
                            continue outerloop
                        }
                    default:
                        print("DEFAULT")
                    }
                }
            }
            count += i + 1
        }

        return count
    }

    public func LogicB(input: [String]) -> Int {
        var count = 0
        for i in 0 ..< input.count {
            var red = 0
            var green = 0
            var blue = 0
            let line = input[i]
            let setsString = line.components(separatedBy: ": ")[1]
            let sets = setsString.components(separatedBy: "; ")
            for s in sets {
                let colors = s.components(separatedBy: ", ")
                for color in colors {
                    let parts = color.components(separatedBy: " ")
                    let amount = Int(parts[0])!
                    let color = parts[1]
                    switch color {
                    case "red":
                        if amount > red {
                            red = amount
                        }
                    case "green":
                        if amount > green {
                            green = amount
                        }
                    case "blue":
                        if amount > blue {
                            blue = amount
                        }
                    default:
                        print("DEFAULT")
                    }
                }
            }
            count += red * green * blue
        }

        return count
    }
}
