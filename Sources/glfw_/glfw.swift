import glm
import glfwNative
import Foundation
import Dispatch

/*************************************************************************
 * GLFW 3.2 - www.glfw.org
 * A library for OpenGL, window and input
 *------------------------------------------------------------------------
 * Copyright (c) 2002-2006 Marcus Geelnard
 * Copyright (c) 2006-2016 Camilla Berglund <elmindreda@glfw.org>
 *
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would
 *    be appreciated but is not required.
 *
 * 2. Altered source versions must be plainly marked as such, and must not
 *    be misrepresented as being the original software.
 *
 * 3. This notice may not be removed or altered from any source
 *    distribution.
 *
 *************************************************************************/

public struct glfw {

//    private init() {
//    }

    /*************************************************************************
     * GLFW API tokens
     *************************************************************************/

    /*  @brief The major version number of the GLFW library.
     *
     *  This is incremented when the API is changed in non-compatible ways.
     *  @ingroup init
     */
    static let VERSION_MAJOR = 3

    /*  @brief The minor version number of the GLFW library.
     *
     *  This is incremented when features are added to the API but it remains
     *  backward-compatible.
     *  @ingroup init
     */
    static let VERSION_MINOR = 2

//    static var VERSION: String { TODO?
//        get {
//            "\(VERSION_MAJOR).\(VERSION_MINOR)"
//        }
//    }

    /*  @brief The revision number of the GLFW library.
     *
     *  This is incremented when a bug fix release is made that does not contain any
     *  API changes.
     *  @ingroup init
     */
    static let VERSION_REVISION = 1

    /*  @name Key and button actions
    *  @brief The key or mouse button was released. */
    enum InputAction: Int32 {

        /*  @brief The key or mouse button was released.
         *
         *  The key or mouse button was released.
         *
         *  @ingroup input
         */
        case release

        /*  @brief The key or mouse button was pressed.
         *
         *  The key or mouse button was pressed.
         *
         *  @ingroup input
         */
        case press
        /*  @brief The key was held down until it repeated.
         *
         *  The key was held down until it repeated.
         *
         *  @ingroup input
         */
        case `repeat`
    }

    /*  @defgroup keys Keyboard keys
     *
     *  See [key input](@ref input_key) for how these are used.
     *
     *  These key codes are inspired by the _USB HID Usage Tables v1.12_ (p. 53-60),
     *  but re-arranged to map to 7-bit ASCII for printable keys (function keys are
     *  put in the 256+ range).
     *
     *  The naming of the key codes follow these rules:
     *   - The US keyboard layout is used
     *   - Names of printable alpha-numeric characters are used (e.g. "A", "R",
     *     "3", etc.)
     *   - For non-alphanumeric characters, Unicode:ish names are used (e.g.
     *     "COMMA", "LEFT_SQUARE_BRACKET", etc.). Note that some names do not
     *     correspond to the Unicode standard (usually for brevity)
     *   - Keys that lack a clear US mapping are named "WORLD_x"
     *   - For non-printable keys, custom names are used (e.g. "F4",
     *     "BACKSPACE", etc.)
     *
     *  @ingroup input
     *  @{
     */
    enum Key: Int32 {
        /* The unknown key */
        case unknown = -1

        /* Printable keys */
        case space = 32
        case apostrophe = 39  /* ' */
        case comma = 44  /* , */, minus /* - */, period /* . */, slash /* / */
        case _0, _1, _2, _3, _4, _5, _6, _7, _8, _9
        case semicolon = 59  /* ; */
        case equal = 61  /* = */
        case a = 65, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
        case leftBracket /* [ */, backslash /* \ */, rightBracket /* ] */
        case graveAccent = 96  /* ` */
        case world1 = 161 /* non-US #1 */, world2 /* non-US #2 */

        /* Function keys */
        case escape = 256, enter, tab, backspace, insert, delete, right, left, down, up, pageUp, pageDown, home, end
        case capsLock = 280, scrollLock, numLock, printScreen, pause
        case f1 = 290, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25
        case kp0 = 320, kp1, kp2, kp3, kp4, kp5, kp6, kp7, kp8, kp9, kpDecimal, kpDivide, kpMultiply, kpSubtract, kpAdd, kpEnter, kpEqual
        case leftShift, leftControl, leftAlt, leftSuper, rightShift, rightControl, rightAlt, rightSuper, menu

        static let LAST = menu

        /*  @brief Returns the localized name of the specified printable key.
         *
         *  This function returns the localized name of the specified printable key.
         *  This is intended for displaying key bindings to the user.
         *
         *  If the key is `GLFW_KEY_UNKNOWN`, the scancode is used instead, otherwise
         *  the scancode is ignored.  If a non-printable key or (if the key is
         *  `GLFW_KEY_UNKNOWN`) a scancode that maps to a non-printable key is
         *  specified, this function returns `NULL`.
         *
         *  This behavior allows you to pass in the arguments passed to the
         *  [key callback](@ref input_key) without modification.
         *
         *  The printable keys are:
         *  - `GLFW_KEY_APOSTROPHE`
         *  - `GLFW_KEY_COMMA`
         *  - `GLFW_KEY_MINUS`
         *  - `GLFW_KEY_PERIOD`
         *  - `GLFW_KEY_SLASH`
         *  - `GLFW_KEY_SEMICOLON`
         *  - `GLFW_KEY_EQUAL`
         *  - `GLFW_KEY_LEFT_BRACKET`
         *  - `GLFW_KEY_RIGHT_BRACKET`
         *  - `GLFW_KEY_BACKSLASH`
         *  - `GLFW_KEY_WORLD_1`
         *  - `GLFW_KEY_WORLD_2`
         *  - `GLFW_KEY_0` to `GLFW_KEY_9`
         *  - `GLFW_KEY_A` to `GLFW_KEY_Z`
         *  - `GLFW_KEY_KP_0` to `GLFW_KEY_KP_9`
         *  - `GLFW_KEY_KP_DECIMAL`
         *  - `GLFW_KEY_KP_DIVIDE`
         *  - `GLFW_KEY_KP_MULTIPLY`
         *  - `GLFW_KEY_KP_SUBTRACT`
         *  - `GLFW_KEY_KP_ADD`
         *  - `GLFW_KEY_KP_EQUAL`
         *
         *  @param[in] key The key to query, or `GLFW_KEY_UNKNOWN`.
         *  @param[in] scancode The scancode of the key to query.
         *  @return The localized name of the key, or `NULL`.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_PLATFORM_ERROR.
         *
         *  @pointer_lifetime The returned string is allocated and freed by GLFW.  You
         *  should not free it yourself.  It is valid until the next call to @ref
         *  glfwGetKeyName, or until the library is terminated.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref input_key_name
         *
         *  @since Added in version 3.2.
         *
         *  @ingroup input
         */
        var name: String {
            String(cString: glfwGetKeyName(rawValue, 0))
        }
    }


    /*  @defgroup mods Modifier key flags
     *
     *  See [key input](@ref input_key) for how these are used.
     *
     *  @ingroup input
     *  @{ */
    enum ModModifier: Int32 {

        /* @brief If this bit is set one or more Shift keys were held down. */
        case shift = 0x0001
        /* @brief If this bit is set one or more Control keys were held down. */
        case control = 0x0002
        /* @brief If this bit is set one or more Alt keys were held down. */
        case alt = 0x0004
        /* @brief If this bit is set one or more Super keys were held down. */
        case `super` = 0x0008
    }


    /* @defgroup buttons Mouse buttons
     *
     *  See [mouse button input](@ref input_mouse_button) for how these are used.
     *
     *  @ingroup input
     *  @{ */
    enum MouseButton: Int32 {
        case _1, _2, _3, _4, _5, _6, _7, _8
        static let last = _8, left = _1, right = _2, middle = _3
    }

    /*  @defgroup joysticks Joysticks
     *
     *  See [joystick input](@ref joystick) for how these are used.
     *
     *  @ingroup input
     *  @{ */
    enum Joystick: Int32 {
        case _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16
        static let last = _16

