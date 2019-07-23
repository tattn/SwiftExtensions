//
//  NibInstantiatableTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

#if canImport(UIKit)
final class NibView: UIView, NibInstantiatable {
    @IBOutlet weak var label: UILabel!
}

final class SecondaryNibView: UIView, NibInstantiatable {
    static var nibName: String { return NibView.className }
    static var instantiateIndex: Int { return 1 }

    @IBOutlet weak var label: UILabel!
}

final class EmbeddedView: UIView, NibInstantiatable {
    @IBOutlet weak var label: UILabel!
}

@IBDesignable
final class IBEmbeddedView: UIView, EmbeddedNibInstantiatable {
    typealias Embedded = EmbeddedView

    override func awakeFromNib() {
        super.awakeFromNib()
        configureEmbededView()
    }
}

final class SuperviewOfEmbeddedView: UIView, NibInstantiatable {
    static var nibName: String { return NibView.className }
    static var instantiateIndex: Int { return 2 }

    @IBOutlet weak var embeddedView: IBEmbeddedView!
}

class NibInstantiatableTests: XCTestCase {
    
    func testInstantiate() {
        let view = NibView.instantiate()
        XCTAssertNotNil(view.label)
    }

    func testInstantiateSecondaryView() {
        let view = SecondaryNibView.instantiate()
        XCTAssertNotNil(view.label)
    }

    func testInstantiateSuperviewOfOwnerView() {
        let view = SuperviewOfEmbeddedView.instantiate()
        XCTAssertNotNil(view.embeddedView.embedded.label)
    }
}
#endif // canImport(UIKit)
