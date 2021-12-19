//
//  Result+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/04/06.
//  Copyright © 2019 tattn. All rights reserved.
//

import Foundation

public extension Result {
    /// Returns the failure value
    ///
    /// - Returns: The failure value, if the instance represents a failure. Otherwise, nil.
    var error: Failure? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}