        /*  @brief Returns whether the specified joystick is present.
         *
         *  This function returns whether the specified joystick is present.
         *
         *  @param[in] joy The [joystick](@ref joysticks) to query.
         *  @return `GLFW_TRUE` if the joystick is present, or `GLFW_FALSE` otherwise.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
         *  GLFW_INVALID_ENUM and @ref GLFW_PLATFORM_ERROR.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref joystick
         *
         *  @since Added in version 3.0.  Replaces `glfwGetJoystickParam`.
         *
         *  @ingroup input
         */
        var present: Bool {
            glfwJoystickPresent(rawValue) == GLFW_TRUE
        }

        /*  @brief Returns the values of all axes of the specified joystick.
         *
         *  This function returns the values of all axes of the specified joystick.
         *  Each element in the array is a value between -1.0 and 1.0.
         *
         *  Querying a joystick slot with no device present is not an error, but will
         *  cause this function to return `NULL`.  Call @ref glfwJoystickPresent to
         *  check device presence.
         *
         *  @param[in] joy The [joystick](@ref joysticks) to query.
         *  @param[out] count Where to store the number of axis values in the returned
         *  array.  This is set to zero if the joystick is not present or an error
         *  occurred.
         *  @return An array of axis values, or `NULL` if the joystick is not present or
         *  an [error](@ref error_handling) occurred.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
         *  GLFW_INVALID_ENUM and @ref GLFW_PLATFORM_ERROR.
         *
         *  @pointer_lifetime The returned array is allocated and freed by GLFW.  You
         *  should not free it yourself.  It is valid until the specified joystick is
         *  disconnected, this function is called again for that joystick or the library
         *  is terminated.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref joystick_axis
         *
         *  @since Added in version 3.0.  Replaces `glfwGetJoystickPos`.
         *
         *  @ingroup input
         */
        var axes: [Float] {
            var count: Int32 = 0
            let axes = glfwGetJoystickAxes(rawValue, &count)
            return Array(UnsafeBufferPointer(start: axes, count: Int(count)))
        }

        /*  @brief Returns the state of all buttons of the specified joystick.
         *
         *  This function returns the state of all buttons of the specified joystick.
         *  Each element in the array is either `GLFW_PRESS` or `GLFW_RELEASE`.
         *
         *  Querying a joystick slot with no device present is not an error, but will
         *  cause this function to return `NULL`.  Call @ref glfwJoystickPresent to
         *  check device presence.
         *
         *  @param[in] joy The [joystick](@ref joysticks) to query.
         *  @param[out] count Where to store the number of button states in the returned
         *  array.  This is set to zero if the joystick is not present or an error
         *  occurred.
         *  @return An array of button states, or `NULL` if the joystick is not present
         *  or an [error](@ref error_handling) occurred.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
         *  GLFW_INVALID_ENUM and @ref GLFW_PLATFORM_ERROR.
         *
         *  @pointer_lifetime The returned array is allocated and freed by GLFW.  You
         *  should not free it yourself.  It is valid until the specified joystick is
         *  disconnected, this function is called again for that joystick or the library
         *  is terminated.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref joystick_button
         *
         *  @since Added in version 2.2.
         *  @glfw3 Changed to return a dynamic array.
         *
         *  @ingroup input
         */
        var buttons: [InputAction] {
            var count: Int32 = 0
            let buttons = glfwGetJoystickButtons(rawValue, &count)!
            var res: [InputAction] = []
            res.reserveCapacity(Int(count))
            for i in 0..<Int(count) {
                res += buttons[i] == GLFW_PRESS ? InputAction.press : InputAction.release
            }
            return res
        }

        /*  @brief Returns the name of the specified joystick.
         *
         *  This function returns the name, encoded as UTF-8, of the specified joystick.
         *  The returned string is allocated and freed by GLFW.  You should not free it
         *  yourself.
         *
         *  Querying a joystick slot with no device present is not an error, but will
         *  cause this function to return `NULL`.  Call @ref glfwJoystickPresent to
         *  check device presence.
         *
         *  @param[in] joy The [joystick](@ref joysticks) to query.
         *  @return The UTF-8 encoded name of the joystick, or `NULL` if the joystick
         *  is not present or an [error](@ref error_handling) occurred.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
         *  GLFW_INVALID_ENUM and @ref GLFW_PLATFORM_ERROR.
         *
         *  @pointer_lifetime The returned string is allocated and freed by GLFW.  You
         *  should not free it yourself.  It is valid until the specified joystick is
         *  disconnected, this function is called again for that joystick or the library
         *  is terminated.
         *
         *  @thread_safety This function must only be called from the main thread.
         *
         *  @sa @ref joystick_name
         *
         *  @since Added in version 3.0.
         *
         *  @ingroup input
         */
        var name: String {
            String(cString: glfwGetJoystickName(rawValue)!)
        }
    }

    /*  @defgroup errors Error codes
     *
     *  See [error handling](@ref error_handling) for how these are used.
     *
     *  @ingroup init */
    enum Error: Int32 {

