//
//  Focus_timerUITests.swift
//  Focus timerUITests
//
//  Created by Zhang Zhang on 8/18/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import XCTest

class Focus_timerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        let pickerWheel = app.pickerWheels["25:00"]
        pickerWheel.press(forDuration: 0.5);
        pickerWheel.tap()
        pickerWheel.press(forDuration: 0.6);
        pickerWheel.tap()
        pickerWheel.swipeUp()
        app.buttons["START"].tap()
        app.buttons["STOP"].tap()
        
        let focusTimerViewNavigationBar = app.navigationBars["Focus_timer.View"]
        focusTimerViewNavigationBar.buttons["Group"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["MUSIC"].tap()
        app.navigationBars["Focus_timer.MusicTableView"].buttons["Group"].tap()
        tablesQuery.staticTexts["BACKGROUNDS"].tap()
        app.navigationBars["Focus_timer.BackGroundsView"].buttons["Group"].tap()
        tablesQuery.staticTexts["ABOUT FOCUS/US"].tap()
        app.navigationBars["Focus_timer.AboutFocusView"].buttons["Group"].tap()
        
        let homeStaticText = tablesQuery.staticTexts["HOME"]
        homeStaticText.tap()
        focusTimerViewNavigationBar.buttons["20402"].tap()
        tablesQuery.staticTexts["TOTAL FOCUS TIME"].tap()
        app.tabBars.buttons["MONTHLY"].tap()
        app.navigationBars["Focus_timer.MonthReviewView"].buttons["20402"].tap()
        homeStaticText.tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
