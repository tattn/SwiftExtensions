//
//  Array+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    @discardableResult
    public mutating func remove(_ element: Element) -> Index? {
        guard let index = index(of: element) else { return nil }
        remove(at: index)
        return index
    }

    @discardableResult
    public mutating func remove(_ elements: [Element]) -> [Index] {
        return elements.flatMap { remove($0) }
    }
}

extension Array where Element: Hashable {
    public mutating func unify() {
        self = unified()
    }
}

extension Collection where Element: Hashable {
    public func unified() -> [Element] {
        return reduce(into: []) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}
