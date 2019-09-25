//
// Created by elect on 24/09/19.
//

import Foundation
import CoreFoundation
import glm
import glfwNative

open class GlfwWindow {

    var handle: glfw.Window

    /*  @brief Creates a window and its associated context.
     *
     *  This function creates a window and its associated OpenGL or OpenGL ES
     *  context.  Most of the options controlling how the window and its context
     *  should be created are specified with [window hints](@ref window_hints).
     *
     *  Successful creation does not change which context is current.  Before you
     *  can use the newly created context, you need to
     *  [make it current](@ref context_current).  For information about the `share`
     *  parameter, see @ref context_sharing.
     *
     *  The created window, framebuffer and context may differ from what you
     *  requested, as not all parameters and hints are
     *  [hard constraints](@ref window_hints_hard).  This includes the size of the
     *  window, especially for full screen windows.  To query the actual attributes
     *  of the created window, framebuffer and context, see @ref
     *  glfwGetWindowAttrib, @ref glfwGetWindowSize and @ref glfwGetFramebufferSize.
     *
     *  To create a full screen window, you need to specify the monitor the window
     *  will cover.  If no monitor is specified, the window will be windowed mode.
     *  Unless you have a way for the user to choose a specific monitor, it is
     *  recommended that you pick the primary monitor.  For more information on how
     *  to query connected monitors, see @ref monitor_monitors.
     *
     *  For full screen windows, the specified size becomes the resolution of the
     *  window's _desired video mode_.  As long as a full screen window is not
     *  iconified, the supported video mode most closely matching the desired video
     *  mode is set for the specified monitor.  For more information about full
     *  screen windows, including the creation of so called _windowed full screen_
     *  or _borderless full screen_ windows, see @ref window_windowed_full_screen.
     *
     *  Once you have created the window, you can switch it between windowed and
     *  full screen mode with @ref glfwSetWindowMonitor.  If the window has an
     *  OpenGL or OpenGL ES context, it will be unaffected.
     *
     *  By default, newly created windows use the placement recommended by the
     *  window system.  To create the window at a specific position, make it
     *  initially invisible using the [GLFW_VISIBLE](@ref window_hints_wnd) window
     *  hint, set its [position](@ref window_pos) and then [show](@ref window_hide)
     *  it.
     *
     *  As long as at least one full screen window is not iconified, the screensaver
     *  is prohibited from starting.
     *
     *  Window systems put limits on window sizes.  Very large or very small window
     *  dimensions may be overridden by the window system on creation.  Check the
     *  actual [size](@ref window_size) after creation.
     *
     *  The [swap interval](@ref buffer_swap) is not set during window creation and
     *  the initial value may vary depending on driver settings and defaults.
     *
     *  @param[in] width The desired width, in screen coordinates, of the window.
     *  This must be greater than zero.
     *  @param[in] height The desired height, in screen coordinates, of the window.
     *  This must be greater than zero.
     *  @param[in] title The initial, UTF-8 encoded window title.
     *  @param[in] monitor The monitor to use for full screen mode, or `NULL` for
     *  windowed mode.
     *  @param[in] share The window whose context to share resources with, or `NULL`
     *  to not share resources.
     *  @return The handle of the created window, or `NULL` if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_INVALID_ENUM, @ref GLFW_INVALID_VALUE, @ref GLFW_API_UNAVAILABLE, @ref
     *  GLFW_VERSION_UNAVAILABLE, @ref GLFW_FORMAT_UNAVAILABLE and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @remark @win32 Window creation will fail if the Microsoft GDI software
     *  OpenGL implementation is the only one available.
     *
     *  @remark @win32 If the executable has an icon resource named `GLFW_ICON,` it
     *  will be set as the initial icon for the window.  If no such icon is present,
     *  the `IDI_WINLOGO` icon will be used instead.  To set a different icon, see
     *  @ref glfwSetWindowIcon.
     *
     *  @remark @win32 The context to share resources with must not be current on
     *  any other thread.
     *
     *  @remark @osx The GLFW window has no icon, as it is not a document
     *  window, but the dock icon will be the same as the application bundle's icon.
     *  For more information on bundles, see the
     *  [Bundle Programming Guide](https://developer.apple.com/library/mac/documentation/CoreFoundation/Conceptual/CFBundles/)
     *  in the Mac Developer Library.
     *
     *  @remark @osx The first time a window is created the menu bar is populated
     *  with common commands like Hide, Quit and About.  The About entry opens
     *  a minimal about dialog with information from the application's bundle.  The
     *  menu bar can be disabled with a
     *  [compile-time option](@ref compile_options_osx).
     *
     *  @remark @osx On OS X 10.10 and later the window frame will not be rendered
     *  at full resolution on Retina displays unless the `NSHighResolutionCapable`
     *  key is enabled in the application bundle's `Info.plist`.  For more
     *  information, see
     *  [High Resolution Guidelines for OS X](https://developer.apple.com/library/mac/documentation/GraphicsAnimation/Conceptual/HighResolutionOSX/Explained/Explained.html)
     *  in the Mac Developer Library.  The GLFW test and example programs use
     *  a custom `Info.plist` template for this, which can be found as
     *  `CMake/MacOSXBundleInfo.plist.in` in the source tree.
     *
     *  @remark @x11 Some window managers will not respect the placement of
     *  initially hidden windows.
     *
     *  @remark @x11 Due to the asynchronous nature of X11, it may take a moment for
     *  a window to reach its requested state.  This means you may not be able to
     *  query the final size, position or other attributes directly after window
     *  creation.
     *
     *  @reentrancy This function must not be called from a callback.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_creation
     *  @sa glfwDestroyWindow
     *
     *  @since Added in version 3.0.  Replaces `glfwOpenWindow`.
     *
     *  @ingroup window
     */
    init(size: ivec2, title: String, monitor: glfw.Monitor?, share: GlfwWindow?) {
        handle = glfwCreateWindow(size.x, size.y, UnsafePointer(title), monitor, share?.handle)
    }

    /*  @brief Destroys the specified window and its context.
     *
     *  This function destroys the specified window and its context.  On calling
     *  this function, no further callbacks will be called for that window.
     *
     *  If the context of the specified window is current on the main thread, it is
     *  detached before being destroyed.
     *
     *  @param[in] window The window to destroy.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @note The context of the specified window must not be current on any other
     *  thread when this function is called.
     *
     *  @reentrancy This function must not be called from a callback.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_creation
     *  @sa glfwCreateWindow
     *
     *  @since Added in version 3.0.  Replaces `glfwCloseWindow`.
     *
     *  @ingroup window
     */
    func destroy() {
        glfwDestroyWindow(handle)
    }


