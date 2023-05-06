//
//  File.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import NeedleFoundation
import UIKit

public protocol SettingFeatureBuildable: Buildable {
    @MainActor
    func build() -> UIViewController
}

public protocol FeatureSetting {
    func settingFeatureBuilder() -> SettingFeatureBuildable
}
