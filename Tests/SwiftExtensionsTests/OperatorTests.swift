//
//  OperatorTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class OperatorTests: XCTestCase {

    func test？？？() {
        let value: Int? = nil
        var isError = false

        struct OptionalError: Error {}

        do {
            _ = try value.orThrow(OptionalError())
        } catch is OptionalError {
            isError = true
        } catch {
        }

        XCTAssertTrue(isError)
    }
}
