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
