import XCTest
@testable import WeatherCore

final class WeatherCoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WeatherCore().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
