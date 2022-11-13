// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlatformSpecificValue",
    products: [
        .library(
            name: "PlatformSpecificValue",
            targets: ["PlatformSpecificValue"]),
    ],
    targets: [
        .target(
            name: "PlatformSpecificValue",
            dependencies: []),
        .testTarget(
            name: "PlatformSpecificValueTests",
            dependencies: ["PlatformSpecificValue"]),
    ]
)
