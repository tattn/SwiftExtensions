//
//  NSObject+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171213.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    public static var className: String {
        return String(describing: self)
    }

    public var className: String {
        return type(of: self).className
    }
}
