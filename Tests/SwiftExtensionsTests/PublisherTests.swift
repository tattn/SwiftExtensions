//
//  PublisherTests.swift
//  
//
//  Created by Tatsuya Tanaka on 2021/11/14.
//  Copyright © 2019 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions
import Combine

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
class PublisherTests: XCTestCase {
    func test_asAsyncStreamNeverFailure() async {
        let publisher = PassthroughSubject<Int, Never>()
        let testData: [Int] = [1, 2, 3]

        let streamTask = Task<[Int], Never>.detached {
            var result: [Int] = []
            for await value in publisher.asAsyncStream {
                result.append(value)
            }
            return result
        }

        try! await Task.sleep(nanoseconds: 1) // run streamTask

        for value in testData {
            publisher.send(value)
        }
        publisher.send(completion: .finished)

        let result = await streamTask.value
        XCTAssertEqual(result, testData)
    }

    func test_asAsyncStreamThrow() async {
        let publisher = PassthroughSubject<Int, Error>()
        let testData: [Int] = [1, 2, 3]
        let valueOnError = 100

        let streamTask = Task<[Int], Never>.detached {
            var result: [Int] = []
            do {
                for try await value in publisher.asAsyncStream {
                    result.append(value)
                }
            } catch {
                result.append(valueOnError)
            }
            return result
        }

        try! await Task.sleep(nanoseconds: 1) // run streamTask

        for (index, value) in testData.enumerated() {
            publisher.send(value)
            if index == testData.endIndex - 2 {
                publisher.send(completion: .failure(TestError()))
            }
        }
        publisher.send(completion: .finished)

        let result = await streamTask.value
        XCTAssertEqual(result, [1, 2, valueOnError])
    }
}

private struct TestError: Error {}
