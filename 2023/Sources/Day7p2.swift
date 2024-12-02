import Foundation

extension Day7 {
    public func LogicB(input: [String]) -> Int {
        var hands = [Hand]()
        for line in input {
            hands.append(createHandFromB(line: line))
        }
        hands.sort { h1, h2 in
            if h1.typeStrength == h2.typeStrength {
                return h1.rawStrength < h2.rawStrength
            }
            return h1.typeStrength < h2.typeStrength
        }

        var count = 0
        for (i, hand) in hands.enumerated() {
            count += hand.bid * (i + 1)
        }

        return count
    }

    private func createHandFromB(line: String) -> Hand {
        let parts = line.components(separatedBy: " ")
        let cards = parts[0]
        let bid = Int(parts[1])!
        let chars = cards.map(Character.init)
        let initialTypeStrength = determineTypeStrengthWithoutJokers(
            chars: chars.filter { c in c != "J" })
        let nrOfJokers = chars.filter { c in c == "J" }.count
        let typeStrengthWithJokers = applyJokers(strength: initialTypeStrength,
                                                 nrOfJokers: nrOfJokers)
        let rawStrength = determineRawStrength(chars: chars)
        return Hand(cards: cards,
                    bid: bid,
                    typeStrength: typeStrengthWithJokers,
                    rawStrength: rawStrength)
    }

    fileprivate func applyJokers(strength: Int, nrOfJokers: Int) -> Int {
        if nrOfJokers == 5 || nrOfJokers == 4 {
            return 7
        }

        if nrOfJokers == 3 {
            if strength == 1 {
                return 6
            } else {
                return 7
            }
        }

        if nrOfJokers == 2 {
            if strength == 1 {
                return 4
            }
            if strength == 2 || strength == 3 {
                return 6
            }
            return 7
        }

        if nrOfJokers == 1 {
            if strength == 1 {
                return 2
            }
            if strength == 2 {
                return 4
            }
            if strength == 3 {
                return 5
            }
            if strength == 4 {
                return 6
            }
            if strength == 5 {
                return 6
            }
            return 7
        }

        return strength
    }

    // Five of a kind                | typeStrength: 7
    // Four of a kind                | typeStrength: 6
    // Full house AA111 (2/3 split)  | typeStrength: 5
    // Three of a kind               | typeStrength: 4
    // Two pair                      | typeStrength: 3
    // One pair                      | typeStrength: 2
    // High card (Nothing basically) | typeStrength: 1
    fileprivate func determineTypeStrengthWithoutJokers(chars: [Character]) -> Int {
        // Five of a kind
        if Set(chars).count == 1 {
            return 7
        }

        // High card
        if Set(chars).count == chars.count {
            return 1
        }

        let map = getCharacterMap(chars: chars)

        // Four of a kind
        if map.contains(where: { _, v in v == 4 }) {
            return 6
        }

        // Full House
        if map.contains(where: { _, v in v == 3 }), map.contains(where: { _, v in v == 2 }) {
            return 5
        }

        // Three of a kind
        if map.contains(where: { _, v in v == 3 }) {
            return 4
        }

        // Two pair
        if map.filter({ _, v in v == 2 }).count == 2 {
            return 3
        }

        // One pair
        if map.filter({ _, v in v == 2 }).count == 1 {
            return 2
        }

        return -1
    }

    private func determineRawStrength(chars: [Character]) -> Int {
        let hexString = chars.reduce(into: "") { acc, cur in
            if Int(String(cur)) != nil {
                return acc += String(cur)
            } else {
                switch cur {
                case "T":
                    return acc += "A"
                case "J":
                    return acc += "0"
                case "Q":
                    return acc += "C"
                case "K":
                    return acc += "D"
                case "A":
                    return acc += "E"
                default:
                    return acc += ""
                }
            }
        }

        return Int(hexString, radix: 16)!
    }

    private func getCharacterMap(chars: [Character]) -> [Character: Int] {
        var map = [Character: Int]()
        for c in chars {
            if let val = map[c] {
                map[c] = val + 1
            } else {
                map[c] = 1
            }
        }
        return map
    }
}
