//
//  AppIntroductionFeatureComponent.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import Foundation
import NeedleFoundation
import UIKit

@MainActor
public protocol AppIntroductionFeatureDependency: Dependency, Sendable {
    // TODO: - var 遷移するB FeatureのBuilder: BModuleBuildable { get }
    var myAppsFeatureBuilder: any MyAppsFeatureBuildable { get }
    var settingFeatureBuilder: any SettingFeatureBuildable { get }
    var homeFeatureBuilder: any HomeFeatureBuildable { get }
}

@MainActor
public class AppIntroductionFeatureBuilder: Builder<AppIntroductionFeatureDependency>, AppIntroductionFeatureBuildable {
    public func build() -> UIViewController {
        let vc = AppIntroductionViewController(
            dependency: .init(
                viewModel: .init(environment: environment)
            )
        )
        return UINavigationController(rootViewController: vc)
    }

    private var environment: AppIntroductionFeatureEnvironment {
        .init(router: router)
    }

    private var router: any AppIntroductionRoutable {
        // TODO: - dependency initの中で遷移するBModuleのBuilderを入れる
        AppIntroductionRouter(
            dependency: .init(
                homeFeatureBuilder: dependency.homeFeatureBuilder,
                myAppsFeatureBuilder: dependency.myAppsFeatureBuilder,
                settingFeatureBuilder: dependency.settingFeatureBuilder
            )
        )
    }
}

public class AppIntroductionFeatureBuilderComponent: Component<AppIntroductionFeatureDependency>, FeatureAppIntroduction {
    public func appIntroductionBuilder() -> any Core.AppIntroductionFeatureBuildable {
        AppIntroductionFeatureBuilder(dependency: dependency)
    }
}
