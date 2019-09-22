import XCTest
@testable import glfw_
import glfwNative

final class glfwTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(glfw().text, "Hello, World!")
        if let a = glfwGetVersionString() {
            print(a)
        } else {
            print("null")
        }
        print(glfw.VERSION)
        print(glfw.initialize())
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
