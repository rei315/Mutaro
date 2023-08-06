//
//  SnapshotTests.swift
//  
//
//  Created by minguk-kim on 2023/08/06.
//

import XCTest
import SnapshotTesting

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
        MutaroSpyApp.shared.setup()
    }

    @MainActor
    func testSettingFeature() throws {
        assertPreviewSnapshot(SettingFeaturePreview.self)        
    }
}
