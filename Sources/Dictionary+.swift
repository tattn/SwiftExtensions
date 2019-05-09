//
//  Dictionary+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

public struct DictionaryTryValueError: Error {
    public init() {}
}

public extension Dictionary {
    func tryValue(forKey key: Key, error: Error = DictionaryTryValueError()) throws -> Value {
        guard let value = self[key] else { throw error }
        return value
    }
}

public protocol PrettyPrintedProtocal {}

public extension PrettyPrintedProtocal {
    
    var prettyPrinted:String? {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        return nil
    }
}

extension Dictionary :PrettyPrintedProtocal{}

extension Array :PrettyPrintedProtocal{}

