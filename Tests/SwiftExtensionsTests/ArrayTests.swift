//
//  ArrayTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class ArrayTests: XCTestCase {
    
    func testRemove() {
        var array: [String] = ["foo", "bar"]
        let index = array.removeFirst("bar")
        XCTAssertEqual(index, 1)
        XCTAssertEqual(array, ["foo"])
    }

    func testRemoveNonExistentElement() {
        var array: [String] = ["foo", "bar"]
        let index = array.removeFirst("baz")
        XCTAssertEqual(index, nil)
        XCTAssertEqual(array, ["foo", "bar"])
    }

    func testRemoveElements() {
        var array: [String] = ["foo", "bar", "baz"]
        let indices = array.removeFirst(["baz", "foo"])
        XCTAssertNotEqual(indices, [0, 2])
        XCTAssertEqual(indices, [2, 0])
        XCTAssertEqual(array, ["bar"])
    }

    func testRemoveNonExistentElements() {
        var array: [String] = ["foo"]
        let indices = array.removeFirst(["bar", "baz"])
        XCTAssertEqual(indices, [])
        XCTAssertEqual(array, ["foo"])
    }

    func testRemoveExistentAndNonExistentElement() {
        var array: [String] = ["foo", "bar"]
        let indices = array.removeFirst(["foo", "baz"])
        XCTAssertEqual(indices, [0])
        XCTAssertEqual(array, ["bar"])
    }
}

extension ArrayTests {
    func testUniqued() {
        let array = [1, 2, 3, 3, 2, 1, 4]
        let unifiedArray = array.uniqued()
        XCTAssertEqual(array, [1, 2, 3, 3, 2, 1, 4])
        XCTAssertEqual(unifiedArray, [1, 2, 3, 4])
    }

    func testUnique() {
        var array = [1, 2, 3, 3, 2, 1, 4]
        array.unique()
        XCTAssertEqual(array, [1, 2, 3, 4])
    }
}

extension ArrayTests {
    func testSafeSubscript() {
        let array = [0, 1, 2, 3]
        XCTAssertNil(array[safe: 4])
    }
}
