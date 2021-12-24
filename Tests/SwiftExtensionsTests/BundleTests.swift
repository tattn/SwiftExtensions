//
//  BundleTests.swift
//  
//
//  Created by Tatsuya Tanaka on 2021/12/22.
//

import XCTest
import SwiftExtensions

class BundleTests: XCTestCase {
    func testBundle() throws {
        guard #available(iOS 13.0, *) else {
            throw XCTSkip("Unsupported iOS version")
        }
        XCTAssertNotNil(Bundle.main.shortVersionString)
        XCTAssertNotNil(Bundle.main.version)
    }
}
