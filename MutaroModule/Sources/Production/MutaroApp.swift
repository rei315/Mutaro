//
//  MutaroApp.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import FirebaseSetup
import NeedleFoundation
import UIKit

public final class MutaroApp {
    public static let shared = MutaroApp()

    private(set) var rootComponent: RootComponent!

    public func setup() {
        registerProviderFactories()
        rootComponent = RootComponent()
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
            let myApps = rootComponent.myAppsFeatureBuilder.build()
            let settings = rootComponent.settingFeatureBuilder.build()
            mainVC = rootComponent.homeFeatureBuilder.build(viewControllers: [myApps, settings])
        } else {
            mainVC = rootComponent.appIntroductionFeatureBuilder.build()
        }
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}