    var shouldClose: Bool {
        /*  @brief Checks the close flag of the specified window.
         *
         *  This function returns the value of the close flag of the specified window.
         *
         *  @param[in] window The window to query.
         *  @return The value of the close flag.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
         *
         *  @thread_safety This function may be called from any thread.  Access is not
         *  synchronized.
         *
         *  @sa @ref window_close
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup window
         */
        get {
            glfwWindowShouldClose(handle) == GLFW_TRUE
        }
        /*  @brief Sets the close flag of the specified window.
         *
         *  This function sets the value of the close flag of the specified window.
         *  This can be used to override the user's attempt to close the window, or
         *  to signal that it should be closed.
         *
         *  @param[in] window The window whose flag to change.
         *  @param[in] value The new value.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
         *
         *  @thread_safety This function may be called from any thread.  Access is not
         *  synchronized.
         *
         *  @sa @ref window_close
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup window
         */
        set {
            glfwSetWindowShouldClose(handle, newValue ? GLFW_TRUE : GLFW_FALSE)
        }
    }

    /*  @brief Sets the title of the specified window.
     *
     *  This function sets the window title, encoded as UTF-8, of the specified
     *  window.
     *
     *  @param[in] window The window whose title to change.
     *  @param[in] title The UTF-8 encoded window title.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @remark @osx The window title will not be updated until the next time you
     *  process events.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_title
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup window
     */
    func setTitle(title: String) {
        glfwSetWindowTitle(handle, title)
    }

    /*  @brief Sets the icon for the specified window.
     *
     *  This function sets the icon of the specified window.  If passed an array of
     *  candidate images, those of or closest to the sizes desired by the system are
     *  selected.  If no images are specified, the window reverts to its default
     *  icon.
     *
     *  The desired image sizes varies depending on platform and system settings.
     *  The selected images will be rescaled as needed.  Good sizes include 16x16,
     *  32x32 and 48x48.
     *
     *  @param[in] window The window whose icon to set.
     *  @param[in] count The number of images in the specified array, or zero to
     *  revert to the default window icon.
     *  @param[in] images The images to create the icon from.  This is ignored if
     *  count is zero.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @pointer_lifetime The specified image data is copied before this function
     *  returns.
     *
     *  @remark @osx The GLFW window has no icon, as it is not a document
     *  window, so this function does nothing.  The dock icon will be the same as
     *  the application bundle's icon.  For more information on bundles, see the
     *  [Bundle Programming Guide](https://developer.apple.com/library/mac/documentation/CoreFoundation/Conceptual/CFBundles/)
     *  in the Mac Developer Library.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_icon
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup window
     */
    func setIcon(images: [glfw.Image]) {
        var im = images as [GLFWimage]
        glfwSetWindowIcon(handle, Int32(images.count), &im)
    }

    var pos: ivec2 {
        /*  @brief Retrieves the position of the client area of the specified window.
         *
         *  This function retrieves the position, in screen coordinates, of the
         *  upper-left corner of the client area of the specified window.
         *
         *  Any or all of the position arguments may be `NULL`.  If an error occurs, all
         *  non-`NULL` position arguments will be set to zero.
         *
         *  @param[in] window The window to query.
         *  @param[out] xpos Where to store the x-coordinate of the upper-left corner of
         *  the client area, or `NULL`.
         *  @param[out] ypos Where to store the y-coordinate of the upper-left corner of
         *  the client area, or `NULL`.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref window_pos
         *  @sa glfwSetWindowPos
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup window
         */
        get {
            var x: Int32 = 0
            var y: Int32 = 0
            glfwGetWindowPos(handle, &x, &y)
            return ivec2(x, y)
        }
        /*  @brief Sets the position of the client area of the specified window.
         *
         *  This function sets the position, in screen coordinates, of the upper-left
         *  corner of the client area of the specified windowed mode window.  If the
         *  window is a full screen window, this function does nothing.
         *
         *  __Do not use this function__ to move an already visible window unless you
         *  have very good reasons for doing so, as it will confuse and annoy the user.
         *
         *  The window manager may put limits on what positions are allowed.  GLFW
         *  cannot and should not override these limits.
         *
         *  @param[in] window The window to query.
         *  @param[in] xpos The x-coordinate of the upper-left corner of the client area.
         *  @param[in] ypos The y-coordinate of the upper-left corner of the client area.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref window_pos
         *  @sa glfwGetWindowPos
         *
         *  @since Added in version 1.0.
         *  @glfw3 Added window handle parameter.
         *
         *  @ingroup window
         */
        set {
            glfwSetWindowPos(handle, newValue.x, newValue.y)
        }
    }

    var size: ivec2 {
        /*  @brief Retrieves the size of the client area of the specified window.
         *
         *  This function retrieves the size, in screen coordinates, of the client area
         *  of the specified window.  If you wish to retrieve the size of the
         *  framebuffer of the window in pixels, see @ref glfwGetFramebufferSize.
         *
         *  Any or all of the size arguments may be `NULL`.  If an error occurs, all
         *  non-`NULL` size arguments will be set to zero.
         *
         *  @param[in] window The window whose size to retrieve.
         *  @param[out] width Where to store the width, in screen coordinates, of the
         *  client area, or `NULL`.
         *  @param[out] height Where to store the height, in screen coordinates, of the
         *  client area, or `NULL`.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref window_size
         *  @sa glfwSetWindowSize
         *
         *  @since Added in version 1.0.
         *  @glfw3 Added window handle parameter.
         *
         *  @ingroup window
         */
        get {
            var x: Int32 = 0
            var y: Int32 = 0
            glfwGetWindowSize(handle, &x, &y)
            return ivec2(x, y)
        }
        /*  @brief Sets the size of the client area of the specified window.
         *
         *  This function sets the size, in screen coordinates, of the client area of
         *  the specified window.
         *
         *  For full screen windows, this function updates the resolution of its desired
         *  video mode and switches to the video mode closest to it, without affecting
         *  the window's context.  As the context is unaffected, the bit depths of the
         *  framebuffer remain unchanged.
         *
         *  If you wish to update the refresh rate of the desired video mode in addition
         *  to its resolution, see @ref glfwSetWindowMonitor.
         *
         *  The window manager may put limits on what sizes are allowed.  GLFW cannot
         *  and should not override these limits.
         *
         *  @param[in] window The window to resize.
         *  @param[in] width The desired width, in screen coordinates, of the window
         *  client area.
         *  @param[in] height The desired height, in screen coordinates, of the window
         *  client area.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref window_size
         *  @sa glfwGetWindowSize
         *  @sa glfwSetWindowMonitor
         *
         *  @since Added in version 1.0.
         *  @glfw3 Added window handle parameter.
         *
         *  @ingroup window
         */
        set {
            glfwSetWindowSize(handle, newValue.x, newValue.y)
        }
    }

