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

        blocks = blocks.filter { $0 != -1 }

        var result = 0
        for i in 0..<blocks.count {
            result += (i * blocks[i])
        }

        return result
    }

    func B() -> Int {
        let line = Array(FileHelpers.ReadFileToString(path: "Sources/Inputs/day09.txt")!)
        var blocks = [Int]()
        var freeSpaces = [(size: Int, index: Int)]()
        var count = 0
        for i in 0..<line.count {
            let isFile = i % 2 == 0
            let val = line[i].wholeNumberValue!
            if isFile {
                blocks += [Int](repeating: i / 2, count: val)
            } else {
                blocks += [Int](repeating: -1, count: val)
                freeSpaces.append((val, count))
            }
            count += val
        }

        var r = blocks.count - 1
        while r > 0 {
            while r > 0, blocks[r] == -1 {
                r -= 1
            }
            let value = blocks[r]
            var fileSize = 0
            for i in stride(from: r, through: 0, by: -1) {
                if blocks[i] == value {
                    fileSize += 1
                } else {
                    break
                }
            }
            for (i, freeSpace) in freeSpaces.enumerated() {
                if freeSpace.size >= fileSize, freeSpace.index < r {
                    // Fill free space with value
                    for j in freeSpace.index..<freeSpace.index+fileSize {
                        blocks[j] = value
                    }
                    // Remove value at end
                    for j in stride(from: r, to: r-fileSize, by: -1) {
                        blocks[j] = -1
                    }

                    // If freeSpace not filled update the size and index
                    if freeSpace.size > fileSize {
                        freeSpaces[i] = (freeSpace.size - fileSize, freeSpace.index + fileSize)
                    } else {
                        freeSpaces.remove(at: i)
                    }
                    break
                }
            }
            
            r -= fileSize
        }

        var result = 0
        for i in 0..<blocks.count {
            if blocks[i] == -1 { continue }
            result += (i * blocks[i])
        }

        return result
    }
}
