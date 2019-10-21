// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "SwiftExtensions",
            targets: ["SwiftExtensions"])
    ],
    targets: [
        .target(
            name: "SwiftExtensions",
            path: "Sources"),
        .testTarget(
            name: "SwiftExtensionsTests",
            dependencies: ["SwiftExtensions"],
            path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)

