//
//  StoryboardInstantiatableTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171215.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

#if canImport(UIKit)
final class InitialViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet weak var label: UILabel!
    static var instantiateType: StoryboardInstantiateType {
        return .initial
    }
}

final class IdentifierViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet weak var label: UILabel!
    static var storyboardName: String { return InitialViewController.className }
}

class UIViewController_InstantiateTests: XCTestCase {
    
    func testInstantiateByInitial() {
        let viewControlelr = InitialViewController.instantiate()
        XCTAssertNil(viewControlelr.label)
        _ = viewControlelr.view
        XCTAssertNotNil(viewControlelr.label)
    }

    func testInstantiateByIdentifier() {
        let viewControlelr = IdentifierViewController.instantiate()
        XCTAssertNil(viewControlelr.label)
        _ = viewControlelr.view
        XCTAssertNotNil(viewControlelr.label)
    }
}
#endif // canImport(UIKit)
