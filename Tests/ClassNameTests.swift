//
//  ClassNameTests.swift
//  ClassNameTests
//
//  Created by Tatsuya Tanaka on 20171213.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class ClassNameTests: XCTestCase {
    let expectedClassName = "ClassNameTests"

    func testStaticClassName() {
        XCTAssertEqual(ClassNameTests.className, expectedClassName)
    }

    func testInstanceClassName() {
        XCTAssertEqual(ClassNameTests().className, expectedClassName)
    }
}