        /*  @brief GLFW has not been initialized.
         *
         *  This occurs if a GLFW function was called that must not be called unless the
         *  library is [initialized](@ref intro_init).
         *
         *  @analysis Application programmer error.  Initialize GLFW before calling any
         *  function that requires initialization.
         */
        case notInitialized = 0x00010001
        /*  @brief No context is current for this thread.
         *
         *  This occurs if a GLFW function was called that needs and operates on the
         *  current OpenGL or OpenGL ES context but no context is current on the calling
         *  thread.  One such function is @ref glfwSwapInterval.
         *
         *  @analysis Application programmer error.  Ensure a context is current before
         *  calling functions that require a current context.
         */
        case noCurrentContext
        /*  @brief One of the arguments to the function was an invalid enum value.
         *
         *  One of the arguments to the function was an invalid enum value, for example
         *  requesting [GLFW_RED_BITS](@ref window_hints_fb) with @ref
         *  glfwGetWindowAttrib.
         *
         *  @analysis Application programmer error.  Fix the offending call.
         */
        case invalidEnum
        /*  @brief One of the arguments to the function was an invalid value.
         *
         *  One of the arguments to the function was an invalid value, for example
         *  requesting a non-existent OpenGL or OpenGL ES version like 2.7.
         *
         *  Requesting a valid but unavailable OpenGL or OpenGL ES version will instead
         *  result in a @ref GLFW_VERSION_UNAVAILABLE error.
         *
         *  @analysis Application programmer error.  Fix the offending call.
         */
        case invalidValue
        /*  @brief A memory allocation failed.
         *
         *  A memory allocation failed.
         *
         *  @analysis A bug in GLFW or the underlying operating system.  Report the bug
         *  to our [issue tracker](https://github.com/glfw/glfw/issues).
         */
        case outOfMemory
        /*! @brief GLFW could not find support for the requested API on the system.
         *
         *  GLFW could not find support for the requested API on the system.
         *
         *  @analysis The installed graphics driver does not support the requested
         *  API, or does not support it via the chosen context creation backend.
         *  Below are a few examples.
         *
         *  @par
         *  Some pre-installed Windows graphics drivers do not support OpenGL.  AMD only
         *  supports OpenGL ES via EGL, while Nvidia and Intel only support it via
         *  a WGL or GLX extension.  OS X does not provide OpenGL ES at all.  The Mesa
         *  EGL, OpenGL and OpenGL ES libraries do not interface with the Nvidia binary
         *  driver.  Older graphics drivers do not support Vulkan.
         */
        case apiUnavailable
        /*  @brief The requested OpenGL or OpenGL ES version is not available.
         *
         *  The requested OpenGL or OpenGL ES version (including any requested context
         *  or framebuffer hints) is not available on this machine.
         *
         *  @analysis The machine does not support your requirements.  If your
         *  application is sufficiently flexible, downgrade your requirements and try
         *  again.  Otherwise, inform the user that their machine does not match your
         *  requirements.
         *
         *  @par
         *  Future invalid OpenGL and OpenGL ES versions, for example OpenGL 4.8 if 5.0
         *  comes out before the 4.x series gets that far, also fail with this error and
         *  not @ref GLFW_INVALID_VALUE, because GLFW cannot know what future versions
         *  will exist.
         */
        case version_unavailable
        /*  @brief A platform-specific error occurred that does not match any of the
         *  more specific categories.
         *
         *  A platform-specific error occurred that does not match any of the more
         *  specific categories.
         *
         *  @analysis A bug or configuration error in GLFW, the underlying operating
         *  system or its drivers, or a lack of required resources.  Report the issue to
         *  our [issue tracker](https://github.com/glfw/glfw/issues).
         */
        case platformError
        /*  @brief The requested format is not supported or available.
         *
         *  If emitted during window creation, the requested pixel format is not
         *  supported.
         *
         *  If emitted when querying the clipboard, the contents of the clipboard could
         *  not be converted to the requested format.
         *
         *  @analysis If emitted during window creation, one or more
         *  [hard constraints](@ref window_hints_hard) did not match any of the
         *  available pixel formats.  If your application is sufficiently flexible,
         *  downgrade your requirements and try again.  Otherwise, inform the user that
         *  their machine does not match your requirements.
         *
         *  @par
         *  If emitted when querying the clipboard, ignore the error or report it to
         *  the user, as appropriate.
         */
        case formatUnavailable
        /*  @brief The specified window does not have an OpenGL or OpenGL ES context.
         *
         *  A window that does not have an OpenGL or OpenGL ES context was passed to
         *  a function that requires it to have one.
         *
         *  @analysis Application programmer error.  Fix the offending call.
         */
        case noWindowContext
    }

//#define GLFW_FOCUSED                0x00020001
//#define GLFW_ICONIFIED              0x00020002
//#define GLFW_RESIZABLE              0x00020003
//#define GLFW_VISIBLE                0x00020004
//#define GLFW_DECORATED              0x00020005
//#define GLFW_AUTO_ICONIFY           0x00020006
//#define GLFW_FLOATING               0x00020007
//#define GLFW_MAXIMIZED              0x00020008
//
//#define GLFW_RED_BITS               0x00021001
//#define GLFW_GREEN_BITS             0x00021002
//#define GLFW_BLUE_BITS              0x00021003
//#define GLFW_ALPHA_BITS             0x00021004
//#define GLFW_DEPTH_BITS             0x00021005
//#define GLFW_STENCIL_BITS           0x00021006
//#define GLFW_ACCUM_RED_BITS         0x00021007
//#define GLFW_ACCUM_GREEN_BITS       0x00021008
//#define GLFW_ACCUM_BLUE_BITS        0x00021009
//#define GLFW_ACCUM_ALPHA_BITS       0x0002100A
//#define GLFW_AUX_BUFFERS            0x0002100B
//#define GLFW_STEREO                 0x0002100C
//#define GLFW_SAMPLES                0x0002100D
//#define GLFW_SRGB_CAPABLE           0x0002100E
//#define GLFW_REFRESH_RATE           0x0002100F
//#define GLFW_DOUBLEBUFFER           0x00021010
//
//#define GLFW_CLIENT_API             0x00022001
//#define GLFW_CONTEXT_VERSION_MAJOR  0x00022002
//#define GLFW_CONTEXT_VERSION_MINOR  0x00022003
//#define GLFW_CONTEXT_REVISION       0x00022004
//#define GLFW_CONTEXT_ROBUSTNESS     0x00022005
//#define GLFW_OPENGL_FORWARD_COMPAT  0x00022006
//#define GLFW_OPENGL_DEBUG_CONTEXT   0x00022007
//#define GLFW_OPENGL_PROFILE         0x00022008
//#define GLFW_CONTEXT_RELEASE_BEHAVIOR 0x00022009
//#define GLFW_CONTEXT_NO_ERROR       0x0002200A
//#define GLFW_CONTEXT_CREATION_API   0x0002200B
//
//#define GLFW_NO_API                          0
//#define GLFW_OPENGL_API             0x00030001
//#define GLFW_OPENGL_ES_API          0x00030002
//
//#define GLFW_NO_ROBUSTNESS                   0
//#define GLFW_NO_RESET_NOTIFICATION  0x00031001
//#define GLFW_LOSE_CONTEXT_ON_RESET  0x00031002
//
//#define GLFW_OPENGL_ANY_PROFILE              0
//#define GLFW_OPENGL_CORE_PROFILE    0x00032001
//#define GLFW_OPENGL_COMPAT_PROFILE  0x00032002
//
//#define GLFW_CURSOR                 0x00033001
//#define GLFW_STICKY_KEYS            0x00033002
//#define GLFW_STICKY_MOUSE_BUTTONS   0x00033003
//
//#define GLFW_CURSOR_NORMAL          0x00034001
//#define GLFW_CURSOR_HIDDEN          0x00034002
//#define GLFW_CURSOR_DISABLED        0x00034003
//
//#define GLFW_ANY_RELEASE_BEHAVIOR            0
//#define GLFW_RELEASE_BEHAVIOR_FLUSH 0x00035001
//#define GLFW_RELEASE_BEHAVIOR_NONE  0x00035002
//
//#define GLFW_NATIVE_CONTEXT_API     0x00036001
//#define GLFW_EGL_CONTEXT_API        0x00036002

    /*  @defgroup shapes Standard cursor shapes
     *
     *  See [standard cursor creation](@ref cursor_standard) for how these are used.
     *
     *  @ingroup input
     *  @{ */
    enum CursorShape: Int32 {
        /*  @brief The regular arrow cursor shape.
         *
         *  The regular arrow cursor.
         */
        case arrow = 0x00036001
        /*  @brief The text input I-beam cursor shape.
         *
         *  The text input I-beam cursor shape.
         */
        case ibeam
        /*  @brief The crosshair shape.
         *
         *  The crosshair shape.
         */
        case crosshair
        /*  @brief The hand shape.
         *
         *  The hand shape.
         */
        case hand
        /*  @brief The horizontal resize arrow shape.
         *
         *  The horizontal resize arrow shape.
         */
        case hresize
        /*  @brief The vertical resize arrow shape.
         *
         *  The vertical resize arrow shape.
         */
        case vresize
    }

    // as boolean
//#define GLFW_CONNECTED              0x00040001
//#define GLFW_DISCONNECTED           0x00040002

//#define GLFW_DONT_CARE              -1


/*************************************************************************
 * GLFW API types
 *************************************************************************/

/*! @brief Client API function pointer type.
 *
 *  Generic function pointer used for returning client API function pointers
 *  without forcing a cast from a regular pointer.
 *
 *  @sa @ref context_glext
 *  @sa glfwGetProcAddress
 *
 *  @since Added in version 3.0.

 *  @ingroup context
 */
//typedef void (*GLFWglproc)(void);
//
///*! @brief Vulkan API function pointer type.
// *
// *  Generic function pointer used for returning Vulkan API function pointers
// *  without forcing a cast from a regular pointer.
// *
// *  @sa @ref vulkan_proc
// *  @sa glfwGetInstanceProcAddress
// *
// *  @since Added in version 3.2.
// *
// *  @ingroup vulkan
// */
//typedef void (*GLFWvkproc)(void);

    /*  @brief Opaque monitor object.
     *
     *  Opaque monitor object.
     *
     *  @see @ref monitor_object
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup monitor
     */
    typealias Monitor = OpaquePointer

    /*  @brief Opaque window object.
     *
     *  Opaque window object.
     *
     *  @see @ref window_object
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    typealias Window = OpaquePointer

    /*  @brief Opaque cursor object.
     *
     *  Opaque cursor object.
     *
     *  @see @ref cursor_object
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup cursor
     */
    typealias Cursor = OpaquePointer

    /*  @brief The function signature for error callbacks.
     *
     *  This is the function signature for error callback functions.
     *
     *  @param[in] error An [error code](@ref errors).
     *  @param[in] description A UTF-8 encoded string describing the error.
     *
     *  @sa @ref error_handling
     *  @sa glfwSetErrorCallback
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup init
     */
    typealias ErrorFun = (Error, _ description: String) -> Void

    /*  @brief The function signature for window position callbacks.
     *
     *  This is the function signature for window position callback functions.
     *
     *  @param[in] window The window that was moved.
     *  @param[in] xpos The new x-coordinate, in screen coordinates, of the
     *  upper-left corner of the client area of the window.
     *  @param[in] ypos The new y-coordinate, in screen coordinates, of the
     *  upper-left corner of the client area of the window.
     *
     *  @sa @ref window_pos
     *  @sa glfwSetWindowPosCallback
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    typealias WindowPosFun = (_ upperLeftPos: ivec2) -> Void

    /*  @brief The function signature for window resize callbacks.
     *
     *  This is the function signature for window size callback functions.
     *
     *  @param[in] window The window that was resized.
     *  @param[in] width The new width, in screen coordinates, of the window.
     *  @param[in] height The new height, in screen coordinates, of the window.
     *
     *  @sa @ref window_size
     *  @sa glfwSetWindowSizeCallback
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup window
     */
    typealias WindowSizeFun = (_ size: ivec2) -> Void

