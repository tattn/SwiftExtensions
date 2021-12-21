//
//  Bundle+.swift
//  
//
//  Created by Tatsuya Tanaka on 2021/12/21.
//

import Foundation

public extension Bundle {
    var shortVersionString: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var version: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}
