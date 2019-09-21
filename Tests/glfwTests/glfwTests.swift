import XCTest
@testable import glfw
import glm

final class glfwTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(glfw().text, "Hello, World!")
        let a = vec2(2)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
