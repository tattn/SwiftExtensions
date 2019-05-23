//
//  UINavigationControllerTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 2019/05/24.
//  Copyright © 2019 tattn. All rights reserved.
//

import UIKit
import XCTest
import SwiftExtensions

class UINavigationControllerTests: XCTestCase {
    var rootViewController: UIViewController!
    var nextViewController: UIViewController!
    var navigationController: UINavigationController!
    var window: UIWindow!

    override func setUp() {
        rootViewController = UIViewController()
        nextViewController = UIViewController()
        navigationController = UINavigationController(rootViewController: rootViewController)

        window = UIWindow(frame: .init(x: 0, y: 0, width: 100, height: 100))
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        navigationController.loadViewIfNeeded()
    }

    func testPushViewControllerCompletionAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        navigationController.pushViewController(nextViewController, animated: true, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPushViewControllerCompletionNotAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        navigationController.pushViewController(nextViewController, animated: false, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopViewControllerCompletionAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        navigationController.pushViewController(nextViewController, animated: false)
        navigationController.popViewController(animated: true, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopViewControllerCompletionNotAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        navigationController.pushViewController(nextViewController, animated: false)
        navigationController.popViewController(animated: false, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopToViewControllerCompletionAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        navigationController.pushViewController(nextViewController, animated: false)
        navigationController.popToViewController(rootViewController, animated: true, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopToViewControllerCompletionNotAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        navigationController.pushViewController(nextViewController, animated: false)
        navigationController.popToViewController(rootViewController, animated: false, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopToRootViewControllerCompletionAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        navigationController.pushViewController(nextViewController, animated: false)
        navigationController.popToRootViewController(animated: true, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopToRootViewControllerCompletionNotAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        navigationController.pushViewController(nextViewController, animated: false)
        navigationController.popToRootViewController(animated: false, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }
}
