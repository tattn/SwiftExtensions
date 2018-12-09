//
//  Comparable+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2018/12/10.
//  Copyright © 2018 tattn. All rights reserved.
//

import Foundation

extension Comparable {
    public func clamped(min: Self, max: Self) -> Self {
        if self < min { return min }
        if self > max { return max }
        return self
    }
}