    /*  @brief The function signature for window close callbacks.
     *
     *  This is the function signature for window close callback functions.
     *
     *  @param[in] window The window that the user attempted to close.
     *
     *  @sa @ref window_close
     *  @sa glfwSetWindowCloseCallback
     *
     *  @since Added in version 2.5.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup window
     */
    typealias WindowCloseFun = () -> Void

    /*  @brief The function signature for window content refresh callbacks.
     *
     *  This is the function signature for window refresh callback functions.
     *
     *  @param[in] window The window whose content needs to be refreshed.
     *
     *  @sa @ref window_refresh
     *  @sa glfwSetWindowRefreshCallback
     *
     *  @since Added in version 2.5.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup window
     */
    typealias WindowRefreshFun = () -> Void

    /*  @brief The function signature for window focus/defocus callbacks.
     *
     *  This is the function signature for window focus callback functions.
     *
     *  @param[in] window The window that gained or lost input focus.
     *  @param[in] focused `GLFW_TRUE` if the window was given input focus, or
     *  `GLFW_FALSE` if it lost it.
     *
     *  @sa @ref window_focus
     *  @sa glfwSetWindowFocusCallback
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    typealias WindowFocusFun = (_ focused: Bool) -> Void

    /*  @brief The function signature for window iconify/restore callbacks.
     *
     *  This is the function signature for window iconify/restore callback
     *  functions.
     *
     *  @param[in] window The window that was iconified or restored.
     *  @param[in] iconified `GLFW_TRUE` if the window was iconified, or
     *  `GLFW_FALSE` if it was restored.
     *
     *  @sa @ref window_iconify
     *  @sa glfwSetWindowIconifyCallback
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    typealias WindowIconifyFun = (_ iconified: Bool) -> Void

    /*  @brief The function signature for framebuffer resize callbacks.
     *
     *  This is the function signature for framebuffer resize callback
     *  functions.
     *
     *  @param[in] window The window whose framebuffer was resized.
     *  @param[in] width The new width, in pixels, of the framebuffer.
     *  @param[in] height The new height, in pixels, of the framebuffer.
     *
     *  @sa @ref window_fbsize
     *  @sa glfwSetFramebufferSizeCallback
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    typealias FramebufferSizeFun = (_ newSize: ivec2) -> Void

    /*  @brief The function signature for mouse button callbacks.
     *
     *  This is the function signature for mouse button callback functions.
     *
     *  @param[in] window The window that received the event.
     *  @param[in] button The [mouse button](@ref buttons) that was pressed or
     *  released.
     *  @param[in] action One of `GLFW_PRESS` or `GLFW_RELEASE`.
     *  @param[in] mods Bit field describing which [modifier keys](@ref mods) were
     *  held down.
     *
     *  @sa @ref input_mouse_button
     *  @sa glfwSetMouseButtonCallback
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle and modifier mask parameters.
     *
     *  @ingroup input
     */
    typealias MouseButtonFun = (MouseButton, InputAction, ModModifier) -> Void

    /*  @brief The function signature for cursor position callbacks.
     *
     *  This is the function signature for cursor position callback functions.
     *
     *  @param[in] window The window that received the event.
     *  @param[in] xpos The new cursor x-coordinate, relative to the left edge of
     *  the client area.
     *  @param[in] ypos The new cursor y-coordinate, relative to the top edge of the
     *  client area.
     *
     *  @sa @ref cursor_pos
     *  @sa glfwSetCursorPosCallback
     *
     *  @since Added in version 3.0.  Replaces `GLFWmouseposfun`.
     *
     *  @ingroup input
     */
    typealias CursorPosFun = (_ newPos: dvec2) -> Void

    /*  @brief The function signature for cursor enter/leave callbacks.
     *
     *  This is the function signature for cursor enter/leave callback functions.
     *
     *  @param[in] window The window that received the event.
     *  @param[in] entered `GLFW_TRUE` if the cursor entered the window's client
     *  area, or `GLFW_FALSE` if it left it.
     *
     *  @sa @ref cursor_enter
     *  @sa glfwSetCursorEnterCallback
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup input
     */
    typealias CursorEnterFun = (_ entered: Bool) -> Void

    /*  @brief The function signature for scroll callbacks.
     *
     *  This is the function signature for scroll callback functions.
     *
     *  @param[in] window The window that received the event.
     *  @param[in] xoffset The scroll offset along the x-axis.
     *  @param[in] yoffset The scroll offset along the y-axis.
     *
     *  @sa @ref scrolling
     *  @sa glfwSetScrollCallback
     *
     *  @since Added in version 3.0.  Replaces `GLFWmousewheelfun`.
     *
     *  @ingroup input
     */
    typealias ScrollFun = (_ offset: dvec2) -> Void

    /*  @brief The function signature for keyboard key callbacks.
     *
     *  This is the function signature for keyboard key callback functions.
     *
     *  @param[in] window The window that received the event.
     *  @param[in] key The [keyboard key](@ref keys) that was pressed or released.
     *  @param[in] scancode The system-specific scancode of the key.
     *  @param[in] action `GLFW_PRESS`, `GLFW_RELEASE` or `GLFW_REPEAT`.
     *  @param[in] mods Bit field describing which [modifier keys](@ref mods) were
     *  held down.
     *
     *  @sa @ref input_key
     *  @sa glfwSetKeyCallback
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added window handle, scancode and modifier mask parameters.
     *
     *  @ingroup input
     */
    typealias KeyFun = (Key, _ scancode: Int32, InputAction, ModModifier) -> Void

    /*  @brief The function signature for Unicode character callbacks.
     *
     *  This is the function signature for Unicode character callback functions.
     *
     *  @param[in] window The window that received the event.
     *  @param[in] codepoint The Unicode code point of the character.
     *
     *  @sa @ref input_char
     *  @sa glfwSetCharCallback
     *
     *  @since Added in version 2.4.
     *  @glfw3 Added window handle parameter.
     *
     *  @ingroup input
     */
    typealias CharFun = (_ codepoint: UInt32) -> Void

    /*  @brief The function signature for Unicode character with modifiers
     *  callbacks.
     *
     *  This is the function signature for Unicode character with modifiers callback
     *  functions.  It is called for each input character, regardless of what
     *  modifier keys are held down.
     *
     *  @param[in] window The window that received the event.
     *  @param[in] codepoint The Unicode code point of the character.
     *  @param[in] mods Bit field describing which [modifier keys](@ref mods) were
     *  held down.
     *
     *  @sa @ref input_char
     *  @sa glfwSetCharModsCallback
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup input
     */
    typealias CharModsFun = (_ codepoint: UInt32, ModModifier) -> Void

    /*  @brief The function signature for file drop callbacks.
     *
     *  This is the function signature for file drop callbacks.
     *
     *  @param[in] window The window that received the event.
     *  @param[in] count The number of dropped files.
     *  @param[in] paths The UTF-8 encoded file and/or directory path names.
     *
     *  @sa @ref path_drop
     *  @sa glfwSetDropCallback
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup input
     */
    typealias DropFun = (_ droppedFiles: Int32, _ paths: String...) -> Void

    /*  @brief The function signature for monitor configuration callbacks.
     *
     *  This is the function signature for monitor configuration callback functions.
     *
     *  @param[in] monitor The monitor that was connected or disconnected.
     *  @param[in] event One of `GLFW_CONNECTED` or `GLFW_DISCONNECTED`.
     *
     *  @sa @ref monitor_event
     *  @sa glfwSetMonitorCallback
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup monitor
     */
    typealias MonitorFun = (_ connected: Bool) -> Void

    /*  @brief The function signature for joystick configuration callbacks.
     *
     *  This is the function signature for joystick configuration callback
     *  functions.
     *
     *  @param[in] joy The joystick that was connected or disconnected.
     *  @param[in] event One of `GLFW_CONNECTED` or `GLFW_DISCONNECTED`.
     *
     *  @sa @ref joystick_event
     *  @sa glfwSetJoystickCallback
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup input
     */
    typealias JoystickFun = (Joystick, _ connected: Bool) -> Void

