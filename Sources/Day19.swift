import DequeModule

public struct Day19 {
    public func Run() {
        let data = "Inputs/day19.txt".ToStringArray()
        // print("Part 1: \(LogicA(input: data))")
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

    public func LogicB(input: [String]) -> Int {
        let workflows = generateWorkflows(strings: input.split(separator: "")[0])
        var acceptedRanges = [PartRanges]()

        let startRanges = PartRanges(x: 1 ... 4000, m: 1 ... 4000, a: 1 ... 4000, s: 1 ... 4000)
        var queue = Deque<(name: String, ranges: PartRanges)>(arrayLiteral: ("in", startRanges))
        while let (workflowName, ranges) = queue.popFirst() {
            if workflowName == "A" {
                acceptedRanges.append(ranges)
                continue
            }
            if workflowName == "R" {
                continue
            }

            let workflow = workflows[workflowName]!
            let flows = workflow.flows
            var ranges = ranges
            for (char, flow) in flows {
                switch char {
                case "x":
                    var xRange: ClosedRange<Int>
                    if flow.sign == "<" && ranges.x.lowerBound < flow.value {
                        xRange = ranges.x.lowerBound ... min(max(flow.value - 1, ranges.x.lowerBound), ranges.x.upperBound)
                        ranges.x = max(min(flow.value, ranges.x.upperBound), ranges.x.lowerBound) ... ranges.x.upperBound
                    } else if flow.sign == ">" {
                        xRange = max(min(flow.value + 1, ranges.x.upperBound), ranges.x.lowerBound) ... ranges.x.upperBound
                        ranges.x = ranges.x.lowerBound ... min(max(flow.value, ranges.x.lowerBound), ranges.x.upperBound)
                    } else {
                        continue
                    }
                    let newRanges = PartRanges(x: xRange,
                                               m: ranges.m,
                                               a: ranges.a,
                                               s: ranges.s)
                    queue.append((flow.next, newRanges))
                case "m":
                    var mRange: ClosedRange<Int>
                    if flow.sign == "<" && ranges.m.lowerBound < flow.value {
                        mRange = ranges.m.lowerBound ... min(max(flow.value - 1, ranges.m.lowerBound), ranges.m.upperBound)
                        ranges.m = max(min(flow.value, ranges.m.upperBound), ranges.m.lowerBound) ... ranges.m.upperBound
                    } else if flow.sign == ">" {
                        mRange = max(min(flow.value + 1, ranges.m.upperBound), ranges.m.lowerBound) ... ranges.m.upperBound
                        ranges.m = ranges.m.lowerBound ... min(max(flow.value, ranges.m.lowerBound), ranges.m.upperBound)
                    } else {
                        continue
                    }
                    let newRanges = PartRanges(x: ranges.x,
                                               m: mRange,
                                               a: ranges.a,
                                               s: ranges.s)
                    queue.append((flow.next, newRanges))
                case "a":
                    var aRange: ClosedRange<Int>
                    if flow.sign == "<" && ranges.a.lowerBound < flow.value {
                        aRange = ranges.a.lowerBound ... min(max(flow.value - 1, ranges.a.lowerBound), ranges.a.upperBound)
                        ranges.a = max(min(flow.value, ranges.a.upperBound), ranges.a.lowerBound) ... ranges.a.upperBound
                    } else if flow.sign == ">" {
                        aRange = max(min(flow.value + 1, ranges.a.upperBound), ranges.a.lowerBound) ... ranges.a.upperBound
                        ranges.a = ranges.a.lowerBound ... min(max(flow.value, ranges.a.lowerBound), ranges.a.upperBound)
                    } else {
                        continue
                    }
                    let newRanges = PartRanges(x: ranges.x,
                                               m: ranges.m,
                                               a: aRange,
                                               s: ranges.s)
                    queue.append((flow.next, newRanges))
                case "s":
                    var sRange: ClosedRange<Int>
                    if flow.sign == "<" && ranges.s.lowerBound < flow.value {
                        sRange = ranges.s.lowerBound ... min(max(flow.value - 1, ranges.s.lowerBound), ranges.s.upperBound)
                        ranges.s = max(min(flow.value, ranges.s.upperBound), ranges.s.lowerBound) ... ranges.s.upperBound
                    } else if flow.sign == ">" {
                        sRange = max(min(flow.value + 1, ranges.s.upperBound), ranges.s.lowerBound) ... ranges.s.upperBound
                        ranges.s = ranges.s.lowerBound ... min(max(flow.value, ranges.s.lowerBound), ranges.s.upperBound)
                    } else {
                        continue
                    }
                    let newRanges = PartRanges(x: ranges.x,
                                               m: ranges.m,
                                               a: ranges.a,
                                               s: sRange)
                    queue.append((flow.next, newRanges))
                default:
                    if flow.next != "A" || flow.next != "R" {
                        queue.append((flow.next, ranges))
                    } else if flow.sign == "A" {
                        acceptedRanges.append(ranges)
                    }
                }
            }
        }

        let uniqueRanges = acceptedRanges.unique
        let result = uniqueRanges.reduce(0) { acc, cur in
            acc + (cur.x.upperBound + 1 - cur.x.lowerBound)
                * (cur.m.upperBound + 1 - cur.m.lowerBound)
                * (cur.a.upperBound + 1 - cur.a.lowerBound)
                * (cur.s.upperBound + 1 - cur.s.lowerBound)
        }

        return result
        // 14372248406663
        // 131550418841958      C
        // 143722484066630
        // 126026760036084
    }

    struct PartRanges: Equatable {
        var x: ClosedRange<Int>
        var m: ClosedRange<Int>
        var a: ClosedRange<Int>
        var s: ClosedRange<Int>
    }

    struct Workflow {
        let name: String
        let flows: [(char: Character?, flow: Flow)]
    }

    struct Flow {
        let char: Character?
        let condition: (Int) -> Bool
        let next: String
        let sign: String
        let value: Int
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
                                next: String(flowParts[0]),
                                sign: "_",
                                value: 0)
                }
                var char: Character = " "
                var condition: (Int) -> Bool = { _ in false }
                var sign = ""
                var value: Int = -1
                if flowParts[0].contains("<") {
                    sign = "<"
                    char = Character(String(flowParts[0].split(separator: "<")[0]))
                    let otherNr = flowParts[0].split(separator: "<")[1]
                    value = Int(otherNr)!
                    condition = { nr in
                        nr < value
                    }
                } else if flowParts[0].contains(">") {
                    sign = ">"
                    char = Character(String(flowParts[0].split(separator: ">")[0]))
                    let otherNr = flowParts[0].split(separator: ">")[1]
                    value = Int(otherNr)!
                    condition = { nr in
                        nr > value
                    }
                }
                let next = String(flowParts[1])
                return Flow(char: char, condition: condition, next: next, sign: sign, value: value)
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
}

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
