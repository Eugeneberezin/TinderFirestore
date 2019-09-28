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
       let image1button = XCUIApplication().tables.buttons["IMAGE1BUTTON"]
       let selectPhotoButton = XCUIApplication().buttons["Select Photo"]
       let appSlider = XCUIApplication().sliders["MIN_SLIDER"]
        
       settingsButton.tap()
        XCUIApplication().swipeUp()
    
        
        
        //handle sliders
        guard appSlider.waitForExistence(timeout: 5) else {
            XCTFail()
            return
        }
        
        appSlider.adjust(toNormalizedSliderValue: 0.5)
        
        
       // minSliderSlider.adjust(toNormalizedSliderPosition: 0.9)
        
        
        
    
        
        
        
        
        
        //handle select photo
        
        XCUIApplication().tables.cells["Moments"].buttons["More Info"].tap()
        XCUIApplication().swipeDown()
        sleep(3)
        XCUIApplication().collectionViews["PhotosGridView"].cells.element(boundBy: 1).tap()
        
        
    }
    
    
    
    
    
    func testSlider() {
        let settingsButton = XCUIApplication().buttons["SETTINGS_BUTTON"]
        settingsButton.tap()
        XCUIApplication().swipeUp()
        
        let appSlider = XCUIApplication().sliders["your slider"]
        //wait for sliders
        guard appSlider.waitForExistence(timeout: 5) else {
            XCTFail()
            return
        }
        
        appSlider.adjust(toNormalizedSliderValue: 0.8)
        
    }

}

// extention to handle sliders
extension XCUIElement {
    
    open func adjust(toNormalizedSliderValue normalizedSliderValue: CGFloat) {
        let start = coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
        let end = coordinate(withNormalizedOffset: CGVector(dx: normalizedSliderValue, dy: 0.0))
        start.press(forDuration: 0.05, thenDragTo: end)
    }
    
}
