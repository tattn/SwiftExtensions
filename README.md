SwiftExtensions
===

[![Build Status](https://github.com/tattn/SwiftExtensions/actions/workflows/ci.yml/badge.svg)](https://github.com/tattn/SwiftExtensions/actions/workflows/ci.yml)
[![Swift Package Manager compatible](https://img.shields.io/badge/SwiftPackageManager-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Version](https://img.shields.io/badge/Swift-5.5-F16D39.svg)](https://developer.apple.com/swift)

My favorite Swift extensions.

# Installation

## Swift Package Manager

You can install this package with Swift Package Manager.

### Recommended
```swift
dependencies: [
    .package(
        name: "SwiftExtensions",
        url: "https://github.com/tattn/SwiftExtensions.git",
        from: "3.0.0-beta.1"
    ),
],
```

### Experimental (Prebuild packages)
```swift
dependencies: [
    .package(
        name: "SwiftExtensions",
        url: "https://github.com/tattn/SwiftExtensionsXCFramework.git",
        from: "3.0.0-beta.1"
    ),
],
```

# Usage

```swift
// Main features
@_exported import SwiftExtensions
// for SwiftUI
@_exported import SwiftExtensionsUI
// for UIKit
@_exported import SwiftExtensionsUIKit
```

# Docs
- [My favorite ❤️ Swift extensions](https://dev.to/tattn/my-favorite--swift-extensions-8g7) (English)
- [使うと手放せなくなるSwift Extension集 (Swift 5版) - Qiita](https://qiita.com/tattn/items/ff50e575bc149ecb8e80) (Japanese)

# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

# License

SwiftExtensions is released under the MIT license. See LICENSE for details.
