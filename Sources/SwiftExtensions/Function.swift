//
//  Function.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20180726.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

/// A function that clamps the given value to the specified bounds
public func clamp<T: Comparable>(_ value: T, min minValue: T, max maxValue: T) -> T {
    return max(min(value, maxValue), minValue)
}
