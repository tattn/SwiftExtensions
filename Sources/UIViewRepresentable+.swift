//
//  UIViewRepresentable+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/07/03.
//  Copyright © 2019 tattn. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
public extension UIViewControllerRepresentable where Self: UIViewController {
    func makeUIViewController(context: Context) -> Self {
        self
    }

    func updateUIViewController(_ uiView: Self, context: Context) {
    }
}

@available(iOS 13, *)
public extension UIViewRepresentable where Self: UIView {
    func makeUIView(context: Context) -> Self {
        self
    }

    func updateUIView(_ uiView: Self, context: Context) {
    }
}
