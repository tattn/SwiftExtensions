//
//  UINavigationControllerTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 2019/05/24.
//  Copyright © 2019 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

#if canImport(UIKit)
import UIKit

class UINavigationControllerTests: XCTestCase {
    let environment = IOSAppEnvironment()
    var nextViewController: UIViewController!

    override func setUp() {
        environment.prepare()
        nextViewController = UIViewController()
    }

    func testPushViewControllerCompletionAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        environment.navigationController.pushViewController(nextViewController, animated: true, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPushViewControllerCompletionNotAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        environment.navigationController.pushViewController(nextViewController, animated: false, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopViewControllerCompletionAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        environment.navigationController.pushViewController(nextViewController, animated: false)
        environment.navigationController.popViewController(animated: true, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopViewControllerCompletionNotAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        environment.navigationController.pushViewController(nextViewController, animated: false)
        environment.navigationController.popViewController(animated: false, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopToViewControllerCompletionAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        environment.navigationController.pushViewController(nextViewController, animated: false)
        environment.navigationController.popToViewController(environment.rootViewController, animated: true, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopToViewControllerCompletionNotAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        environment.navigationController.pushViewController(nextViewController, animated: false)
        environment.navigationController.popToViewController(environment.rootViewController, animated: false, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopToRootViewControllerCompletionAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        environment.navigationController.pushViewController(nextViewController, animated: false)
        environment.navigationController.popToRootViewController(animated: true, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }

    func testPopToRootViewControllerCompletionNotAnimated() {
        let expectCompletion = expectation(description: "expectCompletion")
        environment.navigationController.pushViewController(nextViewController, animated: false)
        environment.navigationController.popToRootViewController(animated: false, completion: expectCompletion.fulfill)
        wait(for: [expectCompletion], timeout: 2)
    }
}
#endif // canImport(UIKit)
