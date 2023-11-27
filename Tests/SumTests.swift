import XCTest
import sandbox


class SumTests : XCTestCase {
    func testSum() {
        // Arrange
        let sum = Sum()
        let nr1 = 1
        let nr2 = 2
        let expectedResult = 3

        // Act
        let result = sum.sum(i: nr1, j: nr2)

        // Assert
        XCTAssertEqual(expectedResult, result)
    }
}