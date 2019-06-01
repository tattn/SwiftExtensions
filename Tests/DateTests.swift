//
//  DateTests.swift
//  BTSwiftExtensionsTests
//
//  Created by nathan on 2019/6/1.
//  Copyright © 2019 tattn. All rights reserved.
//

import XCTest

class DateTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDateToString() -> String{
        let date = Date()
        let string = date.toString()
        print(string)
        return string
    }
    
    func testStringToDate(){
        let date = testDateToString()
        let da = date.toDate()
        print(da)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
