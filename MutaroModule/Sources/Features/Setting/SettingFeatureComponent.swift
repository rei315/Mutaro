//
//  SettingFeatureComponent.swift
//  MutaroApp
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import Foundation
import NeedleFoundation
import UIKit

public protocol SettingFeatureDependency: Dependency {
    // TODO: - var 遷移するB FeatureのBuilder: BModuleBuildable { get }
}

public class SettingFeatureBuilder: Builder<SettingFeatureDependency>, SettingFeatureBuildable {
    @MainActor
    public func build() -> UIViewController {
        SettingViewController(
            dependency: .init(
                viewModel: .init()
            )
        )
    }
}

public class SettingFeatureBuilderComponent: Component<SettingFeatureDependency>, FeatureSetting {
    public func settingFeatureBuilder() -> SettingFeatureBuildable {
        SettingFeatureBuilder(dependency: dependency)
    }
}
