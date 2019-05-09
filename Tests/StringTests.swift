//
//  StringTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import BTSwiftExtensions

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

extension StringTests {
    func testHalfWidthFullNumberToHalf() {
        let target = "１２３"
        let expected = "123"
        XCTAssertEqual(expected, target.halfWidth)
    }

    func testHalfWidthHalfNumberToHalf() {
        let target = "12345"
        let expected = "12345"
        XCTAssertEqual(expected, target.halfWidth)
    }

    func testHalfWidthFullAlphabetToHalf() {
        let target = "ＡＢＣＤ"
        let expected = "ABCD"
        XCTAssertEqual(expected, target.halfWidth)
    }

    func testHalfWidthHalfAlphabetToHalf() {
        let target = "ABCD"
        let answer = "ABCD"
        XCTAssertEqual(answer, target.halfWidth, "半角英字が半角英字になることを確認")
    }

    func testHalfWidthFullAlphabetAndNumberToHalf() {
        let target = "１２ＡＢ"
        let expected = "12AB"
        XCTAssertEqual(expected, target.halfWidth)
    }

    func testHalfWidthHalfOrFullAlphabetAndNumberToHalf() {
        let target = "１２3ＡＢcde"
        let expected = "123ABcde"
        XCTAssertEqual(expected, target.halfWidth)
    }

    func testHalfWidthひらがなToひらがな() {
        let target = "あいうえお"
        let expected = "あいうえお"
        XCTAssertEqual(expected, target.halfWidth)
    }

    func testFullWidthHalfNumberToFull() {
        let target = "123"
        let expected = "１２３"
        XCTAssertEqual(expected, target.fullWidth)
    }

    func testFullWidthFullNumberToFull() {
        let target = "１２３４５"
        let expected = "１２３４５"
        XCTAssertEqual(expected, target.fullWidth)
    }

    func testFullWidthHalfAlphabetToFull() {
        let target = "ABCD"
        let expected = "ＡＢＣＤ"
        XCTAssertEqual(expected, target.fullWidth)
    }

    func testFullWidthFullAlphabetToFull() {
        let target = "ＡＢＣＤ"
        let expected = "ＡＢＣＤ"
        XCTAssertEqual(expected, target.fullWidth)
    }

    func testFullWidthHalfAlphabetAndNumberToFull() {
        let target = "12AB"
        let expected = "１２ＡＢ"
        XCTAssertEqual(expected, target.fullWidth)
    }

    func testFullWidthFullOrHalfAlphabetAndNumberToFull() {
        let target = "１２3ABcde"
        let expected = "１２３ＡＢｃｄｅ"
        XCTAssertEqual(expected, target.fullWidth)
    }

    func testFullWidthひらがなToひらがな() {
        let target = "あいうえお"
        let expected = "あいうえお"
        XCTAssertEqual(expected, target.fullWidth)
    }
}
