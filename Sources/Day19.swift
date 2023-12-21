public struct Day19 {
    public func Run() {
        let data = "Inputs/day19.txt".ToStringArray()
        print("Part 1: \(LogicA(input: data))")
        print("Part 2: \(LogicB(input: data))")
    }

    public func LogicA(input: [String]) -> Int {
        let workflows = generateWorkflows(strings: input.split(separator: "")[0])
        let parts = generateParts(strings: input.split(separator: "")[1])
        var acceptedParts = [Part]()

        partsLabel: for part in parts {
            var key = "in"
            flows: while let wflow = workflows[key] {
                for flow in wflow.flows {
                    let flow = flow.flow
                    if let char = flow.char {
                        let charValue = part.values[char]
                        let satisfies = flow.condition(charValue!)
                        if satisfies {
                            if flow.next == "A" {
                                acceptedParts.append(part)
                                continue partsLabel
                            } else if flow.next == "R" {
                                continue partsLabel
                            } else {
                                key = flow.next
                                continue flows
                            }
                        }
                    } else {
                        if flow.next == "A" {
                            acceptedParts.append(part)
                            continue partsLabel
                        } else if flow.next == "R" {
                            continue partsLabel
                        } else {
                            key = flow.next
                            continue flows
                        }
                    }
                }
            }
        }

        return acceptedParts.reduce(0) { $0 + $1.values.values.reduce(0, +) }
    }

    struct Workflow {
        let name: String
        let flows: [(char: Character?, flow: Flow)]
    }

    struct Flow {
        let char: Character?
        let condition: (Int) -> Bool
        let next: String
    }

    struct Part {
        let values: [Character: Int]
    }

    private func generateWorkflows(strings: ArraySlice<String>) -> [String: Workflow] {
        return strings.map { s in
            let parts = s.dropLast().components(separatedBy: "{")
            let workflowName = parts[0]
            let flowsString = parts[1].split(separator: ",")
            let flows = flowsString.map { flow in
                let flowParts = flow.components(separatedBy: ":")
                if flowParts.count == 1 {
                    return Flow(char: nil,
                                condition: { _ in true },
                                next: String(flowParts[0]))
                }
                var char: Character = " "
                var condition: (Int) -> Bool = { _ in false }
                if flowParts[0].contains("<") {
                    char = Character(String(flowParts[0].split(separator: "<")[0]))
                    let otherNr = flowParts[0].split(separator: "<")[1]
                    condition = { nr in
                        nr < Int(otherNr)!
                    }
                } else if flowParts[0].contains(">") {
                    let ss = String(flowParts[0].split(separator: ">")[0])
                    char = Character(ss)
                    let otherNr = flowParts[0].split(separator: ">")[1]
                    condition = { nr in
                        nr > Int(otherNr)!
                    }
                }
                let next = String(flowParts[1])
                return Flow(char: char, condition: condition, next: next)
            }

            return Workflow(name: workflowName,
                            flows: flows.map { (char: $0.char, flow: $0) })
        }.reduce(into: [String: Workflow]()) { acc, cur in acc[cur.name] = cur }
    }

    private func generateParts(strings: ArraySlice<String>) -> [Part] {
        return strings.map { s in
            let parts = s.dropFirst().dropLast().components(separatedBy: ",")
            let values = parts.reduce(into: [Character: Int]()) { acc, cur in
                let char = Character(String(cur[0]))
                let value = Int(cur.components(separatedBy: "=")[1])
                acc[char] = value
            }

            return Part(values: values)
        }
    }

    public func LogicB(input _: [String]) -> Int {
        0
    }
}
