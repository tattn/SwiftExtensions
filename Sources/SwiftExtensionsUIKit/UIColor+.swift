//
//  UIColor+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171215.
//  Copyright © 2017 tattn. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIColor {
    convenience init(hex: Int, alpha: Double = 1.0) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }

    convenience init?(rgbHexString: String, alpha: Double = 1.0) {
        let scanner = Scanner(string: rgbHexString.replacingOccurrences(of: "#", with: ""))
        var rgbHex: UInt32 = 0
        guard scanner.scanHexInt32(&rgbHex) else {
            return nil
        }

        self.init(hex: Int(rgbHex), alpha: alpha)
    }

    @nonobjc
    convenience init(red: Int, green: Int, blue: Int, alpha: Double = 1.0) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha))
    }

    /// Create a dynamic color.
    /// - Parameter light: a color in light mode
    /// - Parameter dark: a color in dark mode
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13, *) {
            self.init { $0.userInterfaceStyle == .dark ? dark : light }
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
}
    
public extension UIColor {
    struct Components {
        var _base: UIColor
        public var rgba: (CGFloat, CGFloat, CGFloat, CGFloat) {
            var r: CGFloat = 0; var g: CGFloat = 0; var b: CGFloat = 0; var a: CGFloat = 0
            _base.getRed(&r, green: &g, blue: &b, alpha: &a)
            return (r, g, b, a)
        }
        public var hsv: (CGFloat, CGFloat, CGFloat) {
            var h: CGFloat = 0; var s: CGFloat = 0; var v: CGFloat = 0; var a: CGFloat = 0
            _base.getHue(&h, saturation: &s, brightness: &v, alpha: &a)
            return (h, s, v)
        }
    }
    var components: UIColor.Components {
        return Components(_base: self)
    }
}
#endif // canImport(UIKit)