    /*  @brief Sets the size limits of the specified window.
     *
     *  This function sets the size limits of the client area of the specified
     *  window.  If the window is full screen, the size limits only take effect
     *  once it is made windowed.  If the window is not resizable, this function
     *  does nothing.
     *
     *  The size limits are applied immediately to a windowed mode window and may
     *  cause it to be resized.
     *
     *  The maximum dimensions must be greater than or equal to the minimum
     *  dimensions and all must be greater than or equal to zero.
     *
     *  @param[in] window The window to set limits for.
     *  @param[in] minwidth The minimum width, in screen coordinates, of the client
     *  area, or `GLFW_DONT_CARE`.
     *  @param[in] minheight The minimum height, in screen coordinates, of the
     *  client area, or `GLFW_DONT_CARE`.
     *  @param[in] maxwidth The maximum width, in screen coordinates, of the client
     *  area, or `GLFW_DONT_CARE`.
     *  @param[in] maxheight The maximum height, in screen coordinates, of the
     *  client area, or `GLFW_DONT_CARE`.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_INVALID_VALUE and @ref GLFW_PLATFORM_ERROR.
     *
     *  @remark If you set size limits and an aspect ratio that conflict, the
     *  results are undefined.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_sizelimits
     *  @sa glfwSetWindowAspectRatio
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup window
     */
    func setSizeLimits(minSize: ivec2, maxSize: ivec2) {
        glfwSetWindowSizeLimits(handle, minSize.x, minSize.y, maxSize.x, maxSize.y)
    }

    /*  @brief Sets the aspect ratio of the specified window.
     *
     *  This function sets the required aspect ratio of the client area of the
     *  specified window.  If the window is full screen, the aspect ratio only takes
     *  effect once it is made windowed.  If the window is not resizable, this
     *  function does nothing.
     *
     *  The aspect ratio is specified as a numerator and a denominator and both
     *  values must be greater than zero.  For example, the common 16:9 aspect ratio
     *  is specified as 16 and 9, respectively.
     *
     *  If the numerator and denominator is set to `GLFW_DONT_CARE` then the aspect
     *  ratio limit is disabled.
     *
     *  The aspect ratio is applied immediately to a windowed mode window and may
     *  cause it to be resized.
     *
     *  @param[in] window The window to set limits for.
     *  @param[in] numer The numerator of the desired aspect ratio, or
     *  `GLFW_DONT_CARE`.
     *  @param[in] denom The denominator of the desired aspect ratio, or
     *  `GLFW_DONT_CARE`.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_INVALID_VALUE and @ref GLFW_PLATFORM_ERROR.
     *
     *  @remark If you set size limits and an aspect ratio that conflict, the
     *  results are undefined.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_sizelimits
     *  @sa glfwSetWindowSizeLimits
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup window
     */
    func setAspectRatio(numer: Int32, denom: Int32) {
        glfwSetWindowAspectRatio(handle, numer, denom)
    }

    /*  @brief Retrieves the size of the framebuffer of the specified window.
     *
     *  This function retrieves the size, in pixels, of the framebuffer of the
     *  specified window.  If you wish to retrieve the size of the window in screen
     *  coordinates, see @ref glfwGetWindowSize.
     *
     *  Any or all of the size arguments may be `NULL`.  If an error occurs, all
     *  non-`NULL` size arguments will be set to zero.
     *
     *  @param[in] window The window whose framebuffer to query.
     *  @param[out] width Where to store the width, in pixels, of the framebuffer,
     *  or `NULL`.
     *  @param[out] height Where to store the height, in pixels, of the framebuffer,
     *  or `NULL`.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_fbsize
     *  @sa glfwSetFramebufferSizeCallback
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    var framebufferSize: ivec2 {
        var x: Int32 = 0
        var y: Int32 = 0
        glfwGetFramebufferSize(handle, &x, &y)
        return ivec2(x, y)
    }

    /*  @brief Retrieves the size of the frame of the window.
     *
     *  This function retrieves the size, in screen coordinates, of each edge of the
     *  frame of the specified window.  This size includes the title bar, if the
     *  window has one.  The size of the frame may vary depending on the
     *  [window-related hints](@ref window_hints_wnd) used to create it.
     *
     *  Because this function retrieves the size of each window frame edge and not
     *  the offset along a particular coordinate axis, the retrieved values will
     *  always be zero or positive.
     *
     *  Any or all of the size arguments may be `NULL`.  If an error occurs, all
     *  non-`NULL` size arguments will be set to zero.
     *
     *  @param[in] window The window whose frame size to query.
     *  @param[out] left Where to store the size, in screen coordinates, of the left
     *  edge of the window frame, or `NULL`.
     *  @param[out] top Where to store the size, in screen coordinates, of the top
     *  edge of the window frame, or `NULL`.
     *  @param[out] right Where to store the size, in screen coordinates, of the
     *  right edge of the window frame, or `NULL`.
     *  @param[out] bottom Where to store the size, in screen coordinates, of the
     *  bottom edge of the window frame, or `NULL`.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_size
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup window
     */
    var frameSize: (Int32, Int32, Int32, Int32) {
        var left: Int32 = 0
        var top: Int32 = 0
        var right: Int32 = 0
        var bottom: Int32 = 0
        glfwGetWindowFrameSize(handle, &left, &top, &right, &bottom)
        return (left, top, right, bottom)
    }

    /*  @brief Iconifies the specified window.
     *
     *  This function iconifies (minimizes) the specified window if it was
     *  previously restored.  If the window is already iconified, this function does
     *  nothing.
     *
     *  If the specified window is a full screen window, the original monitor
     *  resolution is restored until the window is restored.
     *
     *  @param[in] window The window to iconify.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_iconify
     *  @sa glfwRestoreWindow
     *  @sa glfwMaximizeWindow
     *
     *  @since Added in version 2.1.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup window
     */
    func iconify() {
        glfwIconifyWindow(handle)
    }

    /*  @brief Restores the specified window.
     *
     *  This function restores the specified window if it was previously iconified
     *  (minimized) or maximized.  If the window is already restored, this function
     *  does nothing.
     *
     *  If the specified window is a full screen window, the resolution chosen for
     *  the window is restored on the selected monitor.
     *
     *  @param[in] window The window to restore.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_iconify
     *  @sa glfwIconifyWindow
     *  @sa glfwMaximizeWindow
     *
     *  @since Added in version 2.1.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup window
     */
    func restore() {
        glfwRestoreWindow(handle)
    }

