//
//  URLTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017 tattn. All rights reserved.
//

import XCTest

class URLTests: XCTestCase {

    func testURLExpressibleByStringLiteral() {
        let url: URL = "https://example.com"
        XCTAssertEqual(url, URL(string: "https://example.com"))
    }

}
