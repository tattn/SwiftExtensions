//
//  Binding+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/12/07.
//  Copyright © 2019 tattn. All rights reserved.
//

#if canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Binding {
    func map<T>(get: @escaping (Value) -> T, set: @escaping (T) -> Value) -> Binding<T> {
        .init(get: { get(self.wrappedValue) },
              set: { self.wrappedValue = set($0) })
    }
}

#endif // canImport(SwiftUI)
