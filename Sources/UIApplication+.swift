//
//  UIApplication+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171215.
//  Copyright © 2017年 tattn. All rights reserved.
//

import UIKit

public extension UIApplication {
    var topViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }


    var topNavigationController: UINavigationController? {
        return topViewController as? UINavigationController
    }
}

// MARK: Version
public extension UIApplication {
    var appVersion:String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
}
