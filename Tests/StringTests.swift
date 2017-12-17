//
//  StringTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class StringTests: XCTestCase {

    func testLocalized() {
        XCTAssertEqual("hello".localized, "hello")
//        UserDefaults.standard.set(["ja"], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        XCTAssertEqual("hello".localized, "こんにちは")
    }
}

extension StringTests {
    func testUrl() {
        let string = "https://example.com"
        XCTAssertEqual(string.url, URL(string: "https://example.com")!)
    }

    func testUrlNil() {
        let string = "🐱"
        XCTAssertNil(string.url)
    }
}

extension StringTests {
    func testRangeSubscript() {
        let string = "0123456789"
        XCTAssertEqual(string[0...5], "012345")
        XCTAssertEqual(string[1...3], "123")
        XCTAssertEqual(string[3..<7], "3456")
        XCTAssertEqual(string[...4], "01234")
        XCTAssertEqual(string[..<4], "0123")
        XCTAssertEqual(string[4...], "456789")
    }
}
