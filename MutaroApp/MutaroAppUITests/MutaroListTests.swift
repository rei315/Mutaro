//
//  MutaroListTests.swift
//  MutaroAppUITests
//
//  Created by minguk-kim on 2023/01/09.
//

import XCTest

final class MutaroListTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let title = app.navigationBars["mutaro"].staticTexts["mutaro"]
        XCTAssertTrue(title.exists)
    }
}
