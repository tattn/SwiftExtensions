//
//  UIColor+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171215.
//  Copyright © 2017年 tattn. All rights reserved.
//

import UIKit
import Foundation

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



public extension UIColor {
    enum IHGradient {
        case directionLevel
        case directionVertical
        case upwardDiagonalLine
        case downDiagonalLine
    }
    
    convenience init?(direction:IHGradient = .directionLevel,size:CGSize, startColor:UIColor, endColor:UIColor) {
        if size.equalTo(CGSize.zero) {return nil}
        
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        var startPoint = CGPoint.zero
        if direction == .downDiagonalLine {
            startPoint = CGPoint.init(x: 0.0, y: 1.0)
        }
        gradientLayer.startPoint = startPoint
        
        var endPoint = CGPoint.init(x: 1.0, y: 0.0)
        switch direction {
        case .directionLevel:
            endPoint = CGPoint.init(x: 1.0, y: 0.0)
        case .directionVertical:
            endPoint = CGPoint.init(x: 0.0, y: 1.0)
        case .upwardDiagonalLine:
            endPoint = CGPoint.init(x: 1.0, y: 1.0)
        case .downDiagonalLine:
            endPoint = CGPoint.init(x: 1.0, y: 0.0)
        }
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [startColor.cgColor,endColor.cgColor]
        UIGraphicsBeginImageContext(size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let img = image else {return nil}
        self.init(patternImage: img)
    }
}


extension UIColor {
    
    /// SwifterSwift: https://github.com/SwifterSwift/SwifterSwift
    /// Hexadecimal value string (read-only).
    public var hexString: String {
        let components: [Int] = {
            let c = cgColor.components!
            let components = c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
    
    /// SwifterSwift: https://github.com/SwifterSwift/SwifterSwift
    /// Short hexadecimal value string (read-only, if applicable).
    public var shortHexString: String? {
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return nil }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }
    
    /// Color to Image
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect:CGRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image! // was image
    }
    
    /// SwifterSwift: https://github.com/SwifterSwift/SwifterSwift
    /// RGB components for a Color (between 0 and 255).
    ///
    ///        UIColor.red.rgbComponents.red -> 255
    ///        UIColor.green.rgbComponents.green -> 255
    ///        UIColor.blue.rgbComponents.blue -> 255
    ///
    public var rgbComponents: (red: Int, green: Int, blue: Int) {
        var components: [CGFloat] {
            let c = cgColor.components!
            if c.count == 4 {
                return c
            }
            return [c[0], c[0], c[0], c[1]]
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return (red: Int(r * 255.0), green: Int(g * 255.0), blue: Int(b * 255.0))
    }
    
    /// SwifterSwift: https://github.com/SwifterSwift/SwifterSwift
    /// RGB components for a Color represented as CGFloat numbers (between 0 and 1)
    ///
    ///        UIColor.red.rgbComponents.red -> 1.0
    ///        UIColor.green.rgbComponents.green -> 1.0
    ///        UIColor.blue.rgbComponents.blue -> 1.0
    ///
    public var cgFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var components: [CGFloat] {
            let c = cgColor.components!
            if c.count == 4 {
                return c
            }
            return [c[0], c[0], c[0], c[1]]
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return (red: r, green: g, blue: b)
    }
    
    /// SwifterSwift: https://github.com/SwifterSwift/SwifterSwift
    /// Get components of hue, saturation, and brightness, and alpha (read-only).
    public var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    /// Random color.
    public static var random: UIColor {
        let r = Int(arc4random_uniform(255))
        let g = Int(arc4random_uniform(255))
        let b = Int(arc4random_uniform(255))
        return UIColor.init(red: r, green: g, blue: b, alpha: 1)
    }
}
