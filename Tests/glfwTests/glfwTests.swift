import XCTest
@testable import glfw_
import glfwNative
import glm

final class glfwTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(glfw().text, "Hello, World!")

        /* Initialize the library */
        guard glfw.initialize() else {
            return
        }

        /* Create a windowed mode window and its OpenGL context */
        let window = GlfwWindow(ivec2(640, 480), "Hello World")

        /* Make the window's context current */
        window.makeContextCurrent()

        var refresh = 60
        /* Loop until the user closes the window */
        while (!window.shouldClose && refresh > 0) {
            /* Render here */
//            glClear(GL_COLOR_BUFFER_BIT);

            /* Swap front and back buffers */
            window.swapBuffers()

            /* Poll for and process events */
            glfw.pollEvents()

            refresh -= 1
        }

        glfw.terminate()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
