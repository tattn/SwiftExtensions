//
//  ProcessInfo+.swift
//  
//
//  Created by Tatsuya Tanaka on 2021/12/22.
//

import Foundation

public extension ProcessInfo {
    var xcodeRunningForPreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
