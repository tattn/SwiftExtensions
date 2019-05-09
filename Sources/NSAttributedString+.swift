//
//  NSAttributedString+.swift
//  BTSwiftExtensions
//
//  Created by nathan on 2019/5/9.
//  Copyright © 2019 tattn. All rights reserved.
//

import Foundation

extension NSAttributedString {
    var HTMLStringFromattributed: String? {
        do {
            let range = NSRange(location: 0, length: self.length)
            let documentAttributes = [NSAttributedString.DocumentAttributeKey:NSAttributedString.DocumentType]()
            let d = try self.data(from: range, documentAttributes: documentAttributes)
            return String.init(data: d, encoding: .utf8)
        } catch  {
            return nil
        }
    }
}

