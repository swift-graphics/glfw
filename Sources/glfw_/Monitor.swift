//
// Created by elect on 24/09/19.
//

import Foundation
import glfwNative
import glm


extension glfw.Monitor {

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
    var pos: ivec2 {
        var x: Int32 = 0
        var y: Int32 = 0
        glfwGetMonitorPos(self, &x, &y)
        return ivec2(x, y)
    }

    /*  @brief Returns the physical size of the monitor.
     *
     *  This function returns the size, in millimetres, of the display area of the
     *  specified monitor.
     *
     *  Some systems do not provide accurate monitor size information, either
     *  because the monitor
     *  [EDID](https://en.wikipedia.org/wiki/Extended_display_identification_data)
     *  data is incorrect or because the driver does not report it accurately.
     *
     *  Any or all of the size arguments may be `NULL`.  If an error occurs, all
     *  non-`NULL` size arguments will be set to zero.
     *
     *  @param[in] monitor The monitor to query.
     *  @param[out] widthMM Where to store the width, in millimetres, of the
     *  monitor's display area, or `NULL`.
     *  @param[out] heightMM Where to store the height, in millimetres, of the
     *  monitor's display area, or `NULL`.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @remark @win32 calculates the returned physical size from the
     *  current resolution and system DPI instead of querying the monitor EDID data.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref monitor_properties
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup monitor
     */
    var physicalSize: ivec2 {
        var x: Int32 = 0
        var y: Int32 = 0
        glfwGetMonitorPhysicalSize(self, &x, &y)
        return ivec2(x, y)
    }

    /*  @brief Returns the name of the specified monitor.
     *
     *  This function returns a human-readable name, encoded as UTF-8, of the
     *  specified monitor.  The name typically reflects the make and model of the
     *  monitor and is not guaranteed to be unique among the connected monitors.
     *
     *  @param[in] monitor The monitor to query.
     *  @return The UTF-8 encoded name of the monitor, or `NULL` if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @pointer_lifetime The returned string is allocated and freed by GLFW.  You
     *  should not free it yourself.  It is valid until the specified monitor is
     *  disconnected or the library is terminated.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref monitor_properties
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup monitor
     */
    var name: String {
        String(utf8String: glfwGetMonitorName(self)!)!
    }

    /*  @brief Sets the monitor configuration callback.
     *
     *  This function sets the monitor configuration callback, or removes the
     *  currently set callback.  This is called when a monitor is connected to or
     *  disconnected from the system.
     *
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref monitor_event
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup monitor
     */
    func setCallback(cbfun: @escaping glfw.MonitorFun) {
        glfw.Monitor.monitorCB = cbfun
        glfwSetMonitorCallback { _, connected in
            glfw.Monitor.monitorCB!(connected == GLFW_CONNECTED)
        }
    }

    static var monitorCB: glfw.MonitorFun?

    /*  @brief Returns the available video modes for the specified monitor.
     *
     *  This function returns an array of all video modes supported by the specified
     *  monitor.  The returned array is sorted in ascending order, first by color
     *  bit depth (the sum of all channel depths) and then by resolution area (the
     *  product of width and height).
     *
     *  @param[in] monitor The monitor to query.
     *  @param[out] count Where to store the number of video modes in the returned
     *  array.  This is set to zero if an error occurred.
     *  @return An array of video modes, or `NULL` if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @pointer_lifetime The returned array is allocated and freed by GLFW.  You
     *  should not free it yourself.  It is valid until the specified monitor is
     *  disconnected, this function is called again for that monitor or the library
     *  is terminated.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref monitor_modes
     *  @sa glfwGetVideoMode
     *
     *  @since Added in version 1.0.
     *  @glfw3 Changed to return an array of modes for a specific monitor.
     *
     *  @ingroup monitor
     */
    var videoModes: [glfw.VidMode] {
        var count: Int32 = 0
        let modes = glfwGetVideoModes(self, &count)!
        return Array(UnsafeBufferPointer(start: modes, count: Int(count)))
    }

    /*  @brief Returns the current mode of the specified monitor.
     *
     *  This function returns the current video mode of the specified monitor.  If
     *  you have created a full screen window for that monitor, the return value
     *  will depend on whether that window is iconified.
     *
     *  @param[in] monitor The monitor to query.
     *  @return The current mode of the monitor, or `NULL` if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @pointer_lifetime The returned array is allocated and freed by GLFW.  You
     *  should not free it yourself.  It is valid until the specified monitor is
     *  disconnected or the library is terminated.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref monitor_modes
     *  @sa glfwGetVideoModes
     *
     *  @since Added in version 3.0.  Replaces `glfwGetDesktopMode`.
     *
     *  @ingroup monitor
     */
    var videoMode: glfw.VidMode {
        glfwGetVideoMode(self).pointee
    }

    func setGamma(gamma: Float) {
        /*  @brief Generates a gamma ramp and sets it for the specified monitor.
         *
         *  This function generates a 256-element gamma ramp from the specified exponent
         *  and then calls @ref glfwSetGammaRamp with it.  The value must be a finite
         *  number greater than zero.
         *
         *  @param[in] monitor The monitor whose gamma ramp to set.
         *  @param[in] gamma The desired exponent.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
         *  GLFW_INVALID_VALUE and @ref GLFW_PLATFORM_ERROR.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref monitor_gamma
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup monitor
         */
        glfwSetGamma(self, gamma)
    }

    var gammaRamp: glfw.GammaRamp {
        /*  @brief Returns the current gamma ramp for the specified monitor.
         *
         *  This function returns the current gamma ramp of the specified monitor.
         *
         *  @param[in] monitor The monitor to query.
         *  @return The current gamma ramp, or `NULL` if an
         *  [error](@ref error_handling) occurred.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @pointer_lifetime The returned structure and its arrays are allocated and
         *  freed by GLFW.  You should not free them yourself.  They are valid until the
         *  specified monitor is disconnected, this function is called again for that
         *  monitor or the library is terminated.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref monitor_gamma
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup monitor
         */
        get {
            glfwGetGammaRamp(self).pointee
        }
        /*  @brief Sets the current gamma ramp for the specified monitor.
         *
         *  This function sets the current gamma ramp for the specified monitor.  The
         *  original gamma ramp for that monitor is saved by GLFW the first time this
         *  function is called and is restored by @ref glfwTerminate.
         *
         *  @param[in] monitor The monitor whose gamma ramp to set.
         *  @param[in] ramp The gamma ramp to use.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @remark Gamma ramp sizes other than 256 are not supported by all platforms
         *  or graphics hardware.
         *
         *  @remark @win32 The gamma ramp size must be 256.
         *
         *  @pointer_lifetime The specified gamma ramp is copied before this function
         *  returns.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref monitor_gamma
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup monitor
         */
        set {
            var gamma = newValue
            glfwSetGammaRamp(self, &gamma)
        }
    }
}