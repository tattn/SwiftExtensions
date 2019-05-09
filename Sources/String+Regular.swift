//
//  String+Regular.swift
//  SwiftExtensions
//
//  Created by nathan on 2019/5/8.
//  Copyright © 2019 tattn. All rights reserved.
//

import Foundation

// MARK: Regular
extension String {
    
    public var validateEmail:Bool{
        let predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: self)
    }
    public var validatePhone:Bool{
        let predicateStr = "^1+[356789]+\\d{9}$"
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: self)
    }
    public var validateNickname:Bool {
        let predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: self)
    }
    public var validateURL:Bool{
        let predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: self)
    }
    public var validateIP:Bool{
        let predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: self)
    }
    var isValidChinese:Bool {
        let regex = "^[\\u4e00-\\u9fa5]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
    var isValidWechat:Bool {
        let regex = "^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
    var validateVerifyCode:Bool{
        let regex = "^([0-9]){4}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
    var validateQQ:Bool{
        let regex = "^([0-9]){6,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
    var validateRealname:Bool{
        let regex = "^[\\u4e00-\\u9fa5]{2,5}+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
}