    /*  @brief Video mode type.
     *
     *  This describes a single video mode.
     *
     *  @sa @ref monitor_modes
     *  @sa glfwGetVideoMode glfwGetVideoModes
     *
     *  @since Added in version 1.0.
     *  @glfw3 Added refresh rate member.
     *
     *  @ingroup monitor
     */
    typealias VidMode = GLFWvidmode

    /*  @brief Gamma ramp.
     *
     *  This describes the gamma ramp for a monitor.
     *
     *  @sa @ref monitor_gamma
     *  @sa glfwGetGammaRamp glfwSetGammaRamp
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup monitor
     */
    typealias GammaRamp = GLFWgammaramp

    /*  @brief Image data.
     *
     *  @sa @ref cursor_custom
     *  @sa @ref window_icon
     *
     *  @since Added in version 2.1.
     *  @glfw3 Removed format and bytes-per-pixel members.
     */
    typealias Image = GLFWimage


    /*************************************************************************
     * GLFW API functions
     *************************************************************************/

    /*! @brief Initializes the GLFW library.
     *
     *  This function initializes the GLFW library.  Before most GLFW functions can
     *  be used, GLFW must be initialized, and before an application terminates GLFW
     *  should be terminated in order to free any resources allocated during or
     *  after initialization.
     *
     *  If this function fails, it calls @ref glfwTerminate before returning.  If it
     *  succeeds, you should call @ref glfwTerminate before the application exits.
     *
     *  Additional calls to this function after successful initialization but before
     *  termination will return `GLFW_TRUE` immediately.
     *
     *  @return `GLFW_TRUE` if successful, or `GLFW_FALSE` if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_PLATFORM_ERROR.
     *
     *  @remark @osx This function will change the current directory of the
     *  application to the `Contents/Resources` subdirectory of the application's
     *  bundle, if present.  This can be disabled with a
     *  [compile-time option](@ref compile_options_osx).
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref intro_init
     *  @sa glfwTerminate
     *
     *  @since Added in version 1.0.
     *
     *  @ingroup init
     */
    static func initialize() -> Bool {
        glfwInit().asBool
    }

    /*  @brief Terminates the GLFW library.
     *
     *  This function destroys all remaining windows and cursors, restores any
     *  modified gamma ramps and frees any other allocated resources.  Once this
     *  function is called, you must again call @ref glfwInit successfully before
     *  you will be able to use most GLFW functions.
     *
     *  If GLFW has been successfully initialized, this function should be called
     *  before the application exits.  If initialization fails, there is no need to
     *  call this function, as it is called by @ref glfwInit before it returns
     *  failure.
     *
     *  @errors Possible errors include @ref GLFW_PLATFORM_ERROR.
     *
     *  @remark This function may be called before @ref glfwInit.
     *
     *  @warning The contexts of any remaining windows must not be current on any
     *  other thread when this function is called.
     *
     *  @reentrancy This function must not be called from a callback.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref intro_init
     *  @sa glfwInit
     *
     *  @since Added in version 1.0.
     *
     *  @ingroup init
     */
    static func terminate() {
        glfwTerminate()
    }

    /*  @brief Retrieves the version of the GLFW library.
     *
     *  This function retrieves the major, minor and revision numbers of the GLFW
     *  library.  It is intended for when you are using GLFW as a shared library and
     *  want to ensure that you are using the minimum required version.
     *
     *  Any or all of the version arguments may be `NULL`.
     *
     *  @param[out] major Where to store the major version number, or `NULL`.
     *  @param[out] minor Where to store the minor version number, or `NULL`.
     *  @param[out] rev Where to store the revision number, or `NULL`.
     *
     *  @errors None.
     *
     *  @remark This function may be called before @ref glfwInit.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref intro_version
     *  @sa glfwGetVersionString
     *
     *  @since Added in version 1.0.
     *
     *  @ingroup init
     */
    static var version: (major: Int32, minor: Int32, rev: Int32) {
        get {
            var res = (0 as Int32, 0 as Int32, 0 as Int32)
            glfwGetVersion(&res.0, &res.1, &res.2)
            return res
        }
    }

    /*  @brief Returns a string describing the compile-time configuration.
     *
     *  This function returns the compile-time generated
     *  [version string](@ref intro_version_string) of the GLFW library binary.  It
     *  describes the version, platform, compiler and any platform-specific
     *  compile-time options.  It should not be confused with the OpenGL or OpenGL
     *  ES version string, queried with `glGetString`.
     *
     *  __Do not use the version string__ to parse the GLFW library version.  The
     *  @ref glfwGetVersion function provides the version of the running library
     *  binary in numerical format.
     *
     *  @return The ASCII encoded GLFW version string.
     *
     *  @errors None.
     *
     *  @remark This function may be called before @ref glfwInit.
     *
     *  @pointer_lifetime The returned string is static and compile-time generated.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref intro_version
     *  @sa glfwGetVersion
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup init
     */
    static var versionString: String {
        glfwGetVersionString().asString
    }

    /* @brief Sets the error callback.
     *
     *  This function sets the error callback, which is called with an error code
     *  and a human-readable description each time a GLFW error occurs.
     *
     *  The error callback is called on the thread where the error occurred.  If you
     *  are using GLFW from multiple threads, your error callback needs to be
     *  written accordingly.
     *
     *  Because the description string may have been generated specifically for that
     *  error, it is not guaranteed to be valid after the callback has returned.  If
     *  you wish to use it after the callback returns, you need to make a copy.
     *
     *  Once set, the error callback remains set even after the library has been
     *  terminated.
     *
     *  @param[in] cbfun The new callback, or `NULL` to remove the currently set
     *  callback.
     *  @return The previously set callback, or `NULL` if no callback was set.
     *
     *  @errors None.
     *
     *  @remark This function may be called before @ref glfwInit.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref error_handling
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup init
     */
    static func setErrorCallback(cbFun: @escaping ErrorFun) {
        glfw.errorCB = cbFun
        glfwSetErrorCallback { err, desc in
            glfw.errorCB!(Error(rawValue: err)!, String(utf8String: desc!)!)
        }
    }

    static var errorCB: ErrorFun?

    /*  @brief Returns the currently connected monitors.
     *
     *  This function returns an array of handles for all currently connected
     *  monitors.  The primary monitor is always first in the returned array.  If no
     *  monitors were found, this function returns `NULL`.
     *
     *  @param[out] count Where to store the number of monitors in the returned
     *  array.  This is set to zero if an error occurred.
     *  @return An array of monitor handles, or `NULL` if no monitors were found or
     *  if an [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @pointer_lifetime The returned array is allocated and freed by GLFW.  You
     *  should not free it yourself.  It is guaranteed to be valid only until the
     *  monitor configuration changes or the library is terminated.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref monitor_monitors
     *  @sa @ref monitor_event
     *  @sa glfwGetPrimaryMonitor
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup monitor
     */
    static var monitors: [Monitor] {
        var count: Int32 = 0
        let monitors = glfwGetMonitors(&count)!
        var res: [Monitor] = []
        res.reserveCapacity(Int(count))
        for i in 0..<Int(count) {
            res += monitors[i]! as Monitor
        }
        return res
    }

    /*  @brief Returns the primary monitor.
     *
     *  This function returns the primary monitor.  This is usually the monitor
     *  where elements like the task bar or global menu bar are located.
     *
     *  @return The primary monitor, or `NULL` if no monitors were found or if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @remark The primary monitor is always first in the array returned by @ref
     *  glfwGetMonitors.
     *
     *  @sa @ref monitor_monitors
     *  @sa glfwGetMonitors
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup monitor
     */
    static var primaryMonitor: Monitor {
        glfwGetPrimaryMonitor() as Monitor
    }

    // Monitor.swift

    /*  @brief Resets all window hints to their default values.
     *
     *  This function resets all window hints to their
     *  [default values](@ref window_hints_values).
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_hints
     *  @sa glfwWindowHint
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup window
     */
    static func defaultWindowHints() {
        glfwDefaultWindowHints()
    }

