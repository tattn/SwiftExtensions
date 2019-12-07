//
//  UITraitCollectionTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 2019/12/07.
//  Copyright © 2019 tattn. All rights reserved.
//

import XCTest

#if canImport(UIKit)

class UITraitCollectionTests: XCTestCase {
    let environment = IOSAppEnvironment()

    override func setUp() {
        environment.prepare()
    }

    @available(iOS 13.0, *)
    func testIsDarkMode() {
        environment.window.overrideUserInterfaceStyle = .dark
        XCTAssertEqual(environment.rootViewController.traitCollection.isDarkMode, true)
        environment.window.overrideUserInterfaceStyle = .light
        XCTAssertEqual(environment.rootViewController.traitCollection.isDarkMode, false)
        environment.window.overrideUserInterfaceStyle = .unspecified
        XCTAssertEqual(environment.rootViewController.traitCollection.isDarkMode, false)
    }
}

#endif
