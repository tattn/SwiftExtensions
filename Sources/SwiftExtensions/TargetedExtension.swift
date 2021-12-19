//
//  TargetedExtension.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017 tattn. All rights reserved.
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

public extension TargetedExtensionCompatible where Self == Compatible {
    static var ex: TargetedExtension<Self>.Type {
        TargetedExtension<Self>.self
    }

    var ex: TargetedExtension<Self> {
        TargetedExtension(self)
    }
}
