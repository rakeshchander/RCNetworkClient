//
//  BaseUnitTest.swift
//  Module_FrameworkTests
//
//  Created by Comviva on 15/07/19.
//  Copyright © 2019 Comviva. All rights reserved.
//

import XCTest

class BaseUnitTest: XCTestCase {

    override func setUp() {
        continueAfterFailure = true
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func wait(interval: TimeInterval = 2, completion: @escaping (() -> Void)) {
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
            exp.fulfill()
        }
        waitForExpectations(timeout: interval + 1) 
    }

}
