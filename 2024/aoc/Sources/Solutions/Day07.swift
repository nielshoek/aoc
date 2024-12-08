class Day07 {
    func A() -> Int {
        var arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day07.txt")

        let lines = arr.map {
            let parts = $0.split(separator: try! Regex(":? "))
            return (value: Int(parts[0])!, numbers: parts[1...].map { Int($0)! })
        }
        
        var result = 0
        for line in lines {
            if backtrack(line.value, line.numbers, 1, line.numbers[0]) {
                result += line.value
            }
        }
        
        return result
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
            backtrack(value, nums, index + 1, acc * nums[index])
    }
}