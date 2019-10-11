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
            String(cString: self)
        }
    }
}

extension Array {

    @inlinable public static func += (array: inout [Element], element: Element) {
        array.append(element)
    }
}

let GLFW_TRANSPARENT_FRAMEBUFFER: Int32 = 0x0002000A
let GLFW_HOVERED: Int32 = 0x0002000B
let GLFW_FOCUS_ON_SHOW: Int32 = 0x0002000C
let GLFW_LOCK_KEY_MODS: Int32 = 0x00033004
let GLFW_RAW_MOUSE_MOTION: Int32 = 0x00033005