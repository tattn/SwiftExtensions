//
//  Operator+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

// MARK: - ???

//see: https://gist.github.com/erica/5a26d523f3d6ffb74e34d179740596f7

infix operator ???

public func ???<T>(lhs: T?,
                   error: @autoclosure () -> Error) throws -> T {
    guard let value = lhs else { throw error() }
    return value
}

precedencegroup ForwardPipe {
  associativity: left
  higherThan: LogicalConjunctionPrecedence
}

infix operator |>: ForwardPipe

/// Piping allows east workflow of modifying an object
///
/// let result = value |> { $0 * 2 } |> { $0 * $0 }
/// is the same as
/// let result = { (x: Int) -> Int in return (x * 2) * (x * 2 }.(value)
///
/// Because the pipe operator is left associative, you can add as many closures as you want  
public func |> <T, U>(lhs: T, rhs: (T) throws -> U) rethrows -> U {
  return try rhs(lhs)
}

// https://github.com/apple/swift-evolution/blob/master/proposals/0121-remove-optional-comparison-operators.md
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
public func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?): return l < r
    case (nil, _?): return true
    default: return false }
}

public func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


public func == <T: Equatable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l == r
    case (nil, nil):
        return true
    default:
        return false
    }
}
