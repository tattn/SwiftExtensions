//
//  Error+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20180716.
//  Copyright © 2018 tattn. All rights reserved.
//

import Foundation

public extension Error {
    var code: Int { _code }
    var domain: String { _domain }
}
