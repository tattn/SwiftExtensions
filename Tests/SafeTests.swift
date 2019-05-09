//
//  SafeTests.swift
//  CodableExtensionPackTests
//
//  Created by Tatsuya Tanaka on 20171128.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import BTSwiftExtensions

class SafeTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFailableArray() {
        let json = """
[
    {"name": "Taro", "age": 20},
    {"name": "Hanako", "age": "にゃーん"}
]
""".data(using: .utf8)!

        struct User: Decodable {
            let name: String
            let age: Int
        }

        let users = try! JSONDecoder().decode([Safe<User>].self,
                                              from: json)

        XCTAssertEqual(users[0].value?.name, "Taro")
        XCTAssertEqual(users[0].value?.age, 20)
        XCTAssertNil(users[1].value)
    }

    func testFailableURL() {
        let json = """
{"url": "https://foo.com", "url2": "invalid url string"}
""".data(using: .utf8)!

        struct Model: Decodable {
            let url: Safe<URL>
            let url2: Safe<URL>
        }

        let model = try! JSONDecoder().decode(Model.self,
                                              from: json)

        XCTAssertEqual(model.url.value?.absoluteString, "https://foo.com")
        XCTAssertNil(model.url2.value)
    }

}

