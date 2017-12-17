//
//  ArrayTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class ArrayTests: XCTestCase {
    
    func testRemove() {
        var array: [String] = ["foo", "bar"]
        let index = array.remove("bar")
        XCTAssertEqual(index, 1)
        XCTAssertEqual(array, ["foo"])
    }

    func testRemoveNonExistentElement() {
        var array: [String] = ["foo", "bar"]
        let index = array.remove("baz")
        XCTAssertEqual(index, nil)
        XCTAssertEqual(array, ["foo", "bar"])
    }

    func testRemoveElements() {
        var array: [String] = ["foo", "bar", "baz"]
        let indices = array.remove(["baz", "foo"])
        XCTAssertNotEqual(indices, [0, 2])
        XCTAssertEqual(indices, [2, 0])
        XCTAssertEqual(array, ["bar"])
    }

    func testRemoveNonExistentElements() {
        var array: [String] = ["foo"]
        let indices = array.remove(["bar", "baz"])
        XCTAssertEqual(indices, [])
        XCTAssertEqual(array, ["foo"])
    }

    func testRemoveExistentAndNonExistentElement() {
        var array: [String] = ["foo", "bar"]
        let indices = array.remove(["foo", "baz"])
        XCTAssertEqual(indices, [0])
        XCTAssertEqual(array, ["bar"])
    }
}

extension ArrayTests {
    func testUnified() {
        let array = [1, 2, 3, 3, 2, 1, 4]
        let unifiedArray = array.unified()
        XCTAssertEqual(array, [1, 2, 3, 3, 2, 1, 4])
        XCTAssertEqual(unifiedArray, [1, 2, 3, 4])
    }

    func testUnify() {
        var array = [1, 2, 3, 3, 2, 1, 4]
        array.unify()
        XCTAssertEqual(array, [1, 2, 3, 4])
    }
}
