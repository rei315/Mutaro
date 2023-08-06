//
//  SnapshotTests.swift
//
//
//  Created by minguk-kim on 2023/08/06.
//

import SnapshotTesting
import XCTest

import Client
import Core
import ImageLoader
import NeedleFoundation

import AppIntroductionFeature
import HomeFeature
import MyAppsFeature
import MyAppToolsFeature
import RegisterJWTFeature
import SettingFeature

final class SnapshotTests: XCTestCase {
    override func setUpWithError() throws {
        // Something Setup
    }

    @MainActor
    func testSettingFeature() throws {
        let vc = SettingViewController(
            dependency: .init(
                viewModel: .init(
                    environment: .init(router: SettingRouterSpy())
                )
            )
        )
        assertCustomSnapshot(viewController: vc)
    }
}