    /*  @brief Maximizes the specified window.
     *
     *  This function maximizes the specified window if it was previously not
     *  maximized.  If the window is already maximized, this function does nothing.
     *
     *  If the specified window is a full screen window, this function does nothing.
     *
     *  @param[in] window The window to maximize.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @par Thread Safety
     *  This function may only be called from the main thread.
     *
     *  @sa @ref window_iconify
     *  @sa glfwIconifyWindow
     *  @sa glfwRestoreWindow
     *
     *  @since Added in GLFW 3.2.
     *
     *  @ingroup window
     */
    func maximize() {
        glfwMaximizeWindow(handle)
    }

    /*  @brief Makes the specified window visible.
     *
     *  This function makes the specified window visible if it was previously
     *  hidden.  If the window is already visible or is in full screen mode, this
     *  function does nothing.
     *
     *  @param[in] window The window to make visible.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_hide
     *  @sa glfwHideWindow
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    func show() {
        glfwShowWindow(handle)
    }

    /*  @brief Hides the specified window.
     *
     *  This function hides the specified window if it was previously visible.  If
     *  the window is already hidden or is in full screen mode, this function does
     *  nothing.
     *
     *  @param[in] window The window to hide.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_hide
     *  @sa glfwShowWindow
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    func hide() {
        glfwHideWindow(handle)
    }

    /*  @brief Brings the specified window to front and sets input focus.
     *
     *  This function brings the specified window to front and sets input focus.
     *  The window should already be visible and not iconified.
     *
     *  By default, both windowed and full screen mode windows are focused when
     *  initially created.  Set the [GLFW_FOCUSED](@ref window_hints_wnd) to disable
     *  this behavior.
     *
     *  __Do not use this function__ to steal focus from other applications unless
     *  you are certain that is what the user wants.  Focus stealing can be
     *  extremely disruptive.
     *
     *  @param[in] window The window to give input focus.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_focus
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup window
     */
    func focus() {
        glfwFocusWindow(handle)
    }

    /*  @brief Returns the monitor that the window uses for full screen mode.
     *
     *  This function returns the handle of the monitor that the specified window is
     *  in full screen on.
     *
     *  @param[in] window The window to query.
     *  @return The monitor, or `NULL` if the window is in windowed mode or an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_monitor
     *  @sa glfwSetWindowMonitor
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    var monitor: glfw.Monitor {
        glfwGetWindowMonitor(handle)
    }

    /*  @brief Sets the mode, monitor, video mode and placement of a window.
     *
     *  This function sets the monitor that the window uses for full screen mode or,
     *  if the monitor is `NULL`, makes it windowed mode.
     *
     *  When setting a monitor, this function updates the width, height and refresh
     *  rate of the desired video mode and switches to the video mode closest to it.
     *  The window position is ignored when setting a monitor.
     *
     *  When the monitor is `NULL`, the position, width and height are used to
     *  place the window client area.  The refresh rate is ignored when no monitor
     *  is specified.
     *
     *  If you only wish to update the resolution of a full screen window or the
     *  size of a windowed mode window, see @ref glfwSetWindowSize.
     *
     *  When a window transitions from full screen to windowed mode, this function
     *  restores any previous window settings such as whether it is decorated,
     *  floating, resizable, has size or aspect ratio limits, etc..
     *
     *  @param[in] window The window whose monitor, size or video mode to set.
     *  @param[in] monitor The desired monitor, or `NULL` to set windowed mode.
     *  @param[in] xpos The desired x-coordinate of the upper-left corner of the
     *  client area.
     *  @param[in] ypos The desired y-coordinate of the upper-left corner of the
     *  client area.
     *  @param[in] width The desired with, in screen coordinates, of the client area
     *  or video mode.
     *  @param[in] height The desired height, in screen coordinates, of the client
     *  area or video mode.
     *  @param[in] refreshRate The desired refresh rate, in Hz, of the video mode,
     *  or `GLFW_DONT_CARE`.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_monitor
     *  @sa @ref window_full_screen
     *  @sa glfwGetWindowMonitor
     *  @sa glfwSetWindowSize
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup window
     */
    func setMonitor(monitor: glfw.Monitor, pos: ivec2, size: ivec2, refreshRate: Int32) {
        glfwSetWindowMonitor(handle, monitor, pos.x, pos.y, size.x, size.y, refreshRate)
    }

    /*  @brief Returns an attribute of the specified window.
     *
     *  This function returns the value of an attribute of the specified window or
     *  its OpenGL or OpenGL ES context.
     *
     *  @param[in] window The window to query.
     *  @param[in] attrib The [window attribute](@ref window_attribs) whose value to
     *  return.
     *  @return The value of the attribute, or zero if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_INVALID_ENUM and @ref GLFW_PLATFORM_ERROR.
     *
     *  @remark Framebuffer related hints are not window attributes.  See @ref
     *  window_attribs_fb for more information.
     *
     *  @remark Zero is a valid value for many window and context related
     *  attributes so you cannot use a return value of zero as an indication of
     *  errors.  However, this function should not fail as long as it is passed
     *  valid arguments and the library has been [initialized](@ref intro_init).
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_attribs
     *
     *  @since Added in version 3.0.  Replaces `glfwGetWindowParam` and
     *  `glfwGetGLVersion`.
     *
     *  @ingroup window
     */
//    GLFWAPI int glfwGetWindowAttrib(GLFWwindow* window, int attrib);

    var focused: Bool {
        glfwGetWindowAttrib(handle, GLFW_FOCUSED) == GLFW_TRUE
    }

    var iconified: Bool {
        get {
            glfwGetWindowAttrib(handle, GLFW_ICONIFIED) == GLFW_TRUE
        }
        set {
            newValue ? iconify() : restore()
        }
    }

    var maximized: Bool {
        get {
            glfwGetWindowAttrib(handle, GLFW_MAXIMIZED) == GLFW_TRUE
        }
        set {
            newValue ? maximize() : restore()
        }
    }

    var hovered: Bool {
        glfwGetWindowAttrib(handle, GLFW_HOVERED) == GLFW_TRUE
    }

    var visible: Bool {
        get {
            glfwGetWindowAttrib(handle, GLFW_VISIBLE) == GLFW_TRUE
        }
        set {
            newValue ? show() : hide()
        }
    }

    var resizable: Bool {
        get {
            glfwGetWindowAttrib(handle, GLFW_RESIZABLE) == GLFW_TRUE
        }
        set {
            fatalError()//glfwSetWindowAttrib TODO
        }
    }

    var decorated: Bool {
        get {
            glfwGetWindowAttrib(handle, GLFW_DECORATED) == GLFW_TRUE
        }
        set {
            fatalError()//glfwSetWindowAttrib TODO
        }
    }

