public struct Day19 {
    public func Run() {
        let data = "Inputs/day19.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        let workflows = generateWorkflows(strings: input.split(separator: "")[0])

        return 0
    }

    struct Workflow {
        var flows = [Character: Flow]()
    }

    struct Flow {
        var condition: (Int) -> Bool
        var next: String
    }

    private func generateWorkflows(strings: ArraySlice<String>) -> [Workflow] {
        strings.map { s in
            var parts = s.components(separatedBy: "{").dropLast()
            let workflowName = parts[0]
            let workflows = parts.split(separator: ":")
            let x = 0
        }

        return [Workflow]()
    }

    public func LogicB(input _: [String]) -> Int {
        0
    }
}
