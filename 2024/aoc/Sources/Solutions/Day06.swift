class Day06 {
    func A() -> Int {
        let arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day06.txt")
            .map(Array.init)

        var pos = (r: 0, c: 0)
        outer: for r in 0..<arr.count {
            for c in 0..<arr[0].count {
                if arr[r][c] == "^" {
                    pos = (r, c)
                    break outer
                }
            }
        }

        let directions: [(rd: Int, cd: Int)] = [(-1, 0), (0, 1), (1, 0), (0, -1)]
        var dirIdx = 0
        var visitedPositions = Set<[Int]>()

        while (0..<arr.count).contains(pos.r), (0..<arr[0].count).contains(pos.c) {
            visitedPositions.insert([pos.r, pos.c])
            let dir = directions[dirIdx]
            let nextPos = (r: pos.r + dir.rd, c: pos.c + dir.cd)
            if !(0..<arr.count).contains(nextPos.r) || !(0..<arr[0].count).contains(nextPos.c) {
                break
            }

            if arr[nextPos.r][nextPos.c] != "#" {
                pos = nextPos
            } else {
                dirIdx = (dirIdx + 1) % directions.count
            }
        }

        return visitedPositions.count
    }

    func B() -> Int {
        var arr = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day06.txt")
            .map(Array.init)

        var pos = (r: 0, c: 0)
        outer: for r in 0..<arr.count {
            for c in 0..<arr[0].count {
                if arr[r][c] == "^" {
                    pos = (r, c)
                    break outer
                }
            }
        }

        let directions: [(rd: Int, cd: Int)] = [(-1, 0), (0, 1), (1, 0), (0, -1)]
        var dirIdx = 0

        var nrOfLoops = 0
        let startPosition = pos
        for r in 0..<arr.count {
            for c in 0..<arr[0].count {
                if arr[r][c] != "." {
                    continue
                }
                
                arr[r][c] = "#"

                var count = 0
                while (0..<arr.count).contains(pos.r), (0..<arr[0].count).contains(pos.c) {
                    let dir = directions[dirIdx]
                    let nextPos = (r: pos.r + dir.rd, c: pos.c + dir.cd)
                    if !(0..<arr.count).contains(nextPos.r)
                        || !(0..<arr[0].count).contains(nextPos.c)
                    {
                        break
                    }

                    if count > ((arr.count * arr[0].count) * 2) {
                        nrOfLoops += 1
                        break
                    }
                    count += 1

                    if arr[nextPos.r][nextPos.c] != "#" {
                        pos = nextPos
                    } else {
                        dirIdx = (dirIdx + 1) % directions.count
                    }
                }

                arr[r][c] = "."
                pos = startPosition
                dirIdx = 0

            }
        }

        return nrOfLoops
    }
}
