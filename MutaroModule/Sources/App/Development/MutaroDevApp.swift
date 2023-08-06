//
//  MutaroDevApp.swift
//
//
//  Created by minguk-kim on 2023/06/08.
//

import Core
import FirebaseSetup
import NeedleFoundation
import UIKit

public final class MutaroDevApp {
    public static let shared = MutaroDevApp()

    public var devRootComponent: DevRootComponent!

    public func setup() {
        registerProviderFactories()
        devRootComponent = DevRootComponent()
        FirebaseSetup.configure()
    }

    @MainActor
    public func start(window: UIWindow?) {
        UINavigationBar.setGlobalStyle()
        UITabBar.setGlobalStyle()

        let isNotFirstAppLaunching = UserDefaults.standard.bool(
            forKey: UserDefaultsKey.notFirstAppLaunching.rawValue
        )
        let mainVC: UIViewController
        if isNotFirstAppLaunching {
            let myApps = devRootComponent.myAppsFeatureBuilder.build()
            let settings = devRootComponent.settingFeatureBuilder.build()
            mainVC = devRootComponent.homeFeatureBuilder.build(viewControllers: [myApps, settings])
        } else {
            mainVC = devRootComponent.appIntroductionFeatureBuilder.build()
        }
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}
