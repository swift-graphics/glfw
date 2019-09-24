//
// Created by elect on 22/09/19.
//

import Foundation
import glfwNative

extension Int32 {
    var asBool: Bool {
        get {
            self != 0
        }
    }
}

extension UnsafePointer where Pointee == Int8 {
    var asString: String {
        get {
            String(utf8String: self)!
        }
    }
}

var _g = glfw()

extension Array {

    @inlinable public static func += (array: inout [Element], element: Element) {
        array.append(element)
    }
}