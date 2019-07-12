//
//  View+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/07/03.
//  Copyright © 2019 tattn. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
public extension View {
    func wrappedInUIViewController() -> UIHostingController<Self> {
        UIHostingController(rootView: self)
    }

    func wrappedInUIView(parent: UIViewController) -> UIView {
        let hostingController = wrappedInUIViewController()
        parent.addChild(hostingController)
        hostingController.didMove(toParent: parent)
        return hostingController.view
    }

    var erased: AnyView { AnyView(self) }
}
