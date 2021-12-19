//
//  AppEnvironment.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 2019/12/07.
//  Copyright © 2019 tattn. All rights reserved.
//

#if canImport(UIKit)
import UIKit

class IOSAppEnvironment {
    var rootViewController: UIViewController!
    var navigationController: UINavigationController!
    var window: UIWindow!

    func prepare() {
        rootViewController = UIViewController()
        navigationController = UINavigationController(rootViewController: rootViewController)

        window = UIWindow(frame: .init(x: 0, y: 0, width: 100, height: 100))
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        navigationController.loadViewIfNeeded()
    }
}

#endif
