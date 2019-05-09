//
//  OperatorTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import BTSwiftExtensions

class OperatorTests: XCTestCase {

    func test？？？() {
        let value: Int? = nil
        var isError = false

        struct OptionalError: Error {}

        do {
            _ = try value ??? OptionalError()
        } catch is OptionalError {
            isError = true
        } catch {
        }

        XCTAssertTrue(isError)
    }
}
