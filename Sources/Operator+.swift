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
  assiciativity: left
  higherThan: LogicalConjunctionPrecedence
}

infix operator |=: ForwardPipe

/// Piping allows east workflow of modifying an object
///
/// let result = value |= { $0 * 2 } |= { $0 * $0 }
/// is the same as
/// let result = { (x: Int) -> Int in return (x * 2) * (x * 2 }.(value)
///
/// Because the pipe operator is left associative, you can add as many closures as you want  
public func |= <T, U>(lhs: T, rhs: (T) throws -> U) rethrows -> U {
  return return try rhs(lhs)
}
