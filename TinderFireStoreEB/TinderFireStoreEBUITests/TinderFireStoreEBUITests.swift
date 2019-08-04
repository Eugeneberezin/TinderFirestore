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
        
       let settingsButton = XCUIApplication().buttons["SETTINGS_BUTTON"]
       let selectPhotoButton = XCUIApplication().buttons["Select Photo"]
        
        settingsButton.tap()
        selectPhotoButton.tap()
        
        
        XCUIApplication().tables.cells["Moments"].buttons["More Info"].tap()
        XCUIApplication().swipeDown()
        sleep(3)
        XCUIApplication().collectionViews["PhotosGridView"].cells.element(boundBy: 1).tap()
        
    
        
        
    }

}
