//
//  ScopeMethodTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

#if canImport(UIKit)
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
#endif // canImport(UIKit)