    var autoIconify: Bool {
        get {
            glfwGetWindowAttrib(handle, GLFW_AUTO_ICONIFY) == GLFW_TRUE
        }
        set {
            fatalError()//glfwSetWindowAttrib TODO
        }
    }

    var floating: Bool {
        get {
            glfwGetWindowAttrib(handle, GLFW_FLOATING) == GLFW_TRUE
        }
        set {
            fatalError()//glfwSetWindowAttrib TODO
        }
    }

    var transparentFramebuffer: Bool {
        glfwGetWindowAttrib(handle, GLFW_TRANSPARENT_FRAMEBUFFER) == GLFW_TRUE
    }

    var focusOnShow: Bool {
        get {
            glfwGetWindowAttrib(handle, GLFW_FOCUS_ON_SHOW) == GLFW_TRUE
        }
        set {
            fatalError()//glfwSetWindowAttrib TODO
        }
    }

    var userPoint: UnsafeMutableRawPointer {
        /*  @brief Sets the user pointer of the specified window.
         *
         *  This function sets the user-defined pointer of the specified window.  The
         *  current value is retained until the window is destroyed.  The initial value
         *  is `NULL`.
         *
         *  @param[in] window The window whose pointer to set.
         *  @param[in] pointer The new value.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
         *
         *  @thread_safety This function may be called from any thread.  Access is not
         *  synchronized.
         *
         *  @sa @ref window_userptr
         *  @sa glfwGetWindowUserPointer
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup window
         */
        set {
            glfwSetWindowUserPointer(handle, newValue)
        }

        /*  @brief Returns the user pointer of the specified window.
         *
         *  This function returns the current value of the user-defined pointer of the
         *  specified window.  The initial value is `NULL`.
         *
         *  @param[in] window The window whose pointer to return.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
         *
         *  @thread_safety This function may be called from any thread.  Access is not
         *  synchronized.
         *
         *  @sa @ref window_userptr
         *  @sa glfwSetWindowUserPointer
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup window
         */
        get {
            glfwGetWindowUserPointer(handle)
        }
    }

    /*  @brief Sets the position callback for the specified window.
     *
     *  This function sets the position callback of the specified window, which is
     *  called when the window is moved.  The callback is provided with the screen
     *  position of the upper-left corner of the client area of the window.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_pos
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    func setPosCallback(cbfun: @escaping glfw.WindowPosFun) {
        GlfwWindow.posCB[handle] = cbfun
        glfwSetWindowPosCallback(handle) { handle, x, y in
            GlfwWindow.posCB[handle!]!(ivec2(x, y))
        }
    }

    static var posCB = Dictionary<glfw.Window, glfw.WindowPosFun>()

    /*  @brief Sets the size callback for the specified window.
     *
     *  This function sets the size callback of the specified window, which is
     *  called when the window is resized.  The callback is provided with the size,
     *  in screen coordinates, of the client area of the window.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_size
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle parameter and return value.
     *
     *  @ingroup window
     */
    func setSizeCallback(cbfun: @escaping glfw.WindowSizeFun) {
        GlfwWindow.sizeCB[handle] = cbfun
        glfwSetWindowSizeCallback(handle) { handle, x, y in
            GlfwWindow.sizeCB[handle!]!(ivec2(x, y))
        }
    }

    static var sizeCB = Dictionary<glfw.Window, glfw.WindowSizeFun>()

    /*  @brief Sets the refresh callback for the specified window.
     *
     *  This function sets the refresh callback of the specified window, which is
     *  called when the client area of the window needs to be redrawn, for example
     *  if the window has been exposed after having been covered by another window.
     *
     *  On compositing window systems such as Aero, Compiz or Aqua, where the window
     *  contents are saved off-screen, this callback may be called only very
     *  infrequently or never at all.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_refresh
     *
     *  @since Added in version 2.5.
     *  @glfw3 Added window handle parameter and return value.
     *
     *  @ingroup window
     */
    func setRefreshCallback(cbfun: @escaping glfw.WindowRefreshFun) {
        GlfwWindow.refreshCB[handle] = cbfun
        glfwSetWindowRefreshCallback(handle) { handle in
            GlfwWindow.refreshCB[handle!]!()
        }
    }

    static var refreshCB = Dictionary<glfw.Window, glfw.WindowRefreshFun>()

