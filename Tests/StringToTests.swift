//
//  CodableStringToTests.swift
//  CodableExtensionPackTests
//
//  Created by Tatsuya Tanaka on 20171030.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import BTSwiftExtensions

class StringToTests: XCTestCase {

    // https://developer.yahoo.co.jp/webapi/shopping/shopping/v1/itemsearch.html
    let json = """
{
    "int": "100",
    "customClass": "https://store.shopping.yahoo.co.jp/try3/4905524907230.html"

}
"""
    struct Root: Codable {
        let int: StringTo<Int>
        let customClass: StringTo<CustomClass>

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
        XCTAssertEqual(root.int.value, 100)
        XCTAssertEqual(root.customClass.value.description, "https://store.shopping.yahoo.co.jp/try3/4905524907230.html")
    }

}

