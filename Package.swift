// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    targets: [
        .target(name: "SwiftExtensions"),
        .testTarget(
            name: "SwiftExtensionsTests",
            dependencies: ["SwiftExtensions"],
            resources: [.process("Resources")]),
    
        .target(name: "SwiftExtensionsUI"),
        
        .target(name: "SwiftExtensionsUIKit", dependencies: ["SwiftExtensions"]),
        .testTarget(
            name: "SwiftExtensionsUIKitTests",
            dependencies: ["SwiftExtensionsUIKit"],
            resources: [.process("Resources")]),
    ]
)

package.products = package.targets
    .filter { !$0.isTest }
    .map { Product.library(name: $0.name, targets: [$0.name]) }
