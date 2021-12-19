//
//  UITraitCollection+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/12/07.
//  Copyright © 2019 tattn. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UITraitCollection {
    static var isDarkMode: Bool {
        if #available(iOS 13, *) {
            return current.isDarkMode
        }
        return false
    }

    var isDarkMode: Bool {
        if #available(iOS 13, *) {
            return userInterfaceStyle == .dark
        }
        return false
    }
}

#endif
