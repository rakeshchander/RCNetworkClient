//
//  BaseUITest.swift
//  Module_Framework_SampleUITests
//
//  Created by comviva on 02/07/19.
//  Copyright © 2019 Comviva. All rights reserved.
//

import XCTest
import IQKeyboardManagerSwift

class BaseUITest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app.launchEnvironment = ["UITEST_DISABLE_ANIMATIONS" : "YES"]
        
    }
    
    override func tearDown() {
        
        super.tearDown()
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
    
    func typeTextInTextField(textField: XCUIElement, text: String) {
        textField.tap()
        self.deleteText(textField: textField)
        textField.typeText(text)
        self.tapKeyboardDoneButton()
    }
    
    func tapKeyboardDoneButton() {
        app.toolbars["Toolbar"].buttons["Done"].forceTapElement()
        waitToExecuteNextLine(timeout: 1)
    }
    
    func deleteText(textField: XCUIElement) {
        guard let stringValue = textField.value as? String else {
            return
        }
        
        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        textField.typeText(deleteString)
    }
    
}

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
    
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        
        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        self.typeText(deleteString)
    }
}

extension String {
    
    func getLocalizedString(baseUITest: XCTestCase) -> String {
        return Bundle(for: type(of: baseUITest)).localizedString(forKey: self, value: "", table: nil)
    }
}

extension XCTestCase {
    func waitForElementToAppear(_ element: XCUIElement) {
        let predicate = NSPredicate(format: "exists == true")
        let expectations = expectation(for: predicate, evaluatedWith: element,
                                       handler: nil)
        
        _ = XCTWaiter().wait(for: [expectations], timeout: 5)
    }
}
