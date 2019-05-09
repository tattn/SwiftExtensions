//
//  ResultTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 2019/04/06.
//  Copyright © 2019 tattn. All rights reserved.
//

import XCTest
import BTSwiftExtensions

class ResultTests: XCTestCase {
    func testError() {
        struct MyError: Error, Equatable {
            let message: String
        }
        let error = MyError(message: "MyError")
        let result = Result<Int, MyError>.failure(error)
        XCTAssertEqual(result.error(), error)
    }
}
