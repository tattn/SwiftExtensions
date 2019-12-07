//
//  BoxTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 2019/12/08.
//  Copyright © 2019 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

class BoxTests: XCTestCase {
    func testBox() {
        struct BoxHolder {
            @Box var boxedValue: Int = 0
            var value: Int = 0
            let boxedValueYouCanWriteLikeThis = Box(0)
        }

        var holder = BoxHolder()
        holder.boxedValue = 1
        holder.value = 1

        var copyHolder = holder
        copyHolder.boxedValue = 2
        copyHolder.value = 2

        XCTAssertEqual(holder.boxedValue, 2)
        XCTAssertEqual(holder.value, 1)
    }

    func testWeak() {
        class Reference {
            var value = 1
        }

        struct WeakBoxHolder {
            let array: [Weak<Reference>]
        }

        struct NoWeakBoxHolder {
            let array: [Reference]
        }

        do {
            var array = [Reference(), Reference()]

            let holder = WeakBoxHolder(array: array.map { Weak($0) })
            XCTAssertEqual(holder.array[0].value, 1)

            array = []

            XCTAssertNil(holder.array[0].value)
        }

        do {
            var array = [Reference(), Reference()]

            let holder = NoWeakBoxHolder(array: array.map { $0 })
            XCTAssertEqual(holder.array[0].value, 1)

            array = []

            XCTAssertEqual(holder.array[0].value, 1)
        }
    }

    func testWeakAssignNil() {
        class Reference {
            var value = 1
            var optionalValue: Int? = 1
        }

        struct WeakBoxHolder {
            let array: [Weak<Reference>]
        }

        let array = [Reference()]

        let holder = WeakBoxHolder(array: array.map { Weak($0) })

        holder.array[0].value = nil
        XCTAssertEqual(holder.array[0].value, 1)

        holder.array[0].optionalValue = nil
        XCTAssertNil(holder.array[0].optionalValue)
    }
}
