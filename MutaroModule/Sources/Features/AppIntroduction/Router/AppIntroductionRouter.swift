//
//  AppIntroductionRouter.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import UIKit

public protocol AppIntroductionRoutable {
    @MainActor
    func showHomeAsRoot()
}

public class AppIntroductionRouter: AppIntroductionRoutable {
    public struct Dependency {
        // TODO: - ここから遷移するfeatureのbuilder
        public let homeFeatureBuilder: HomeFeatureBuildable
        public let myAppsFeatureBuilder: MyAppsFeatureBuildable
        public let settingsFeatureBuilder: SettingFeatureBuildable

        public init(homeFeatureBuilder: HomeFeatureBuildable, myAppsFeatureBuilder: MyAppsFeatureBuildable, settingFeatureBuilder: SettingFeatureBuildable) {
            self.homeFeatureBuilder = homeFeatureBuilder
            self.myAppsFeatureBuilder = myAppsFeatureBuilder
            settingsFeatureBuilder = settingFeatureBuilder
        }
    }

    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    @MainActor
    public func showHomeAsRoot() {
        let myApps = dependency.myAppsFeatureBuilder.build()
        let settings = dependency.settingsFeatureBuilder.build()
        let vc = dependency.homeFeatureBuilder.build(viewControllers: [myApps, settings])
        guard let window = KeyWindowProvider().getKeyWindow() else {
            return
        }
        window.rootViewController = vc
        UIView.transition(
            with: window,
            duration: 0.5,
            options: [.transitionCrossDissolve],
            animations: nil
        )
    }
}
