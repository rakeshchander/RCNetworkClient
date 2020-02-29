//
//  TwitterSampleUITests.swift
//  TwitterSampleUITests
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import XCTest

class TwitterSampleUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        app.launchEnvironment = ["UITEST_DISABLE_ANIMATIONS" : "YES"]

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        self.app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAppFlow() {
        
        app.otherElements["SearchBarID"].children(matching: .other).element.children(matching: .searchField).element.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["M"]/*[[".keyboards.keys[\"M\"]",".keys[\"M\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        waitToExecuteNextLine(timeout: 5.0)
        
        var cell = app.cells["TweetCell0"]
        
        XCTAssert(cell.exists)
        
        cell.tap()
        
        waitToExecuteNextLine(timeout: 5.0)
        
        cell = app.cells["TweetCell0"]
        
        XCTAssert(cell.exists)
        
    }
    
    func waitToExecuteNextLine(timeout: TimeInterval) {
        let exp = expectation(description: "Test after some time")
        let result = XCTWaiter.wait(for: [exp], timeout: timeout)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(1, 1)
        } else {
            XCTFail("Delay interrupted")
        }
    }

}