    /*  @brief Sets the focus callback for the specified window.
     *
     *  This function sets the focus callback of the specified window, which is
     *  called when the window gains or loses input focus.
     *
     *  After the focus callback is called for a window that lost input focus,
     *  synthetic key and mouse button release events will be generated for all such
     *  that had been pressed.  For more information, see @ref glfwSetKeyCallback
     *  and @ref glfwSetMouseButtonCallback.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_focus
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    func setFocusCallback(cbfun: @escaping glfw.WindowFocusFun) {
        GlfwWindow.focusCB[handle] = cbfun
        glfwSetWindowFocusCallback(handle) { handle, connected in
            GlfwWindow.focusCB[handle!]!(connected == GLFW_CONNECTED)
        }
    }

    static var focusCB = Dictionary<glfw.Window, glfw.WindowFocusFun>()

    /*  @brief Sets the iconify callback for the specified window.
     *
     *  This function sets the iconification callback of the specified window, which
     *  is called when the window is iconified or restored.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_iconify
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    func setIconifyCallback(cbfun: @escaping glfw.WindowIconifyFun) {
        GlfwWindow.iconifyCB[handle] = cbfun
        glfwSetWindowIconifyCallback(handle) { handle, iconified in
            GlfwWindow.iconifyCB[handle!]!(iconified == GLFW_TRUE)
        }
    }

    static var iconifyCB = Dictionary<glfw.Window, glfw.WindowIconifyFun>()

    /*  @brief Sets the framebuffer resize callback for the specified window.
     *
     *  This function sets the framebuffer resize callback of the specified window,
     *  which is called when the framebuffer of the specified window is resized.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_fbsize
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    func setFramebufferSizeCallback(cbfun: @escaping glfw.FramebufferSizeFun) {
        GlfwWindow.framebufferSizeCB[handle] = cbfun
        glfwSetFramebufferSizeCallback(handle) { handle, x, y in
            GlfwWindow.framebufferSizeCB[handle!]!(ivec2(x, y))
        }
    }

    static var framebufferSizeCB = Dictionary<glfw.Window, glfw.FramebufferSizeFun>()

    enum CursorMode: Int32 {
        case normal = 0x00034001, hidden, disabled
    }

    var cursor: CursorMode {
        get {
            CursorMode(rawValue: glfwGetInputMode(handle, GLFW_CURSOR))!
        }
        set {
            glfwSetInputMode(handle, GLFW_CURSOR, newValue.rawValue)
        }
    }

    var stickyKeys: Bool {
        get {
            glfwGetInputMode(handle, GLFW_STICKY_KEYS) == GLFW_TRUE
        }
        set {
            glfwSetInputMode(handle, GLFW_STICKY_KEYS, newValue ? GLFW_TRUE : GLFW_FALSE)
        }
    }

    var stickyMouseButtons: Bool {
        get {
            glfwGetInputMode(handle, GLFW_STICKY_MOUSE_BUTTONS) == GLFW_TRUE
        }
        set {
            glfwSetInputMode(handle, GLFW_STICKY_MOUSE_BUTTONS, newValue ? GLFW_TRUE : GLFW_FALSE)
        }
    }

    var lockKeyMods: Bool {
        get {
            glfwGetInputMode(handle, GLFW_LOCK_KEY_MODS) == GLFW_TRUE
        }
        set {
            glfwSetInputMode(handle, GLFW_LOCK_KEY_MODS, newValue ? GLFW_TRUE : GLFW_FALSE)
        }
    }

    var rawMouseMotion: Bool {
        get {
            glfwGetInputMode(handle, GLFW_RAW_MOUSE_MOTION) == GLFW_TRUE
        }
        set {
            glfwSetInputMode(handle, GLFW_RAW_MOUSE_MOTION, newValue ? GLFW_TRUE : GLFW_FALSE)
        }
    }

    /*  @brief Returns the last reported state of a keyboard key for the specified
     *  window.
     *
     *  This function returns the last state reported for the specified key to the
     *  specified window.  The returned state is one of `GLFW_PRESS` or
     *  `GLFW_RELEASE`.  The higher-level action `GLFW_REPEAT` is only reported to
     *  the key callback.
     *
     *  If the `GLFW_STICKY_KEYS` input mode is enabled, this function returns
     *  `GLFW_PRESS` the first time you call it for a key that was pressed, even if
     *  that key has already been released.
     *
     *  The key functions deal with physical keys, with [key tokens](@ref keys)
     *  named after their use on the standard US keyboard layout.  If you want to
     *  input text, use the Unicode character callback instead.
     *
     *  The [modifier key bit masks](@ref mods) are not key tokens and cannot be
     *  used with this function.
     *
     *  __Do not use this function__ to implement [text input](@ref input_char).
     *
     *  @param[in] window The desired window.
     *  @param[in] key The desired [keyboard key](@ref keys).  `GLFW_KEY_UNKNOWN` is
     *  not a valid key for this function.
     *  @return One of `GLFW_PRESS` or `GLFW_RELEASE`.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_INVALID_ENUM.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref input_key
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup input
     */
    func getKey(key: glfw.Key) -> glfw.InputAction {
        glfw.InputAction(rawValue: glfwGetKey(handle, key.rawValue))!
    }

    /*  @brief Returns the last reported state of a mouse button for the specified
     *  window.
     *
     *  This function returns the last state reported for the specified mouse button
     *  to the specified window.  The returned state is one of `GLFW_PRESS` or
     *  `GLFW_RELEASE`.
     *
     *  If the `GLFW_STICKY_MOUSE_BUTTONS` input mode is enabled, this function
     *  `GLFW_PRESS` the first time you call it for a mouse button that was pressed,
     *  even if that mouse button has already been released.
     *
     *  @param[in] window The desired window.
     *  @param[in] button The desired [mouse button](@ref buttons).
     *  @return One of `GLFW_PRESS` or `GLFW_RELEASE`.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_INVALID_ENUM.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref input_mouse_button
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup input
     */
    func getMouseButton(button: glfw.MouseButton) -> glfw.InputAction {
        glfw.InputAction(rawValue: glfwGetMouseButton(handle, button.rawValue))!
    }

    var cursorPos: dvec2 {
        /*  @brief Retrieves the position of the cursor relative to the client area of
         *  the window.
         *
         *  This function returns the position of the cursor, in screen coordinates,
         *  relative to the upper-left corner of the client area of the specified
         *  window.
         *
         *  If the cursor is disabled (with `GLFW_CURSOR_DISABLED`) then the cursor
         *  position is unbounded and limited only by the minimum and maximum values of
         *  a `double`.
         *
         *  The coordinate can be converted to their integer equivalents with the
         *  `floor` function.  Casting directly to an integer type works for positive
         *  coordinates, but fails for negative ones.
         *
         *  Any or all of the position arguments may be `NULL`.  If an error occurs, all
         *  non-`NULL` position arguments will be set to zero.
         *
         *  @param[in] window The desired window.
         *  @param[out] xpos Where to store the cursor x-coordinate, relative to the
         *  left edge of the client area, or `NULL`.
         *  @param[out] ypos Where to store the cursor y-coordinate, relative to the to
         *  top edge of the client area, or `NULL`.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref cursor_pos
         *  @sa glfwSetCursorPos
         *
         *  @since Added in version 3.0.  Replaces `glfwGetMousePos`.
         *
         *  @ingroup input
         */
        get {
            var x: Double = 0
            var y: Double = 0
            glfwGetCursorPos(handle, &x, &y)
            return dvec2(x, y)
        }
        /*  @brief Sets the position of the cursor, relative to the client area of the
         *  window.
         *
         *  This function sets the position, in screen coordinates, of the cursor
         *  relative to the upper-left corner of the client area of the specified
         *  window.  The window must have input focus.  If the window does not have
         *  input focus when this function is called, it fails silently.
         *
         *  __Do not use this function__ to implement things like camera controls.  GLFW
         *  already provides the `GLFW_CURSOR_DISABLED` cursor mode that hides the
         *  cursor, transparently re-centers it and provides unconstrained cursor
         *  motion.  See @ref glfwSetInputMode for more information.
         *
         *  If the cursor mode is `GLFW_CURSOR_DISABLED` then the cursor position is
         *  unconstrained and limited only by the minimum and maximum values of
         *  a `double`.
         *
         *  @param[in] window The desired window.
         *  @param[in] xpos The desired x-coordinate, relative to the left edge of the
         *  client area.
         *  @param[in] ypos The desired y-coordinate, relative to the top edge of the
         *  client area.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref cursor_pos
         *  @sa glfwGetCursorPos
         *
         *  @since Added in version 3.0.  Replaces `glfwSetMousePos`.
         *
         *  @ingroup input
         */
        set {
            glfwSetCursorPos(handle, newValue.x, newValue.y)
        }
    }

