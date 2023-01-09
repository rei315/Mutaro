//
//  MutaroUITestsLaunchTests.swift
//  MutaroUITests
//
//  Created by minguk-kim on 2023/01/09.
//

import XCTest

final class MutaroUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
