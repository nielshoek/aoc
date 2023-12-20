// let test = [
//     "#####", // 1
//     "#...#", // 2
//     "#...#", // 3
//     "###.#", // 4
//     "..###", // 5
// ] // 12345

let test = [
    "R 6 (#70c710)",
    "D 5 (#0dc571)",
    "L 2 (#5713f0)",
    "D 2 (#d2c081)",
    "R 2 (#59c680)",
    "D 2 (#411b91)",
    "L 5 (#8ceee2)",
    "U 2 (#caa173)",
    "L 1 (#1b58a2)",
    "U 2 (#caa171)",
    "R 2 (#7807d2)",
    "U 3 (#a77fa3)",
    "L 2 (#015232)",
    "U 2 (#7a21e3)",
]

public struct Day18 {
    public func Run() {
        let data = "Inputs/day18.txt".ToStringArray()
        print("Part TEST: \(LogicA(input: test))")
        // print("Part 1: \(LogicA(input: data))")
        // print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        let grid = input.map([Character].init)
        grid.printCompact()

        return 0
    }

    public func LogicB(input _: [String]) -> Int {
        0
    }

    struct Polygon {
        struct PointP {
            var x: Double
            var y: Double
        }

        var points: [PointP]

        var area: Double {
            let xx = points.map { $0.x }
            let yy = points.map { $0.y }
            let overlace = zip(xx, yy.dropFirst() + yy.prefix(1)).map { $0.0 * $0.1 }.reduce(0, +)
            let underlace = zip(yy, xx.dropFirst() + xx.prefix(1)).map { $0.0 * $0.1 }.reduce(0, +)

            return abs(overlace - underlace) / 2
        }

        init(points: [PointP]) {
            self.points = points
        }

        init(points: [(Double, Double)]) {
            self.init(points: points.map { PointP(x: $0.0, y: $0.1) })
        }
    }
}