    /*  @brief Sets the cursor for the window.
     *
     *  This function sets the cursor image to be used when the cursor is over the
     *  client area of the specified window.  The set cursor will only be visible
     *  when the [cursor mode](@ref cursor_mode) of the window is
     *  `GLFW_CURSOR_NORMAL`.
     *
     *  On some platforms, the set cursor may not be visible unless the window also
     *  has input focus.
     *
     *  @param[in] window The window to set the cursor for.
     *  @param[in] cursor The cursor to set, or `NULL` to switch back to the default
     *  arrow cursor.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref cursor_object
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup input
     */
    func setCursor(cursor: glfw.Cursor) {
        glfwSetCursor(handle, cursor)
    }

    /*  @brief Sets the key callback.
     *
     *  This function sets the key callback of the specified window, which is called
     *  when a key is pressed, repeated or released.
     *
     *  The key functions deal with physical keys, with layout independent
     *  [key tokens](@ref keys) named after their values in the standard US keyboard
     *  layout.  If you want to input text, use the
     *  [character callback](@ref glfwSetCharCallback) instead.
     *
     *  When a window loses input focus, it will generate synthetic key release
     *  events for all pressed keys.  You can tell these events from user-generated
     *  events by the fact that the synthetic ones are generated after the focus
     *  loss event has been processed, i.e. after the
     *  [window focus callback](@ref glfwSetWindowFocusCallback) has been called.
     *
     *  The scancode of a key is specific to that platform or sometimes even to that
     *  machine.  Scancodes are intended to allow users to bind keys that don't have
     *  a GLFW key token.  Such keys have `key` set to `GLFW_KEY_UNKNOWN`, their
     *  state is not saved and so it cannot be queried with @ref glfwGetKey.
     *
     *  Sometimes GLFW needs to generate synthetic key events, in which case the
     *  scancode may be zero.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new key callback, or `NULL` to remove the currently
     *  set callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref input_key
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle parameter and return value.
     *
     *  @ingroup input
     */
    func setKeyCallback(cbfun: @escaping glfw.KeyFun) {
        GlfwWindow.keyCB[handle] = cbfun
        glfwSetKeyCallback(handle) { handle, key, scancode, action, modifier in
            GlfwWindow.keyCB[handle!]!(glfw.Key(rawValue: key)!, scancode, glfw.InputAction(rawValue: action)!, glfw.ModModifier(rawValue: modifier)!)
        }
    }

    static var keyCB = Dictionary<glfw.Window, glfw.KeyFun>()

    /*  @brief Sets the Unicode character callback.
     *
     *  This function sets the character callback of the specified window, which is
     *  called when a Unicode character is input.
     *
     *  The character callback is intended for Unicode text input.  As it deals with
     *  characters, it is keyboard layout dependent, whereas the
     *  [key callback](@ref glfwSetKeyCallback) is not.  Characters do not map 1:1
     *  to physical keys, as a key may produce zero, one or more characters.  If you
     *  want to know whether a specific physical key was pressed or released, see
     *  the key callback instead.
     *
     *  The character callback behaves as system text input normally does and will
     *  not be called if modifier keys are held down that would prevent normal text
     *  input on that platform, for example a Super (Command) key on OS X or Alt key
     *  on Windows.  There is a
     *  [character with modifiers callback](@ref glfwSetCharModsCallback) that
     *  receives these events.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref input_char
     *
     *  @since Added in version 2.4.
     *  @glfw3 Added window handle parameter and return value.
     *
     *  @ingroup input
     */
    func setCharCallback(cbfun: @escaping glfw.CharFun) {
        GlfwWindow.charCB[handle] = cbfun
        glfwSetCharCallback(handle) { handle, codepoint in
            GlfwWindow.charCB[handle!]!(codepoint)
        }
    }

    static var charCB = Dictionary<glfw.Window, glfw.CharFun>()

    /*  @brief Sets the Unicode character with modifiers callback.
     *
     *  This function sets the character with modifiers callback of the specified
     *  window, which is called when a Unicode character is input regardless of what
     *  modifier keys are used.
     *
     *  The character with modifiers callback is intended for implementing custom
     *  Unicode character input.  For regular Unicode text input, see the
     *  [character callback](@ref glfwSetCharCallback).  Like the character
     *  callback, the character with modifiers callback deals with characters and is
     *  keyboard layout dependent.  Characters do not map 1:1 to physical keys, as
     *  a key may produce zero, one or more characters.  If you want to know whether
     *  a specific physical key was pressed or released, see the
     *  [key callback](@ref glfwSetKeyCallback) instead.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref input_char
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup input
     */
    func setCharModsCallback(cbfun: @escaping glfw.CharModsFun) {
        GlfwWindow.charModsCB[handle] = cbfun
        glfwSetCharModsCallback(handle) { handle, codepoint, modModifier in
            GlfwWindow.charModsCB[handle!]!(codepoint, glfw.ModModifier(rawValue: modModifier)!)
        }
    }

    static var charModsCB = Dictionary<glfw.Window, glfw.CharModsFun>()

    /*  @brief Sets the mouse button callback.
     *
     *  This function sets the mouse button callback of the specified window, which
     *  is called when a mouse button is pressed or released.
     *
     *  When a window loses input focus, it will generate synthetic mouse button
     *  release events for all pressed mouse buttons.  You can tell these events
     *  from user-generated events by the fact that the synthetic ones are generated
     *  after the focus loss event has been processed, i.e. after the
     *  [window focus callback](@ref glfwSetWindowFocusCallback) has been called.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref input_mouse_button
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle parameter and return value.
     *
     *  @ingroup input
     */
    func setMouseButtonCallback(cbfun: @escaping glfw.MouseButtonFun) {
        GlfwWindow.mouseButtonCB[handle] = cbfun
        glfwSetMouseButtonCallback(handle) { handle, mouse, action, modifier in
            GlfwWindow.mouseButtonCB[handle!]!(glfw.MouseButton(rawValue: mouse)!, glfw.InputAction(rawValue: action)!, glfw.ModModifier(rawValue: modifier)!)
        }
    }

    static var mouseButtonCB = Dictionary<glfw.Window, glfw.MouseButtonFun>()

    /*  @brief Sets the cursor position callback.
     *
     *  This function sets the cursor position callback of the specified window,
     *  which is called when the cursor is moved.  The callback is provided with the
     *  position, in screen coordinates, relative to the upper-left corner of the
     *  client area of the window.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref cursor_pos
     *
     *  @since Added in version 3.0.  Replaces `glfwSetMousePosCallback`.
     *
     *  @ingroup input
     */
    func setCursorPosCallback(cbfun: @escaping glfw.CursorPosFun) {
        GlfwWindow.cursorPosCB[handle] = cbfun
        glfwSetCursorPosCallback(handle) { handle, x, y in
            GlfwWindow.cursorPosCB[handle!]!(dvec2(x, y))
        }
    }

