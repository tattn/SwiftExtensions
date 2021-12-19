//
//  NSObjectTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171213.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
@testable import SwiftExtensionsUIKit

class SwiftExtensionsTests: XCTestCase {
    let expectedClassName = "SwiftExtensionsTests"

    func testStaticClassName() {
        XCTAssertEqual(SwiftExtensionsTests.className, expectedClassName)
    }

    #if !SWIFT_PACKAGE // avoid a bug
    func testInstanceClassName() {
        XCTAssertEqual(SwiftExtensionsTests().className, expectedClassName)
    }
    #endif

    func testStaticStructName() {
        struct StructType: ClassNameProtocol {}
        XCTAssertEqual(StructType.className, "StructType")
    }

    func testInstanceStructName() {
        struct StructType: ClassNameProtocol {}
        XCTAssertEqual(StructType().className, "StructType")
    }
}

extension SwiftExtensionsTests {
    func testDescribedProperty() {
        class Foo: NSObject {
            var foo = 1
            let bar = "bar"
        }

        XCTAssertEqual(Foo().propertyDescription, "foo: 1\nbar: bar")
    }
}
