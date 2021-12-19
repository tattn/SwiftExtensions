//
//  UIViewController+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20181012.
//  Copyright © 2018 tattn. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIViewController {
    func addChildView(_ child: UIViewController, layoutOption: LayoutOption = .fill) {
        loadViewIfNeeded()
        child.loadViewIfNeeded()

        addChild(child)
        view.addSubview(child.view)
        layout(child.view, layoutOption: layoutOption)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    private func layout(_ child: UIView, layoutOption: LayoutOption) {
        switch layoutOption {
        case .fill:
            child.fillSuperview()
        case .custom(let customLayout):
            customLayout(view, child)
        }
    }

    enum LayoutOption {
        case fill
        case custom((UIView, UIView) -> Void)
    }
}
#endif // canImport(UIKit)
