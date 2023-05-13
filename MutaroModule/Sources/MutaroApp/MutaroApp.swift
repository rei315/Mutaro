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
        setupGlobalStyle()

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

    private func setupGlobalStyle() {
        let titleColor = R.color.black() ?? .black
        let appearance = UINavigationBarAppearance().apply {
            $0.largeTitleTextAttributes = [
                .foregroundColor: titleColor,
                .font: UIFont.boldSystemFont(ofSize: 32)
            ]
            $0.backgroundColor = R.color.white() ?? .white
            $0.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: titleColor
            ]
        }

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().clipsToBounds = true
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
    }
}
