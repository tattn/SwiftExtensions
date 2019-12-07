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
        if #available(iOS 13, *), current.isDarkMode {
            return true
        }
        return false
    }

    var isDarkMode: Bool {
        if #available(iOS 13, *), userInterfaceStyle == .dark {
            return true
        }
        return false
    }
}

#endif
