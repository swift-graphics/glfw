//
// Created by elect on 24/09/19.
//

import Foundation
import glfwNative
import glm

/*  @brief Returns the position of the monitor's viewport on the virtual screen.
*
*  This function returns the position, in screen coordinates, of the upper-left
*  corner of the specified monitor.
*
*  Any or all of the position arguments may be `NULL`.  If an error occurs, all
*  non-`NULL` position arguments will be set to zero.
*
*  @param[in] monitor The monitor to query.
*  @param[out] xpos Where to store the monitor x-coordinate, or `NULL`.
*  @param[out] ypos Where to store the monitor y-coordinate, or `NULL`.
*
*  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
*  GLFW_PLATFORM_ERROR.
*
*  @thread_safety This function must only be called from the main thread.
*
*  @sa @ref monitor_properties
*
*  @since Added in version 3.0.
*
*  @ingroup monitor
*/
extension glfw.Monitor {
    var pos: ivec2 {
        var x: Int32 = 0
        var y: Int32 = 0
        glfwGetMonitorPos(self, &x, &y)
        return ivec2(x, y)
    }
}