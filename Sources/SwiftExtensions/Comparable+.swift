//
//  Comparable+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2018/12/10.
//  Copyright © 2018 tattn. All rights reserved.
//

import Foundation

public extension Comparable {    
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(limits.lowerBound, self), limits.upperBound)
    }
}
