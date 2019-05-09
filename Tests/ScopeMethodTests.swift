//
//  ScopeMethodTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import BTSwiftExtensions

class ScopeMethodTests: XCTestCase {
    
    func testAppliable() {
        let view = UIView().apply {
            $0.backgroundColor = .red
        }
        XCTAssertEqual(view.backgroundColor, UIColor.red)
    }

    func testRunnable() {
        let view = UIView()
        let string: String = view.run {
            $0.backgroundColor = .red
            return "foo"
        }
        XCTAssertEqual(view.backgroundColor, UIColor.red)
        XCTAssertEqual(string, "foo")
    }
}
