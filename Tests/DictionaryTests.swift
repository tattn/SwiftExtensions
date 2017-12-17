//
//  DictionaryTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class DictionaryTests: XCTestCase {
    
    func testTryValue() {
        let dictionary: [String: Int] = [:]
        var isError = false

        do {
            _ = try dictionary.tryValue(forKey: "foo")
        } catch is DictionaryTryValueError {
            isError = true
        } catch {
        }

        XCTAssertTrue(isError)
    }
    
}
