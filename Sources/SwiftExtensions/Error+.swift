//
//  Error+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20180716.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

public extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
