public enum Day_1 {
    public static func Run(input _: [String]?) -> Int {
        let data = "Inputs/day1.txt".ToStringArray().map { Int($0)! }
        return Logic(input: data)
    }

    public static func Logic(input: [Int]) -> Int {
        var count = 0
        var previous = Int.max
        for element in input {
            if element > previous {
                count += 1
            }
            previous = element
        }

        return count
    }
}
