//
//  AppIntroductionRouter.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import UIKit

public protocol AppIntroductionRoutable {
    func showHomeAsRoot()
}

public class AppIntroductionRouter: AppIntroductionRoutable {
    public struct Dependency {
        // TODO: - ここから遷移するfeatureのbuilder
        let homeBuilder: HomeViewFeatureBuildable
        let myAppsBuilder: MyAppsFeatureBuildable
        let settingsBuilder: SettingFeatureBuildable

        public init(homeBuilder: HomeViewFeatureBuildable, myAppsBuilder: MyAppsFeatureBuildable, settingsBuilder: SettingFeatureBuildable) {
            self.homeBuilder = homeBuilder
            self.myAppsBuilder = myAppsBuilder
            self.settingsBuilder = settingsBuilder
        }
    }

    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    // TODO: - showBFeature
    @MainActor
    public func showHomeAsRoot() {
//        let myApps = dependency.myAppsBuilder.build()
//        let settings = dependency.settingsBuilder.build()
//        let vc = dependency.homeBuilder.build(viewControllers: [myApps, settings])
//        guard let window = KeyWindowProvider().getKeyWindow() else {
//            return
//        }
//        window.rootViewController = vc
//        UIView.transition(
//            with: window,
//            duration: 0.5,
//            options: [.transitionCrossDissolve],
//            animations: nil
//        )
    }
}
