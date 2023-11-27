import sandbox
import XCTest

class Day_1ATests: XCTestCase {
    func test1() {
        // Arrange
        let input = [1, 2, 3, 4, 5]
        let expectedResult = 4

        // Act
        let result = Day_1.LogicA(input: input)

        // Assert
        XCTAssertEqual(expectedResult, result)
    }

    func test2() {
        // Arrange
        let input = [1, 2, 2, 2, 2]
        let expectedResult = 1

        // Act
        let result = Day_1.LogicA(input: input)

        // Assert
        XCTAssertEqual(expectedResult, result)
    }

    func test3() {
        // Arrange
        let input = [1, 1]
        let expectedResult = 0

        // Act
        let result = Day_1.LogicA(input: input)

        // Assert
        XCTAssertEqual(expectedResult, result)
    }
}

class Day_1BTests: XCTestCase {
    func test1() {
        // Arrange
        let input = [1, 1, 1, 2, 3, 4]
        let expectedResult = 3

        // Act
        let result = Day_1.LogicB(input: input)

        // Assert
        XCTAssertEqual(expectedResult, result)
    }

    func test2() {
        // Arrange
        let input = [1, 1, 2, 1, 3, 4]
        let expectedResult = 2

        // Act
        let result = Day_1.LogicB(input: input)

        // Assert
        XCTAssertEqual(expectedResult, result)
    }
}
