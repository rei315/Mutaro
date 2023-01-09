//
//  MutaroListViewControllerTests.swift
//  MutaroAppUITests
//
//  Created by minguk-kim on 2023/01/01.
//

import XCTest

class MutaroListViewControllerTests: XCTestCase {
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

    func testExample() throws {
        let app = XCUIApplication()
        let title = app.navigationBars["mutaro"].staticTexts["mutaro"].label
                
        XCTAssertEqual(title, "mutaro")
    }
}
