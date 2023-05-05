//
//  File.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import NeedleFoundation
import UIKit

public protocol SettingFeatureBuildable: Buildable {
    func build() -> UIViewController
}

public protocol SettingFeatureBuilder {
    func settingFeatureBuilder() -> SettingFeatureBuildable
}
