//
//  String+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

public extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    public func localized(withTableName tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: self)
    }
}

public extension String {
    public var url: URL? {
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
    public var halfWidth: String {
        return transformFullWidthToHalfWidth(reverse: false)
    }

    public var fullWidth: String {
        return transformFullWidthToHalfWidth(reverse: true)
    }

    private func transformFullWidthToHalfWidth(reverse: Bool) -> String {
        let string = NSMutableString(string: self) as CFMutableString
        CFStringTransform(string, nil, kCFStringTransformFullwidthHalfwidth, reverse)
        return string as String
    }
}

public struct IntString: Sequence, Collection {
    var indices = [String.Index]()
    let src: String
    public internal(set) var count = 0
    public init(_ src: String) {
        self.src = src
        var i = src.startIndex
        indices.append(i)
        while src.formIndex(after: &i) {
            indices.append(i)
            count += 1
        }
    }
    public var startIndex: Int {
        return 0
    }
    public var endIndex: Int {
        return count
    }
    public func index(after i: Int) -> Int {
        return i + 1
    }
    public subscript(position: Int) -> Character {
        let index = indices[position]
        return src[index]
    }
}