    /* @brief Sets the specified window hint to the desired value.
     *
     *  This function sets hints for the next call to @ref glfwCreateWindow.  The
     *  hints, once set, retain their values until changed by a call to @ref
     *  glfwWindowHint or @ref glfwDefaultWindowHints, or until the library is
     *  terminated.
     *
     *  This function does not check whether the specified hint values are valid.
     *  If you set hints to invalid values this will instead be reported by the next
     *  call to @ref glfwCreateWindow.
     *
     *  @param[in] hint The [window hint](@ref window_hints) to set.
     *  @param[in] value The new value of the window hint.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_INVALID_ENUM.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref window_hints
     *  @sa glfwDefaultWindowHints
     *
     *  @since Added in version 3.0.  Replaces `glfwOpenWindowHint`.
     *
     *  @ingroup window
     */
//GLFWAPI void glfwWindowHint(int hint, int value);

    // GlfwWindow.swift

    /*  @brief Processes all pending events.
     *
     *  This function processes only those events that are already in the event
     *  queue and then returns immediately.  Processing events will cause the window
     *  and input callbacks associated with those events to be called.
     *
     *  On some platforms, a window move, resize or menu operation will cause event
     *  processing to block.  This is due to how event processing is designed on
     *  those platforms.  You can use the
     *  [window refresh callback](@ref window_refresh) to redraw the contents of
     *  your window when necessary during such operations.
     *
     *  On some platforms, certain events are sent directly to the application
     *  without going through the event queue, causing callbacks to be called
     *  outside of a call to one of the event processing functions.
     *
     *  Event processing is not required for joystick input to work.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @reentrancy This function must not be called from a callback.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref events
     *  @sa glfwWaitEvents
     *  @sa glfwWaitEventsTimeout
     *
     *  @since Added in version 1.0.
     *
     *  @ingroup window
     */
    static func pollEvents() {
        glfwPollEvents()
    }

    /*  @brief Waits until events are queued and processes them.
     *
     *  This function puts the calling thread to sleep until at least one event is
     *  available in the event queue.  Once one or more events are available,
     *  it behaves exactly like @ref glfwPollEvents, i.e. the events in the queue
     *  are processed and the function then returns immediately.  Processing events
     *  will cause the window and input callbacks associated with those events to be
     *  called.
     *
     *  Since not all events are associated with callbacks, this function may return
     *  without a callback having been called even if you are monitoring all
     *  callbacks.
     *
     *  On some platforms, a window move, resize or menu operation will cause event
     *  processing to block.  This is due to how event processing is designed on
     *  those platforms.  You can use the
     *  [window refresh callback](@ref window_refresh) to redraw the contents of
     *  your window when necessary during such operations.
     *
     *  On some platforms, certain callbacks may be called outside of a call to one
     *  of the event processing functions.
     *
     *  If no windows exist, this function returns immediately.  For synchronization
     *  of threads in applications that do not create windows, use your threading
     *  library of choice.
     *
     *  Event processing is not required for joystick input to work.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @reentrancy This function must not be called from a callback.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref events
     *  @sa glfwPollEvents
     *  @sa glfwWaitEventsTimeout
     *
     *  @since Added in version 2.5.
     *
     *  @ingroup window
     */
    static func waitEvents() {
        glfwWaitEvents()
    }

    /*  @brief Waits with timeout until events are queued and processes them.
     *
     *  This function puts the calling thread to sleep until at least one event is
     *  available in the event queue, or until the specified timeout is reached.  If
     *  one or more events are available, it behaves exactly like @ref
     *  glfwPollEvents, i.e. the events in the queue are processed and the function
     *  then returns immediately.  Processing events will cause the window and input
     *  callbacks associated with those events to be called.
     *
     *  The timeout value must be a positive finite number.
     *
     *  Since not all events are associated with callbacks, this function may return
     *  without a callback having been called even if you are monitoring all
     *  callbacks.
     *
     *  On some platforms, a window move, resize or menu operation will cause event
     *  processing to block.  This is due to how event processing is designed on
     *  those platforms.  You can use the
     *  [window refresh callback](@ref window_refresh) to redraw the contents of
     *  your window when necessary during such operations.
     *
     *  On some platforms, certain callbacks may be called outside of a call to one
     *  of the event processing functions.
     *
     *  If no windows exist, this function returns immediately.  For synchronization
     *  of threads in applications that do not create windows, use your threading
     *  library of choice.
     *
     *  Event processing is not required for joystick input to work.
     *
     *  @param[in] timeout The maximum amount of time, in seconds, to wait.
     *
     *  @reentrancy This function must not be called from a callback.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref events
     *  @sa glfwPollEvents
     *  @sa glfwWaitEvents
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup window
     */
    static func waitEventsTimeout(timeout: Double) {
        glfwWaitEventsTimeout(timeout)
    }

    /*  @brief Posts an empty event to the event queue.
     *
     *  This function posts an empty event from the current thread to the event
     *  queue, causing @ref glfwWaitEvents or @ref glfwWaitEventsTimeout to return.
     *
     *  If no windows exist, this function returns immediately.  For synchronization
     *  of threads in applications that do not create windows, use your threading
     *  library of choice.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref events
     *  @sa glfwWaitEvents
     *  @sa glfwWaitEventsTimeout
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup window
     */
    static func postEmptyEvent() {
        glfwPostEmptyEvent()
    }

    static func getKeyName(scancode: Int32) -> String {
        String(cString: glfwGetKeyName(Key.unknown.rawValue, scancode))
    }

    /*  @brief Creates a custom cursor.
     *
     *  Creates a new custom cursor image that can be set for a window with @ref
     *  glfwSetCursor.  The cursor can be destroyed with @ref glfwDestroyCursor.
     *  Any remaining cursors are destroyed by @ref glfwTerminate.
     *
     *  The pixels are 32-bit, little-endian, non-premultiplied RGBA, i.e. eight
     *  bits per channel.  They are arranged canonically as packed sequential rows,
     *  starting from the top-left corner.
     *
     *  The cursor hotspot is specified in pixels, relative to the upper-left corner
     *  of the cursor image.  Like all other coordinate systems in GLFW, the X-axis
     *  points to the right and the Y-axis points down.
     *
     *  @param[in] image The desired cursor image.
     *  @param[in] xhot The desired x-coordinate, in pixels, of the cursor hotspot.
     *  @param[in] yhot The desired y-coordinate, in pixels, of the cursor hotspot.
     *  @return The handle of the created cursor, or `NULL` if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @pointer_lifetime The specified image data is copied before this function
     *  returns.
     *
     *  @reentrancy This function must not be called from a callback.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref cursor_object
     *  @sa glfwDestroyCursor
     *  @sa glfwCreateStandardCursor
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup input
     */
    static func createCursor(image: Image, hot: ivec2) -> Cursor {
        var i = image
        return glfwCreateCursor(&i, hot.x, hot.y)
    }

    /*  @brief Creates a cursor with a standard shape.
     *
     *  Returns a cursor with a [standard shape](@ref shapes), that can be set for
     *  a window with @ref glfwSetCursor.
     *
     *  @param[in] shape One of the [standard shapes](@ref shapes).
     *  @return A new cursor ready to use or `NULL` if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_INVALID_ENUM and @ref GLFW_PLATFORM_ERROR.
     *
     *  @reentrancy This function must not be called from a callback.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref cursor_object
     *  @sa glfwCreateCursor
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup input
     */
    static func createStandardCursor(shape: CursorShape) -> Cursor {
        glfwCreateStandardCursor(shape.rawValue)
    }

    /*  @brief Destroys a cursor.
     *
     *  This function destroys a cursor previously created with @ref
     *  glfwCreateCursor.  Any remaining cursors will be destroyed by @ref
     *  glfwTerminate.
     *
     *  @param[in] cursor The cursor object to destroy.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @reentrancy This function must not be called from a callback.
     *
     *  @thread_safety This function must only be called from the main thread.
     *
     *  @sa @ref cursor_object
     *  @sa glfwCreateCursor
     *
     *  @since Added in version 3.1.
     *
     *  @ingroup input
     */
    static func destroyCursor(cursor: Cursor) {
        glfwDestroyCursor(cursor)
    }

    /*! @brief Sets the joystick configuration callback.
     *
     *  This function sets the joystick configuration callback, or removes the
     *  currently set callback.  This is called when a joystick is connected to or
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
     *  @sa @ref joystick_event
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup input
     */
    static func setJoystickCallback(cbfun: @escaping JoystickFun) {
        glfw.joystickCB = cbfun
        glfwSetJoystickCallback { joystick, connected in
            glfw.joystickCB!(Joystick(rawValue: joystick)!, connected == GLFW_CONNECTED)
        }
    }

