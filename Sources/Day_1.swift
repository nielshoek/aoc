public enum Day_1 {
    public static func Run() -> Int {
        let data = "Inputs/day1.txt".ToStringArray().map { Int($0)! }
        return LogicB(input: data)
    }

    public static func LogicA(input: [Int]) -> Int {
        var count = 0
        for i in 0 ... input.count - 2 {
            if input[i + 1] > input[i] {
                count += 1
            }
        }

        return count
    }

    public static func LogicB(input: [Int]) -> Int {
        var count = 0
        for i in 0 ... input.count - 4 {
            let leftSum = input[i] + input[i + 1] + input[i + 2]
            let rightSum = input[i + 1] + input[i + 2] + input[i + 3]
            if rightSum > leftSum {
                count += 1
            }
        }

        return count
    }
}
