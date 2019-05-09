//
//  NSObjectTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171213.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import BTSwiftExtensions

class BTSwiftExtensionsTests: XCTestCase {
    let expectedClassName = "BTSwiftExtensionsTests"

    func testStaticClassName() {
        XCTAssertEqual(BTSwiftExtensionsTests.className, expectedClassName)
    }

    func testInstanceClassName() {
        XCTAssertEqual(BTSwiftExtensionsTests().className, expectedClassName)
    }
}

extension BTSwiftExtensionsTests {
    func testDescribedProperty() {
        class Foo: NSObject {
            var foo = 1
            let bar = "bar"
        }

        XCTAssertEqual(Foo().describedProperty, "foo: 1\nbar: bar")
    }
}
