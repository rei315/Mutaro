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
import AppIntroductionFeature

public protocol AppIntroductionFeatureDependency: Dependency {
    // TODO: - var 遷移するB FeatureのBuilder: BModuleBuildable { get }
    var myAppsFeatureBuilder: MyAppsFeatureBuildable { get }
    var settingsFeatureBuilder: SettingFeatureBuildable { get }
    var homeFeatureBuilder: HomeViewFeatureBuildable { get }
}

public class AppIntroductionFeatureBuilder: Builder<AppIntroductionFeatureDependency>, AppIntroductionFeatureBuildable {
    @MainActor
    public func build() -> UIViewController {
        let vc = AppIntroductionViewController(
            dependency: .init(
                viewModel: .init(environment: environment)
            )
        )
        return UINavigationController(rootViewController: vc)
    }

    public var environment: AppIntroductionFeatureEnvironment {
        .init(router: router)
    }

    private var router: AppIntroductionRoutable {
        // TODO: - dependency initの中で遷移するBModuleのBuilderを入れる
        AppIntroductionRouter(
            dependency: .init(
                homeBuilder: dependency.homeFeatureBuilder,
                myAppsBuilder: dependency.myAppsFeatureBuilder,
                settingsBuilder: dependency.settingsFeatureBuilder
            )
        )
    }
}

public class AppIntroductionFeatureBuilderComponent: Component<AppIntroductionFeatureDependency>, FeatureAppIntroduction {
    public func appIntroductionBuilder() -> Core.AppIntroductionFeatureBuildable {
        AppIntroductionFeatureBuilder(dependency: dependency)
    }
}