    static var cursorPosCB = Dictionary<glfw.Window, glfw.CursorPosFun>()

    /*  @brief Sets the cursor enter/exit callback.
     *
     *  This function sets the cursor boundary crossing callback of the specified
     *  window, which is called when the cursor enters or leaves the client area of
     *  the window.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref cursor_enter
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup input
     */
    func setCursorEnterCallback(cbfun: @escaping glfw.CursorEnterFun) {
        GlfwWindow.cursorEnterCB[handle] = cbfun
        glfwSetCursorEnterCallback(handle) { handle, entered in
            GlfwWindow.cursorEnterCB[handle!]!(entered == GLFW_TRUE)
        }
    }

    static var cursorEnterCB = Dictionary<glfw.Window, glfw.CursorEnterFun>()

    /*  @brief Sets the scroll callback.
     *
     *  This function sets the scroll callback of the specified window, which is
     *  called when a scrolling device is used, such as a mouse wheel or scrolling
     *  area of a touchpad.
     *
     *  The scroll callback receives all scrolling input, like that from a mouse
     *  wheel or a touchpad scrolling area.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new scroll callback, or `NULL` to remove the currently
     *  set callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref scrolling
     *
     *  @since Added in version 3.0.  Replaces `glfwSetMouseWheelCallback`.
     *
     *  @ingroup input
     */
    func setScrollCallback(cbfun: @escaping glfw.ScrollFun) {
        GlfwWindow.scrollCB[handle] = cbfun
        glfwSetScrollCallback(handle) { handle, x, y in
            GlfwWindow.scrollCB[handle!]!(dvec2(x, y))
        }
    }

    static var scrollCB = Dictionary<glfw.Window, glfw.ScrollFun>()

    /*  @brief Sets the file drop callback.
     *
     *  This function sets the file drop callback of the specified window, which is
     *  called when one or more dragged files are dropped on the window.
     *
     *  Because the path array and its strings may have been generated specifically
     *  for that event, they are not guaranteed to be valid after the callback has
     *  returned.  If you wish to use them after the callback returns, you need to
     *  make a deep copy.
     *
     *  @param[in] window The window whose callback to set.
     *  @param[in] cbfun The new file drop callback, or `NULL` to remove the
     *  currently set callback.
     *  @return The previously set callback, or `NULL` if no callback was set or the
     *  library had not been [initialized](@ref intro_init).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref path_drop
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup input
     */
    func setDropCallback(cbfun: @escaping glfw.DropFun) {
        GlfwWindow.dropCB[handle] = cbfun
        fatalError()
//        glfwSetDropCallback(handle) { handle, dropped, paths in
//            GlfwWindow.dropCB[handle!]!(dropped, paths)
//        }
    }

    static var dropCB = Dictionary<glfw.Window, glfw.DropFun>()

    var clipboard: String {
        /*  @brief Sets the clipboard to the specified string.
         *
         *  This function sets the system clipboard to the specified, UTF-8 encoded
         *  string.
         *
         *  @param[in] window The window that will own the clipboard contents.
         *  @param[in] string A UTF-8 encoded string.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @pointer_lifetime The specified string is copied before this function
         *  returns.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref clipboard
         *  @sa glfwGetClipboardString
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup input
         */
        set {
            glfwSetClipboardString(handle, newValue)
        }
        /*  @brief Returns the contents of the clipboard as a string.
         *
         *  This function returns the contents of the system clipboard, if it contains
         *  or is convertible to a UTF-8 encoded string.  If the clipboard is empty or
         *  if its contents cannot be converted, `NULL` is returned and a @ref
         *  GLFW_FORMAT_UNAVAILABLE error is generated.
         *
         *  @param[in] window The window that will request the clipboard contents.
         *  @return The contents of the clipboard as a UTF-8 encoded string, or `NULL`
         *  if an [error](@ref error_handling) occurred.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @pointer_lifetime The returned string is allocated and freed by GLFW.  You
         *  should not free it yourself.  It is valid until the next call to @ref
         *  glfwGetClipboardString or @ref glfwSetClipboardString, or until the library
         *  is terminated.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref clipboard
         *  @sa glfwSetClipboardString
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup input
         */
        get {
            String(utf8String: glfwGetClipboardString(handle)!)!
        }
    }

    /*! @brief Makes the context of the specified window current for the calling
     *  thread.
     *
     *  This function makes the OpenGL or OpenGL ES context of the specified window
     *  current on the calling thread.  A context can only be made current on
     *  a single thread at a time and each thread can have only a single current
     *  context at a time.
     *
     *  By default, making a context non-current implicitly forces a pipeline flush.
     *  On machines that support `GL_KHR_context_flush_control`, you can control
     *  whether a context performs this flush by setting the
     *  [GLFW_CONTEXT_RELEASE_BEHAVIOR](@ref window_hints_ctx) window hint.
     *
     *  The specified window must have an OpenGL or OpenGL ES context.  Specifying
     *  a window without a context will generate a @ref GLFW_NO_WINDOW_CONTEXT
     *  error.
     *
     *  @param[in] window The window whose context to make current, or `NULL` to
     *  detach the current context.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_NO_WINDOW_CONTEXT and @ref GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref context_current
     *  @sa glfwGetCurrentContext
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup context
     */
    func makeContextCurrent() {
        glfwMakeContextCurrent(handle)
    }

    func makeContextUnurrent() {
        glfwMakeContextCurrent(nil)
    }

    /*  @brief Swaps the front and back buffers of the specified window.
     *
     *  This function swaps the front and back buffers of the specified window when
     *  rendering with OpenGL or OpenGL ES.  If the swap interval is greater than
     *  zero, the GPU driver waits the specified number of screen updates before
     *  swapping the buffers.
     *
     *  The specified window must have an OpenGL or OpenGL ES context.  Specifying
     *  a window without a context will generate a @ref GLFW_NO_WINDOW_CONTEXT
     *  error.
     *
     *  This function does not apply to Vulkan.  If you are rendering with Vulkan,
     *  see `vkQueuePresentKHR` instead.
     *
     *  @param[in] window The window whose buffers to swap.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_NO_WINDOW_CONTEXT and @ref GLFW_PLATFORM_ERROR.
     *
     *  @remark __EGL:__ The context of the specified window must be current on the
     *  calling thread.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref buffer_swap
     *  @sa glfwSwapInterval
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup window
     */
    func swapBuffers() {
        glfwSwapBuffers(handle)
    }
}

