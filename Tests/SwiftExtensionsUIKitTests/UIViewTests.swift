//
//  UIViewTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

#if canImport(UIKit)
class UIViewTests: XCTestCase {

    func testFillSuperviewByAutoresizingMask() {
        let frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        let superview = UIView(frame: .init(x: 0, y: 0, width: 400, height: 400))
        let view = UIView(frame: frame)
        view.fillSuperview()
        XCTAssertEqual(view.frame, frame)
        superview.addSubview(view)
        view.fillSuperview()
        XCTAssertEqual(view.frame, superview.bounds)
    }

    func testFillSuperviewByAutoLayout() {
        let frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        let superview = UIView(frame: .init(x: 0, y: 0, width: 400, height: 400))
        superview.translatesAutoresizingMaskIntoConstraints = false
        superview.widthAnchor.constraint(equalToConstant: 400).isActive = true
        superview.heightAnchor.constraint(equalToConstant: 400).isActive = true

        let view = UIView(frame: frame)
        view.fillSuperview()
        XCTAssertEqual(view.frame, frame)
        superview.addSubview(view)
        view.fillSuperview()
        XCTAssertEqual(view.frame, frame)
        superview.layoutIfNeeded()
        XCTAssertEqual(view.frame, superview.bounds)
    }
}
#endif // canImport(UIKit)
