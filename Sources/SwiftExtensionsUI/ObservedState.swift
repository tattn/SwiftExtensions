//
//  ObservedState.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/12/08.
//  Copyright © 2019 tattn. All rights reserved.
//

#if canImport(SwiftUI) && canImport(Combine) && (arch(arm64) || arch(x86_64))

import SwiftUI
import Combine

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct ObservedState<Value>: DynamicProperty {
    @State private var _wrappedValue: Value

    public typealias ObservedChange = (oldValue: Value, newValue: Value)
    private let _willChange = PassthroughSubject<ObservedChange, Never>()
    private let _didChange = PassthroughSubject<ObservedChange, Never>()

    public var wrappedValue: Value {
        get { _wrappedValue }
        nonmutating set {
            let value = (_wrappedValue, newValue)
            _willChange.send(value)
            _wrappedValue = newValue
            _didChange.send(value)
        }
    }

    public var willChange: AnyPublisher<ObservedChange, Never> {
        _willChange.eraseToAnyPublisher()
    }

    public var didChange: AnyPublisher<ObservedChange, Never> {
        _didChange.eraseToAnyPublisher()
    }

    public init(wrappedValue: Value) {
        __wrappedValue = .init(initialValue: wrappedValue)
    }

    public mutating func update() {
        __wrappedValue.update()
    }

    public var projectedValue: Binding<Value> {
        .init(get: { self.wrappedValue }, set: { self.wrappedValue = $0 })
    }
}

#endif
