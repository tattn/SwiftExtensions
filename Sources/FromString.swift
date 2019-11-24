//
//  FromString.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171030.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

@propertyWrapper
public struct FromString<T: LosslessStringConvertible>: Codable {
    public let wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        guard let value = T(stringValue) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: decoder.codingPath,
                      debugDescription: "Failed to convert the string to \(T.self).")
            )
        }

        self.wrappedValue = value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.description)
    }
}

@propertyWrapper
public struct DefaultValue<T: Codable>: Codable {
    public let wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode(T.self)) ?? Default.defaultValue
    }

    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}
