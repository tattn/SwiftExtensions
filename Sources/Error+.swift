//
//  Error+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20180716.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

extension Error {
    public var code: Int { return (self as NSError).code }
    public var domain: String { return (self as NSError).domain }
}
