// swift-tools-version:5.5

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
//        .testTarget(
//            name: "SwiftExtensionsUITests",
//            dependencies: ["SwiftExtensionsUI"]),
        
        .target(name: "SwiftExtensionsUIKit", dependencies: ["SwiftExtensions"]),
        .testTarget(
            name: "SwiftExtensionsUIKitTests",
            dependencies: ["SwiftExtensionsUIKit"],
            resources: [.process("Resources")]),
    ]
)

package.targets = package.targets + [
	.binaryTarget(
		name: "SwiftExtensionsBinary",
		url: "https://github.com/tattn/SwiftExtensions/releases/download/3.0.0-beta.0/SwiftExtensions.xcframework.zip",
		checksum: "7d27ecd7a147880885d7166f4e39560afb58c7c7f44ed08c30dd32a8089ea564"
	),
	.binaryTarget(
		name: "SwiftExtensionsUIBinary",
		url: "https://github.com/tattn/SwiftExtensions/releases/download/3.0.0-beta.0/SwiftExtensionsUI.xcframework.zip",
		checksum: "c07fd7cf1f13c5dd0a50dcb9fdcf30a60c8f34adc64d1c8ae945902c58c2e40d"
	),
	.binaryTarget(
		name: "SwiftExtensionsUIKitBinary",
		url: "https://github.com/tattn/SwiftExtensions/releases/download/3.0.0-beta.0/SwiftExtensionsUIKit.xcframework.zip",
		checksum: "52cef3f130e066bc2cf5e20621267f4f622746519e3646ac743c009fa9471a5d"
	),
]

package.products = package.targets
    .filter { !$0.isTest }
    .map { Product.library(name: $0.name, targets: [$0.name]) }
