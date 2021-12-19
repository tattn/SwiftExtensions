//
//  ComparableTests.swift
//  
//
//  Created by Tatsuya Tanaka on 2021/12/20.
//

import XCTest

class ComparableTests: XCTestCase {
    func testClampedClosedRange() throws {
        XCTAssertEqual(10.clamped(to: 0...5), 5)
        XCTAssertEqual(-2.clamped(to: 0...5), -2)
        XCTAssertEqual((-2).clamped(to: 0...5), 0)
        XCTAssertEqual(3.clamped(to: 0...5), 3)
        XCTAssertEqual(0.clamped(to: 0...5), 0)
        XCTAssertEqual(5.clamped(to: 0...5), 5)
    }
}
