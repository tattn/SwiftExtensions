//
//  View+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/07/03.
//  Copyright © 2019 tattn. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
@available(iOS 13.0, tvOS 13.0, *)
@available(OSX, unavailable)
@available(watchOS, unavailable)
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
}
#endif // canImport(UIKit)

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    var erased: AnyView { AnyView(self) }
}
