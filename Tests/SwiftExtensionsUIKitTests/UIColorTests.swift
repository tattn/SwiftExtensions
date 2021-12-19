//
//  UIColorTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171215.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions
#if canImport(UIKit)

class UIColorTests: XCTestCase {
    func testHexInit() {
        let color = UIColor(hex: 0xAABBCC, alpha: 0.5)

        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 170 / CGFloat(255))
        XCTAssertEqual(green, 187 / CGFloat(255))
        XCTAssertEqual(blue, 204 / CGFloat(255))
        XCTAssertEqual(alpha, 0.5)
    }

    func testRGBHexStringInit() {
        let color = UIColor(rgbHexString: "#AABBCC", alpha: 0.5)

        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0

        color!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 170 / CGFloat(255))
        XCTAssertEqual(green, 187 / CGFloat(255))
        XCTAssertEqual(blue, 204 / CGFloat(255))
        XCTAssertEqual(alpha, 0.5)
    }

    func testIntValueInit() {
        let color = UIColor(red: 170, green: 187, blue: 204, alpha: 0.5)

        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 170 / CGFloat(255))
        XCTAssertEqual(green, 187 / CGFloat(255))
        XCTAssertEqual(blue, 204 / CGFloat(255))
        XCTAssertEqual(alpha, 0.5)
    }
}
#endif // canImport(UIKit)
