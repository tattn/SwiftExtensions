//
//  Array+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171217.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
    @discardableResult
    public mutating func remove(_ element: Element) -> Index? {
        guard let index = index(of: element) else { return nil }
        remove(at: index)
        return index
    }

    @discardableResult
    public mutating func remove(_ elements: [Element]) -> [Index] {
        return elements.compactMap { remove($0) }
    }
}

public extension RangeReplacableCollection where Self: RandomAccessCollection, Element: Hashable {
    /// Returns a collection containing the contents of the original collection with no duplicate elements.
    ///
    /// NOTE: The elements are not garanteed to be in the same order as the original colection.
    ///
    /// Complexity: O(n), where n is the number of elements in the collection.
    public func unified() -> Self {
        var set = Set<Element>()
        var r = Self()
        var newCount = 0
        forEach {
            if set.insert($0).inserted {
                $0.append($1)
                newCount += 1
            }
        }
        r.reserveCapacity(newCount)
        for element in set {
            r.append(element)	
        }
        return r
    }
}

public extension RangeReplacableCollection where Self: RandomAccessCollection, Element: Hashable {
    public mutating func unify() {
        self = unified()
    }
}

public extension Collection {
    public subscript(safe index: Index) -> Element? {
        return startIndex <= index && index < endIndex ? self[index] : nil
    }
}
