class Day09 {
    func A() -> Int {
        let line = Array(FileHelpers.ReadFileToString(path: "Sources/Inputs/day09.txt")!)
        var blocks = [Int]()
        for i in 0..<line.count {
            let isFile = i % 2 == 0
            let val = line[i].wholeNumberValue!
            if isFile {
                blocks += [Int](repeating: i / 2, count: val)
            } else {
                blocks += [Int](repeating: -1, count: val)
            }
        }
        var l = 0
        var r = blocks.count - 1
        while l < r {
            while blocks[l] != -1 {
                l += 1
            }
            while blocks[r] == -1 {
                r -= 1
            }
            if l < r {
                blocks.swapAt(l, r)
            }
        }

        print(blocks)
        blocks = blocks.filter { $0 != -1 }
        print(blocks)

        var result = 0
        for i in 0..<blocks.count {
            result += (i * blocks[i])
        }

        return result
    }
}