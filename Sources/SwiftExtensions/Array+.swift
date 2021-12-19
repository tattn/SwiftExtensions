//
//  Array+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017 tattn. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
    @discardableResult
    mutating func removeFirst(_ element: Element) -> Index? {
        guard let index = firstIndex(of: element) else { return nil }
        remove(at: index)
        return index
    }

    @discardableResult
    mutating func removeFirst(_ elements: [Element]) -> [Index] {
        elements.compactMap { removeFirst($0) }
    }
}

public extension Array where Element: Hashable {
    mutating func unique() {
        self = uniqued()
    }
}

public extension Collection where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

public extension Collection {
    subscript(safe index: Index) -> Element? {
        startIndex <= index && index < endIndex ? self[index] : nil
    }
}
