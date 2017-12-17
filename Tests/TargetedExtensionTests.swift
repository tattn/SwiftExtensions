//
//  TargetedExtensionTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions
import UIKit

extension UIView: TargetedExtensionCompatible {}

private extension TargetedExtension where Base: UIView {
    func foo() {}
}

class TargetedExtensionTests: XCTestCase {

    func testTargetedExtension() {
        UIView().ex.foo()
    }
}
