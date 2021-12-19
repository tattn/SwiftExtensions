//
//  FromStringTests.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171030.
//  Copyright © 2017 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class FromStringTests: XCTestCase {

    // https://developer.yahoo.co.jp/webapi/shopping/shopping/v1/itemsearch.html
    let json = """
{
    "int": "100",
    "customClass": "https://store.shopping.yahoo.co.jp/try3/4905524907230.html"

}
"""
    struct Root: Codable {
        @FromString var int: Int
        @FromString var customClass: CustomClass

        struct CustomClass: LosslessStringConvertible, Codable {
            var description: String

            init?(_ description: String) {
                self.description = description
            }
        }
    }

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let root = try! decoder.decode(Root.self, from: data)
        XCTAssertEqual(root.int, 100)
        XCTAssertEqual(root.customClass.description, "https://store.shopping.yahoo.co.jp/try3/4905524907230.html")
    }

}

