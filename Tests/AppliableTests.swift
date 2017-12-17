//
//  AppliableTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class AppliableTests: XCTestCase {
    
    func testApply() {
        let view = UIView().apply {
            $0.backgroundColor = .red
        }
        XCTAssertEqual(view.backgroundColor, UIColor.red)
    }
    
}
