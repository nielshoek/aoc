import Foundation

class Day08 {
    func A() -> Int {
        let grid = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day08.txt")
            .map(Array.init)

        var antennas = [Character: [(r: Int, c: Int)]]()

        for r in 0..<grid.count {
            for c in 0..<grid[0].count {
                if grid[r][c] == "." {
                    continue
                }
                antennas[grid[r][c], default: []].append((r, c))
            }
        }

        var antinodes = Set<[Int]>()

        for antennas in antennas.values {
            for i in 0..<antennas.count {
                let (r, c) = antennas[i]
                for j in (i+1)..<antennas.count {
                    let (otherR, otherC) = antennas[j]
                    let (deltaR1, deltaC1) = (otherR - r, otherC - c)
                    let (node1R, node1C) = (otherR + deltaR1, otherC + deltaC1)
                    if (0..<grid.count).contains(node1R), (0..<grid[0].count).contains(node1C) {
                        antinodes.insert([node1R, node1C])
                    }
                    let (deltaR2, deltaC2) = (r - otherR, c - otherC)
                    let (node2R, node2C) = (r + deltaR2, c + deltaC2)
                    if (0..<grid.count).contains(node2R), (0..<grid[0].count).contains(node2C) {
                        antinodes.insert([node2R, node2C])
                    }
                }
            }
        }

        return antinodes.count
    }

    func B() -> Int {
        let grid = FileHelpers.ReadFileToStringArray(path: "Sources/Inputs/day08.txt")
            .map(Array.init)

        var antennas = [Character: [(r: Int, c: Int)]]()
        var antinodes = Set<[Int]>()
        
        for r in 0..<grid.count {
            for c in 0..<grid[0].count {
                if grid[r][c] == "." {
                    continue
                }
                antennas[grid[r][c], default: []].append((r, c))
                antinodes.insert([r, c])
            }
        }

        for antennas in antennas.values {
            for i in 0..<antennas.count {
                let (r, c) = antennas[i]
                for j in (i+1)..<antennas.count {
                    let (otherR, otherC) = antennas[j]
                    
                    let (deltaR1, deltaC1) = (otherR - r, otherC - c)
                    var (node1R, node1C) = (otherR + deltaR1, otherC + deltaC1)
                    while (0..<grid.count).contains(node1R), (0..<grid[0].count).contains(node1C) {
                        antinodes.insert([node1R, node1C])
                        (node1R, node1C) = (node1R + deltaR1, node1C + deltaC1)
                    }

                    let (deltaR2, deltaC2) = (r - otherR, c - otherC)
                    var (node2R, node2C) = (r + deltaR2, c + deltaC2)
                    while (0..<grid.count).contains(node2R), (0..<grid[0].count).contains(node2C) {
                        antinodes.insert([node2R, node2C])
                        (node2R, node2C) = (node2R + deltaR2, node2C + deltaC2)
                    }
                }
            }
        }

        return antinodes.count
    }
}
