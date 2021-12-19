//
//  CaseIterableTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 2019/04/11.
//  Copyright © 2019 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class CaseIterableTests: XCTestCase {
    func testCaseIndexSimple() {
        enum A: CaseIterable {
            case 🐶
            case 🐱
            case 🐭
        }
        XCTAssertEqual(A.🐶.caseIndex, 0)
        XCTAssertEqual(A.🐱.caseIndex, 1)
        XCTAssertEqual(A.🐭.caseIndex, 2)
    }

    func testCaseIndexRawValue() {
        enum A: String, CaseIterable {
            case 🐶 = "dog"
            case 🐱 = "cat"
            case 🐭 = "mouse"
        }
        XCTAssertEqual(A.🐶.caseIndex, 0)
        XCTAssertEqual(A.🐱.caseIndex, 1)
        XCTAssertEqual(A.🐭.caseIndex, 2)
    }
}
