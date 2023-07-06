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
    var registerJWTFeatureBuilder: RegisterJWTFeatureBuildable { get }
}

public class SettingFeatureBuilder: Builder<SettingFeatureDependency>, SettingFeatureBuildable {
    @MainActor
    public func build() -> UIViewController {
        let settingVC = SettingViewController(
            dependency: .init(
                viewModel: .init(environment: environment)
            )
        )
        let navigationVC = UINavigationController(rootViewController: settingVC)
        navigationVC.view.backgroundColor = .white
        let imageName = "gear"
        let normalTabColor = UIColor(resource: .navy)
        let normalTabImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: normalTabColor)
        let normalTabImage = UIImage(systemName: imageName, withConfiguration: normalTabImageConfiguration)
        let selectedTabColor = UIColor(resource: .turquoise)
        let selectedTabImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: selectedTabColor)
        let selectedTabImage = UIImage(systemName: imageName, withConfiguration: selectedTabImageConfiguration)

        navigationVC.tabBarItem = .init(
            title: "Setting",
            image: normalTabImage,
            selectedImage: selectedTabImage
        )
        return navigationVC
    }

    private var environment: SettingFeatureEnvironment {
        .init(router: router)
    }

    private var router: SettingRoutable {
        SettingRouter(
            dependency: .init(
                registerJWTFeatureBuilder: dependency.registerJWTFeatureBuilder
            )
        )
    }
}

public class SettingFeatureBuilderComponent: Component<SettingFeatureDependency>, FeatureSetting {
    public func settingFeatureBuilder() -> SettingFeatureBuildable {
        SettingFeatureBuilder(dependency: dependency)
    }
}