    static var joystickCB: JoystickFun?

    static var time: Double {
        /*  @brief Returns the value of the GLFW timer.
         *
         *  This function returns the value of the GLFW timer.  Unless the timer has
         *  been set using @ref glfwSetTime, the timer measures time elapsed since GLFW
         *  was initialized.
         *
         *  The resolution of the timer is system dependent, but is usually on the order
         *  of a few micro- or nanoseconds.  It uses the highest-resolution monotonic
         *  time source on each supported platform.
         *
         *  @return The current value, in seconds, or zero if an
         *  [error](@ref error_handling) occurred.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
         *
         *  @thread_safety This function may be called from any thread.  Reading and
         *  writing of the internal timer offset is not atomic, so it needs to be
         *  externally synchronized with calls to @ref glfwSetTime.
         *
         *  @sa @ref time
         *
         *  @since Added in version 1.0.
         *
         *  @ingroup input
         */
        get {
            glfwGetTime()
        }
        /*  @brief Sets the GLFW timer.
         *
         *  This function sets the value of the GLFW timer.  It then continues to count
         *  up from that value.  The value must be a positive finite number less than
         *  or equal to 18446744073.0, which is approximately 584.5 years.
         *
         *  @param[in] time The new value, in seconds.
         *
         *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
         *  GLFW_INVALID_VALUE.
         *
         *  @remark The upper limit of the timer is calculated as
         *  floor((2<sup>64</sup> - 1) / 10<sup>9</sup>) and is due to implementations
         *  storing nanoseconds in 64 bits.  The limit may be increased in the future.
         *
         *  @thread_safety This function may be called from any thread.  Reading and
         *  writing of the internal timer offset is not atomic, so it needs to be
         *  externally synchronized with calls to @ref glfwGetTime.
         *
         *  @sa @ref time
         *
         *  @since Added in version 2.2.
         *
         *  @ingroup input
         */
        set {
            glfwSetTime(newValue)
        }
    }

    /*  @brief Returns the current value of the raw timer.
     *
     *  This function returns the current value of the raw timer, measured in
     *  1&nbsp;/&nbsp;frequency seconds.  To get the frequency, call @ref
     *  glfwGetTimerFrequency.
     *
     *  @return The value of the timer, or zero if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref time
     *  @sa glfwGetTimerFrequency
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup input
     */
    static var timerValue: UInt64 {
        glfwGetTimerValue()
    }

    /*  @brief Returns the frequency, in Hz, of the raw timer.
     *
     *  This function returns the frequency, in Hz, of the raw timer.
     *
     *  @return The frequency of the timer, in Hz, or zero if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref time
     *  @sa glfwGetTimerValue
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup input
     */
    static var timerFrequency: UInt64 {
        glfwGetTimerFrequency()
    }

    /*  @brief Returns the window whose context is current on the calling thread.
     *
     *  This function returns the window whose OpenGL or OpenGL ES context is
     *  current on the calling thread.
     *
     *  @return The window whose context is current, or `NULL` if no window's
     *  context is current.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref context_current
     *  @sa glfwMakeContextCurrent
     *
     *  @since Added in version 3.0.
     *
     *  @ingroup context
     */
    static var currentContext: Window {
        glfwGetCurrentContext()
    }

    /*  @brief Sets the swap interval for the current context.
     *
     *  This function sets the swap interval for the current OpenGL or OpenGL ES
     *  context, i.e. the number of screen updates to wait from the time @ref
     *  glfwSwapBuffers was called before swapping the buffers and returning.  This
     *  is sometimes called _vertical synchronization_, _vertical retrace
     *  synchronization_ or just _vsync_.
     *
     *  Contexts that support either of the `WGL_EXT_swap_control_tear` and
     *  `GLX_EXT_swap_control_tear` extensions also accept negative swap intervals,
     *  which allow the driver to swap even if a frame arrives a little bit late.
     *  You can check for the presence of these extensions using @ref
     *  glfwExtensionSupported.  For more information about swap tearing, see the
     *  extension specifications.
     *
     *  A context must be current on the calling thread.  Calling this function
     *  without a current context will cause a @ref GLFW_NO_CURRENT_CONTEXT error.
     *
     *  This function does not apply to Vulkan.  If you are rendering with Vulkan,
     *  see the present mode of your swapchain instead.
     *
     *  @param[in] interval The minimum number of screen updates to wait for
     *  until the buffers are swapped by @ref glfwSwapBuffers.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_NO_CURRENT_CONTEXT and @ref GLFW_PLATFORM_ERROR.
     *
     *  @remark This function is not called during context creation, leaving the
     *  swap interval set to whatever is the default on that platform.  This is done
     *  because some swap interval extensions used by GLFW do not allow the swap
     *  interval to be reset to zero once it has been set to a non-zero value.
     *
     *  @remark Some GPU drivers do not honor the requested swap interval, either
     *  because of a user setting that overrides the application's request or due to
     *  bugs in the driver.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref buffer_swap
     *  @sa glfwSwapBuffers
     *
     *  @since Added in version 1.0.
     *
     *  @ingroup context
     */
    static func swapInterval(_ interval: Int32) {
        glfwSwapInterval(interval)
    }

    /*  @brief Returns whether the specified extension is available.
     *
     *  This function returns whether the specified
     *  [API extension](@ref context_glext) is supported by the current OpenGL or
     *  OpenGL ES context.  It searches both for client API extension and context
     *  creation API extensions.
     *
     *  A context must be current on the calling thread.  Calling this function
     *  without a current context will cause a @ref GLFW_NO_CURRENT_CONTEXT error.
     *
     *  As this functions retrieves and searches one or more extension strings each
     *  call, it is recommended that you cache its results if it is going to be used
     *  frequently.  The extension strings will not change during the lifetime of
     *  a context, so there is no danger in doing this.
     *
     *  This function does not apply to Vulkan.  If you are using Vulkan, see @ref
     *  glfwGetRequiredInstanceExtensions, `vkEnumerateInstanceExtensionProperties`
     *  and `vkEnumerateDeviceExtensionProperties` instead.
     *
     *  @param[in] extension The ASCII encoded name of the extension.
     *  @return `GLFW_TRUE` if the extension is available, or `GLFW_FALSE`
     *  otherwise.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_NO_CURRENT_CONTEXT, @ref GLFW_INVALID_VALUE and @ref
     *  GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref context_glext
     *  @sa glfwGetProcAddress
     *
     *  @since Added in version 1.0.
     *
     *  @ingroup context
     */
    func extensionSupported(extension: String) -> Bool {
        `extension`.withCString {
            glfwExtensionSupported($0) == GLFW_TRUE
        }
    }

//
///*! @brief Returns the address of the specified function for the current
// *  context.
// *
// *  This function returns the address of the specified OpenGL or OpenGL ES
// *  [core or extension function](@ref context_glext), if it is supported
// *  by the current context.
// *
// *  A context must be current on the calling thread.  Calling this function
// *  without a current context will cause a @ref GLFW_NO_CURRENT_CONTEXT error.
// *
// *  This function does not apply to Vulkan.  If you are rendering with Vulkan,
// *  see @ref glfwGetInstanceProcAddress, `vkGetInstanceProcAddr` and
// *  `vkGetDeviceProcAddr` instead.
// *
// *  @param[in] procname The ASCII encoded name of the function.
// *  @return The address of the function, or `NULL` if an
// *  [error](@ref error_handling) occurred.
// *
// *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
// *  GLFW_NO_CURRENT_CONTEXT and @ref GLFW_PLATFORM_ERROR.
// *
// *  @remark The address of a given function is not guaranteed to be the same
// *  between contexts.
// *
// *  @remark This function may return a non-`NULL` address despite the
// *  associated version or extension not being available.  Always check the
// *  context version or extension string first.
// *
// *  @pointer_lifetime The returned function pointer is valid until the context
// *  is destroyed or the library is terminated.
// *
// *  @thread_safety This function may be called from any thread.
// *
// *  @sa @ref context_glext
// *  @sa glfwExtensionSupported
// *
// *  @since Added in version 1.0.
// *
// *  @ingroup context
// */
//GLFWAPI GLFWglproc glfwGetProcAddress(const char* procname);

