// swift-tools-version:5.5
import PackageDescription

let frameworks = [
    "SwiftExtensions",
    "SwiftExtensionsUI",
    "SwiftExtensionsUIKit",
]

let package = Package(
    name: "SwiftExtensions",
    products: frameworks.map {
        .library(name: $0, targets: [$0])
    },
    targets: frameworks.map {
        .binaryTarget(name: $0, path: "\($0).xcframework")
    }
)

