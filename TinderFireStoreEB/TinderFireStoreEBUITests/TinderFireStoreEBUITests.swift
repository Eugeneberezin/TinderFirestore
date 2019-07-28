//
//  TinderFireStoreEBUITests.swift
//  TinderFireStoreEBUITests
//
//  Created by Eugene Berezin on 7/16/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import XCTest
import UIKit
import Foundation

class TinderFireStoreEBUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let fullNameTextFiled = XCUIApplication().textFields["Enter full name"]
        let emailTextField = XCUIApplication().textFields["Enter email"]
        
        fullNameTextFiled.tap()
        fullNameTextFiled.typeText("Data")
        let dataForEmailField = fullNameTextFiled.value as? String ?? ""
        emailTextField.tap()
        emailTextField.typeText(dataForEmailField)
        
       XCTAssertEqual(fullNameTextFiled.value as? String, "Data")
        
        
    }

}
