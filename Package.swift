// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aoc-2023-swift",
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "aoc-2023-swift"),
        .testTarget(
            name: "aoc-2023-swifttest",
            dependencies: ["aoc-2023-swift"],
            path: "Tests"
        ),
    ]
)