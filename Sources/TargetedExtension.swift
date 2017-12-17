//
//  TargetedExtension.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

public struct TargetedExtension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

public protocol TargetedExtensionCompatible {
    associatedtype Compatible
    static var ex: TargetedExtension<Compatible>.Type { get }
    var ex: TargetedExtension<Compatible> { get }
}

public extension TargetedExtensionCompatible {
    public static var ex: TargetedExtension<Self>.Type {
        return TargetedExtension<Self>.self
    }

    public var ex: TargetedExtension<Self> {
        return TargetedExtension(self)
    }
}
