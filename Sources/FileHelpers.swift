import Foundation

enum FileHelpers {
    static func ReadFileToString(path: String) -> String? {
        do {
            let contents = try String(contentsOfFile: path, encoding: .utf8)
            return contents
        } catch let error as NSError {
            print("Error reading input file: \(error)")
        }

        return nil
    }

    static func ReadFileToStringArray(path: String) -> [String] {
        let contents = ReadFileToString(path: path) ?? ""

        return contents.components(separatedBy: "\n")
    }
}

extension String {
    func ToStringArray() -> [String] {
        FileHelpers.ReadFileToStringArray(path: self)
    }

    func ToString() -> String {
        FileHelpers.ReadFileToString(path: self)!
    }
}
