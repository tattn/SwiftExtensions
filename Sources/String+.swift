//
//  String+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017年 tattn. All rights reserved.
//

import UIKit

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    func localized(withTableName tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: self)
    }
}

public extension String {
    var url: URL? {
        return URL(string: self)
    }
}

public extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }

    subscript (bounds: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[startIndex..<end])
    }

    subscript (bounds: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[startIndex...end])
    }

    subscript (bounds: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        return String(self[start..<endIndex])
    }
}

public extension String {
    var halfWidth: String {
        return transformFullWidthToHalfWidth(reverse: false)
    }

    var fullWidth: String {
        return transformFullWidthToHalfWidth(reverse: true)
    }

    private func transformFullWidthToHalfWidth(reverse: Bool) -> String {
        let string = NSMutableString(string: self) as CFMutableString
        CFStringTransform(string, nil, kCFStringTransformFullwidthHalfwidth, reverse)
        return string as String
    }
}


public extension String {
    
    /// "ffffff".color
    var color:UIColor {
        var doString = self
        // 去除空格
        doString = doString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        var length = doString.count
        // 判断是否含有 “#”
        if doString.hasPrefix("#"){
            let index = doString.index(doString.startIndex, offsetBy:1)
            doString = String(doString[index..<doString.endIndex])
            length = doString.count
        }
        if length == 6 {
            let rIndex2 = doString.index(doString.startIndex, offsetBy: 2)
            let red = String(doString[doString.startIndex..<rIndex2])
            
            let gIndex1 = doString.index(doString.startIndex, offsetBy: 2)
            let gIndex2 = doString.index(doString.startIndex, offsetBy: 4)
            let grend = String(doString[gIndex1..<gIndex2])
            
            let bIndex1 = doString.index(doString.startIndex, offsetBy: 4)
            let blue = String(doString[bIndex1..<doString.endIndex])
            
            
            // 声明三个变量
            var r:CUnsignedInt = 0 ,g:CUnsignedInt = 0, b:CUnsignedInt = 0
            // 获取其值
            Scanner.init(string: red).scanHexInt32(&r)
            Scanner.init(string: grend).scanHexInt32(&g)
            Scanner.init(string: blue).scanHexInt32(&b)
            if #available(iOS 10.0, *) {
                return UIColor.init(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
            } else {
                return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
            }
        }
        return UIColor.white
    }
}

public extension String {
    var attributedFromHTMLString:NSAttributedString? {
        do {
            let data = self.data(using: String.Encoding.unicode)
            let options = [NSAttributedString.DocumentReadingOptionKey.characterEncoding : utf8]
            let attr = try NSAttributedString.init(data: data!, options: options, documentAttributes: nil)
            return attr
        } catch {
            return nil
        }
    }
}

