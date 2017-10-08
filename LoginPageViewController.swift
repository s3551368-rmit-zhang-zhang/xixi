//
//  LoginPageViewController.swift
//  Focus timer
//
//  Created by James zhang on 8/10/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import XCTest
import CoreData
@testable import Pods_Focus_timer

class LoginPageViewController: XCTestCase {
        
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
    /* Business Rules:
     *
     * 1. Testing Properties
     *    todayFitnessSelected and todayFoodSelected cannot have no elememts in the same time.
     *    Because, none selecting neither in food or fitness will make the plan unreasonable.
     *    That means the count of each set cannot be 0 in the same time
     *
     * 2. Testing Individual Methods
     *    getIntakeResults() method should return the right value which is based on food selecting
     *    getConsumeResults() method should return the right value which is based on fitness
     *    selecting.
     *
     * 3. Testing Method Combinations
     *    getPlanResults() method should return the right calories based on the getIntakeResults()
     *    and getConsumeResults()
     *
     * 4. Testing the Class
     *    Run the suite of tests.
     */
    
    //1. Testing Properties
    
    func testUserInfo(){
        
    }
}
