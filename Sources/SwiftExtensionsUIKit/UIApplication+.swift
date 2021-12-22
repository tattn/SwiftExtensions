//
//  UIApplication+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171215.
//  Copyright © 2017 tattn. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit

@available(iOSApplicationExtension, unavailable)
public extension UIApplication {
    var topViewController: UIViewController? {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard var topViewController = keyWindow?.rootViewController else { return nil }

        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }


    var topNavigationController: UINavigationController? {
        topViewController as? UINavigationController
    }
}
#endif // canImport(UIKit)
