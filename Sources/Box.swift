//
//  Box.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/12/08.
//  Copyright © 2019 tattn. All rights reserved.
//

import Foundation

@propertyWrapper @dynamicMemberLookup
public class Ref<Wrapped> {
    public var wrappedValue: Wrapped

    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }

    public init(_ wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<Wrapped, T>) -> T {
        wrappedValue[keyPath: keyPath]
    }
}

@dynamicMemberLookup
public class Weak<Wrapped: AnyObject> {
    public weak var wrappedValue: Wrapped?

    public init(wrappedValue: Wrapped?) {
        self.wrappedValue = wrappedValue
    }

    public init(_ wrappedValue: Wrapped?) {
        self.wrappedValue = wrappedValue
    }

    public subscript<T>(dynamicMember keyPath: ReferenceWritableKeyPath<Wrapped, T>) -> T? {
        get { wrappedValue?[keyPath: keyPath] }
        set {
            if let newValue = newValue {
                wrappedValue?[keyPath: keyPath] = newValue
            }
        }
    }

    public subscript<T>(dynamicMember keyPath: ReferenceWritableKeyPath<Wrapped, T?>) -> T? {
        get { wrappedValue?[keyPath: keyPath] }
        set { wrappedValue?[keyPath: keyPath] = newValue }
    }
}
