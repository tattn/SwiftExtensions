//
//  TargetedExtensionTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions
#if canImport(UIKit)
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
#endif // canImport(UIKit)
