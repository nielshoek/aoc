class Day07 {
    func A() -> Int {
        let lines = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day07.txt").map {
            let parts = $0.split(separator: try! Regex(":? "))
            return (value: Int(parts[0])!, numbers: parts[1...].map { Int($0)! })
        }

        return lines.reduce(0) { acc, line in
            acc + (backtrack(line.value, line.numbers, 1, line.numbers[0]) ? line.value : 0)
        }
    }
    
    func backtrack(_ value: Int, _ nums: [Int], _ index: Int, _ acc: Int) -> Bool {
        if acc == value {
            return true
        }
        if index == nums.count {
            return false
        }
        return 
            backtrack(value, nums, index + 1, acc + nums[index]) ||
            backtrack(value, nums, index + 1, acc * nums[index]) ||
            backtrack(value, nums, index + 1, Int(String(acc) + String(nums[index]))!)
    }
}