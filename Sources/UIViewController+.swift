//
//  UIViewController+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20181012.
//  Copyright © 2018年 tattn. All rights reserved.
//

import UIKit

public extension UIViewController {
    public func addChildView(_ child: UIViewController, layoutOption: LayoutOption = .fill) {
        loadViewIfNeeded()
        child.loadViewIfNeeded()

        addChild(child)
        view.addSubview(child.view)
        layout(child.view, layoutOption: layoutOption)
        child.didMove(toParent: self)
    }

    public func remove() {
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

    public enum LayoutOption {
        case fill
        case custom((UIView, UIView) -> Void)
    }
}
