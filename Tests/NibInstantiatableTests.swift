//
//  NibInstantiatableTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

final class NibView: UIView, NibInstantiatable {
    @IBOutlet weak var label: UILabel!
}

final class SecondaryNibView: UIView, NibInstantiatable {
    static var nibName: String { return NibView.className }
    static var instantiateIndex: Int { return 1 }

    @IBOutlet weak var label: UILabel!
}

final class InnerView: UIView, NibInstantiatable {
    @IBOutlet weak var label: UILabel!
}

final class IBInnerView: UIView {
    var view: InnerView { return subviews[0] as! InnerView }

    override func awakeFromNib() {
        super.awakeFromNib()
        let view = InnerView.instantiate()
        insertSubview(view, at: 0)
    }
}

final class SuperviewOfInnerView: UIView, NibInstantiatable {
    static var nibName: String { return NibView.className }
    static var instantiateIndex: Int { return 2 }

    @IBOutlet weak var ownerView: IBInnerView!
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
        let view = SuperviewOfInnerView.instantiate()
        XCTAssertNotNil(view.ownerView.view.label)
    }
}