    /*  @brief Returns whether the Vulkan loader has been found.
     *
     *  This function returns whether the Vulkan loader has been found.  This check
     *  is performed by @ref glfwInit.
     *
     *  The availability of a Vulkan loader does not by itself guarantee that window
     *  surface creation or even device creation is possible.  Call @ref
     *  glfwGetRequiredInstanceExtensions to check whether the extensions necessary
     *  for Vulkan surface creation are available and @ref
     *  glfwGetPhysicalDevicePresentationSupport to check whether a queue family of
     *  a physical device supports image presentation.
     *
     *  @return `GLFW_TRUE` if Vulkan is available, or `GLFW_FALSE` otherwise.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref vulkan_support
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup vulkan
     */
    func vulkanSupported() -> Bool {
        glfwVulkanSupported() == GLFW_TRUE
    }

    /*  @brief Returns the Vulkan instance extensions required by GLFW.
     *
     *  This function returns an array of names of Vulkan instance extensions required
     *  by GLFW for creating Vulkan surfaces for GLFW windows.  If successful, the
     *  list will always contains `VK_KHR_surface`, so if you don't require any
     *  additional extensions you can pass this list directly to the
     *  `VkInstanceCreateInfo` struct.
     *
     *  If Vulkan is not available on the machine, this function returns `NULL` and
     *  generates a @ref GLFW_API_UNAVAILABLE error.  Call @ref glfwVulkanSupported
     *  to check whether Vulkan is available.
     *
     *  If Vulkan is available but no set of extensions allowing window surface
     *  creation was found, this function returns `NULL`.  You may still use Vulkan
     *  for off-screen rendering and compute work.
     *
     *  @param[out] count Where to store the number of extensions in the returned
     *  array.  This is set to zero if an error occurred.
     *  @return An array of ASCII encoded extension names, or `NULL` if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
     *  GLFW_API_UNAVAILABLE.
     *
     *  @remarks Additional extensions may be required by future versions of GLFW.
     *  You should check if any extensions you wish to enable are already in the
     *  returned array, as it is an error to specify an extension more than once in
     *  the `VkInstanceCreateInfo` struct.
     *
     *  @pointer_lifetime The returned array is allocated and freed by GLFW.  You
     *  should not free it yourself.  It is guaranteed to be valid only until the
     *  library is terminated.
     *
     *  @thread_safety This function may be called from any thread.
     *
     *  @sa @ref vulkan_ext
     *  @sa glfwCreateWindowSurface
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup vulkan
     */
    func getRequiredInstanceExtensions() -> [String] {
        var count: UInt32 = 0
        let exts = glfwGetRequiredInstanceExtensions(&count)!
        var res: [String] = []
        res.reserveCapacity(Int(count))
        for i in 0..<Int(count) {
            res += String(cString: exts[i]!)
        }
        return res
    }

    #if true

/*! @brief Returns the address of the specified Vulkan instance function.
 *
 *  This function returns the address of the specified Vulkan core or extension
 *  function for the specified instance.  If instance is set to `NULL` it can
 *  return any function exported from the Vulkan loader, including at least the
 *  following functions:
 *
 *  - `vkEnumerateInstanceExtensionProperties`
 *  - `vkEnumerateInstanceLayerProperties`
 *  - `vkCreateInstance`
 *  - `vkGetInstanceProcAddr`
 *
 *  If Vulkan is not available on the machine, this function returns `NULL` and
 *  generates a @ref GLFW_API_UNAVAILABLE error.  Call @ref glfwVulkanSupported
 *  to check whether Vulkan is available.
 *
 *  This function is equivalent to calling `vkGetInstanceProcAddr` with
 *  a platform-specific query of the Vulkan loader as a fallback.
 *
 *  @param[in] instance The Vulkan instance to query, or `NULL` to retrieve
 *  functions related to instance creation.
 *  @param[in] procname The ASCII encoded name of the function.
 *  @return The address of the function, or `NULL` if an
 *  [error](@ref error_handling) occurred.
 *
 *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
 *  GLFW_API_UNAVAILABLE.
 *
 *  @pointer_lifetime The returned function pointer is valid until the library
 *  is terminated.
 *
 *  @thread_safety This function may be called from any thread.
 *
 *  @sa @ref vulkan_proc
 *
 *  @since Added in version 3.2.
 *
 *  @ingroup vulkan
 */
//GLFWAPI GLFWvkproc glfwGetInstanceProcAddress(VkInstance instance, const char* procname);

    /*  @brief Returns whether the specified queue family can present images.
     *
     *  This function returns whether the specified queue family of the specified
     *  physical device supports presentation to the platform GLFW was built for.
     *
     *  If Vulkan or the required window surface creation instance extensions are
     *  not available on the machine, or if the specified instance was not created
     *  with the required extensions, this function returns `GLFW_FALSE` and
     *  generates a @ref GLFW_API_UNAVAILABLE error.  Call @ref glfwVulkanSupported
     *  to check whether Vulkan is available and @ref
     *  glfwGetRequiredInstanceExtensions to check what instance extensions are
     *  required.
     *
     *  @param[in] instance The instance that the physical device belongs to.
     *  @param[in] device The physical device that the queue family belongs to.
     *  @param[in] queuefamily The index of the queue family to query.
     *  @return `GLFW_TRUE` if the queue family supports presentation, or
     *  `GLFW_FALSE` otherwise.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_API_UNAVAILABLE and @ref GLFW_PLATFORM_ERROR.
     *
     *  @thread_safety This function may be called from any thread.  For
     *  synchronization details of Vulkan objects, see the Vulkan specification.
     *
     *  @sa @ref vulkan_present
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup vulkan
     */
    func getPhysicalDevicePresentationSupport(instance: VkInstance, device: VkPhysicalDevice, queuefamily: Int) -> Bool {
        glfwGetPhysicalDevicePresentationSupport(instance, device, UInt32(queuefamily)) == GLFW_TRUE
    }

    /*  @brief Creates a Vulkan surface for the specified window.
     *
     *  This function creates a Vulkan surface for the specified window.
     *
     *  If the Vulkan loader was not found at initialization, this function returns
     *  `VK_ERROR_INITIALIZATION_FAILED` and generates a @ref GLFW_API_UNAVAILABLE
     *  error.  Call @ref glfwVulkanSupported to check whether the Vulkan loader was
     *  found.
     *
     *  If the required window surface creation instance extensions are not
     *  available or if the specified instance was not created with these extensions
     *  enabled, this function returns `VK_ERROR_EXTENSION_NOT_PRESENT` and
     *  generates a @ref GLFW_API_UNAVAILABLE error.  Call @ref
     *  glfwGetRequiredInstanceExtensions to check what instance extensions are
     *  required.
     *
     *  The window surface must be destroyed before the specified Vulkan instance.
     *  It is the responsibility of the caller to destroy the window surface.  GLFW
     *  does not destroy it for you.  Call `vkDestroySurfaceKHR` to destroy the
     *  surface.
     *
     *  @param[in] instance The Vulkan instance to create the surface in.
     *  @param[in] window The window to create the surface for.
     *  @param[in] allocator The allocator to use, or `NULL` to use the default
     *  allocator.
     *  @param[out] surface Where to store the handle of the surface.  This is set
     *  to `VK_NULL_HANDLE` if an error occurred.
     *  @return `VK_SUCCESS` if successful, or a Vulkan error code if an
     *  [error](@ref error_handling) occurred.
     *
     *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
     *  GLFW_API_UNAVAILABLE and @ref GLFW_PLATFORM_ERROR.
     *
     *  @remarks If an error occurs before the creation call is made, GLFW returns
     *  the Vulkan error code most appropriate for the error.  Appropriate use of
     *  @ref glfwVulkanSupported and @ref glfwGetRequiredInstanceExtensions should
     *  eliminate almost all occurrences of these errors.
     *
     *  @thread_safety This function may be called from any thread.  For
     *  synchronization details of Vulkan objects, see the Vulkan specification.
     *
     *  @sa @ref vulkan_surface
     *  @sa glfwGetRequiredInstanceExtensions
     *
     *  @since Added in version 3.2.
     *
     *  @ingroup vulkan
     */
    func createWindowSurface(instance: VkInstance, window: Window?, surface: UnsafeMutablePointer<VkSurfaceKHR?>?) -> VkResult {
        glfwCreateWindowSurface(instance, window, nil, surface)
    }

    #endif
}