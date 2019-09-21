import XCTest

import glfwTests

var tests = [XCTestCaseEntry]()
tests += glfwTests.allTests()
XCTMain(tests)
