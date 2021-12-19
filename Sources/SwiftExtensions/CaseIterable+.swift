//
//  CaseIterable+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/04/11.
//  Copyright © 2019 tattn. All rights reserved.
//

import Foundation

public extension Hashable where Self: CaseIterable {
    var caseIndex: AllCases.Index {
        Self.allCases.firstIndex(of: self)!
    }
}
