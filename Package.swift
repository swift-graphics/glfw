// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "glfw_",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "glfw",
            targets: ["glfw_"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "../glm", .revision("bb49a7ea79941b46802f4bddf56288be60ce5dbf"))
    ],
    targets: [
        .systemLibrary(name: "glfwNative", pkgConfig: "glfw3"),
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "glfw_",
            dependencies: ["glm", "glfwNative"]),
        .testTarget(
            name: "glfwTests",
            dependencies: ["glfw_", "glm"]),
    ]
)
