//
//  SceneDelegate.swift
//  MutaroApp
//
//  Created by minguk-kim on 2022/12/29.
//

import AppResource
import Core
import Features
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let mainRouter = DefaultRouter(rootTransition: EmptyTransition())

    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        setupNavigationBarStyle()

        window = UIWindow(windowScene: windowScene)
        
        guard ProcessInfo.processInfo.environment["IS_TESTING"] != "True" else {
            return
        }
        
        window?.makeKeyAndVisible()

        let isNotFirstAppLaunching = UserDefaults.standard.bool(
            forKey: UserDefaultsKey.notFirstAppLaunching.rawValue)

        let mainVC: UIViewController
        if isNotFirstAppLaunching {
            mainVC = createHomeTabViewController()
        } else {
            mainVC = createAppIntroductViewController()
        }

        sleep(1)
        window?.rootViewController = mainVC
    }

    private func createHomeTabViewController() -> UIViewController {
        let tabs = [mainRouter.makeMutaroListTab(), mainRouter.makeSettingTab()]
        return HomeTabViewController(viewControllers: tabs)
    }

    private func createAppIntroductViewController() -> UIViewController {
        mainRouter.makeAppIntroduct(self)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}

extension SceneDelegate {
    func setupNavigationBarStyle() {
        let titleColor = Resources.Colors.black.color
        let appearance = UINavigationBarAppearance().apply {
            $0.largeTitleTextAttributes = [
                .foregroundColor: titleColor,
                .font: FontSize.plus5.ofBoldFont(),
            ]
            $0.backgroundColor = Resources.Colors.white.color
            $0.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: titleColor
            ]
        }

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

extension SceneDelegate: AppIntroductDelegate {
    func onTapAgree() {
        guard let window else {
            return
        }
        let vc = createHomeTabViewController()
        window.rootViewController = vc
        
        UIView.transition(
            with: window,
            duration: 0.5,
            options: [.transitionCrossDissolve],
            animations: nil
        )
    }
}
