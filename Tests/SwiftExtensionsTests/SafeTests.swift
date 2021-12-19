//
//  SafeTests.swift
//  CodableExtensionPackTests
//
//  Created by Tatsuya Tanaka on 20171128.
//  Copyright © 2017 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

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

        struct User: Codable {
            let name: String
            let age: Int
        }

        let users = try! JSONDecoder().decode([Safe<User>].self,
                                              from: json)

        XCTAssertEqual(users[0].wrappedValue?.name, "Taro")
        XCTAssertEqual(users[0].wrappedValue?.age, 20)
        XCTAssertNil(users[1].wrappedValue)
    }

    func testFailableURL() {
        let json = """
{"url": "https://foo.com", "url2": "invalid url string", "url3": "invalid url string"}
""".data(using: .utf8)!

        struct Model: Decodable {
            @Safe var url: URL?
            let url2: Safe<URL>
            @Safe var url3: URL?
        }

        let model = try! JSONDecoder().decode(Model.self,
                                              from: json)

        XCTAssertEqual(model.url?.absoluteString, "https://foo.com")
        XCTAssertNil(model.url2.wrappedValue)
        XCTAssertNil(model.url3)
    }

}

