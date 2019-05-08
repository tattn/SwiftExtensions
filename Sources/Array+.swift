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
    mutating func remove(_ element: Element) -> Index? {
        guard let index = firstIndex(of: element) else { return nil }
        remove(at: index)
        return index
    }

    @discardableResult
    mutating func remove(_ elements: [Element]) -> [Index] {
        return elements.compactMap { remove($0) }
    }
    
    
    @discardableResult
    mutating func append(_ newArray: Array) -> CountableRange<Int> {
        let range = count..<(count + newArray.count)
        self += newArray
        return range
    }
    
    @discardableResult
    mutating func insert(_ newArray: Array, at index: Int) -> CountableRange<Int> {
        let mIndex = Swift.max(0, index)
        let start = Swift.min(count, mIndex)
        let end = start + newArray.count
        
        let left = self[0..<start]
        let right = self[start..<count]
        self = left + newArray + right
        return start..<end
    }
    
    func each(_ exe: (Int, Element) -> ()) {
        for (index, item) in enumerated() {
            exe(index, item)
        }
    }
}

public extension Array {
    
    /// Random item from array.
    var randomItem: Element? {
        if self.isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    
    /// Shuffled version of array.
    var shuffled: [Element] {
        var arr = self
        for _ in 0..<10 {
            arr.sort { (_,_) in arc4random() < arc4random() }
        }
        return arr
    }
    
    /// Shuffle array.
    mutating func shuffle() {
        // https://gist.github.com/ijoshsmith/5e3c7d8c2099a3fe8dc3
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
    
    /// Element at the given index if it exists.
    ///
    /// - Parameter index: index of element.
    /// - Returns: optional element (if exists).
    func item(index:Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
}


public extension Array where Element: Hashable {
    mutating func unify() {
        self = unified()
    }
}

public extension Collection where Element: Hashable {
    func unified() -> [Element] {
        return reduce(into: []) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return startIndex <= index && index < endIndex ? self[index] : nil
    }
}
