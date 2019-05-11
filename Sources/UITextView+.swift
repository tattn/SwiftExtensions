//
//  UITextView+.swift
//  BTSwiftExtensions
//
//  Created by nathan on 2019/5/11.
//  Copyright © 2019 tattn. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension UITextView {
    
    /// Scroll to the bottom of text view
    func scrollToBottom() {
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
    }
    
    /// Scroll to the top of text view
    func scrollToTop() {
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }
}
