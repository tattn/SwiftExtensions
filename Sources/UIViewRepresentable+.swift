//
//  UIViewRepresentable+.swift
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
public extension UIViewControllerRepresentable where Self: UIViewController {
    func makeUIViewController(context: Context) -> Self {
        self
    }

    func updateUIViewController(_ uiView: Self, context: Context) {
    }
}
@available(iOS 13.0, tvOS 13.0, *)
@available(OSX, unavailable)
@available(watchOS, unavailable)
public extension UIViewRepresentable where Self: UIView {
    func makeUIView(context: Context) -> Self {
        self
    }

    func updateUIView(_ uiView: Self, context: Context) {
    }
}
#endif // canImport(UIKit)
