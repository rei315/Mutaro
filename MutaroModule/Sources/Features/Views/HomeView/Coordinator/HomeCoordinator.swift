//
//  HomeCoordinator.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

enum HomeTabPage {
    case mutaroList
    case setting

    var title: String {
        switch self {
        case .mutaroList:
            return "mutaro"
        case .setting:
            return "setting"
        }
    }
}

@MainActor
final class HomeCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    var tabBarController: UITabBarController

    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
        tabBarController = .init()
    }

    func start() {
        Task { @MainActor in
            let mutaroController = await createController(.mutaroList)
            let settingController = await createController(.setting)
            let controllers: [UINavigationController] = [
                mutaroController,
                settingController,
            ]
            createHomeTabController(controllers)
            setupTabBar()
        }
    }

    private func createHomeTabController(_ tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.isTranslucent = false
        navigationController.viewControllers = [tabBarController]
    }

    private func createController(_ page: HomeTabPage) async -> UINavigationController {
        let navController: UINavigationController
        let tabBarItem: UITabBarItem

        let normalTabImageColor = AppColor.navy.toColor()
        let normalImageConfiguration = UIImage.SymbolConfiguration(
            hierarchicalColor: normalTabImageColor
        )

        let selectedTabImageColor = AppColor.turquoise.toColor()
        let selectedImageConfiguration = UIImage.SymbolConfiguration(
            hierarchicalColor: selectedTabImageColor
        )

        switch page {
        case .mutaroList:
            let mutaroListVC = MutaroListViewController()
            navController = UINavigationController(rootViewController: mutaroListVC)
            let imageName = "text.below.photo"
            let tabImage = UIImage(
                systemName: imageName,
                withConfiguration: normalImageConfiguration
            )
            let selectedTabImage = UIImage(
                systemName: imageName,
                withConfiguration: selectedImageConfiguration
            )
            tabBarItem = UITabBarItem(
                title: page.title,
                image: tabImage,
                selectedImage: selectedTabImage
            )
        case .setting:
            let settingVC = SettingViewController()
            settingVC.title = page.title
            navController = UINavigationController(rootViewController: settingVC)
            let imageName = "gear"
            let tabImage = UIImage(
                systemName: imageName,
                withConfiguration: normalImageConfiguration
            )
            let selectedTabImage = UIImage(
                systemName: imageName,
                withConfiguration: selectedImageConfiguration
            )
            tabBarItem = UITabBarItem(
                title: page.title,
                image: tabImage,
                selectedImage: selectedTabImage
            )
        }
        navController.tabBarItem = tabBarItem
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationItem.largeTitleDisplayMode = .always
        return navController
    }

    private func setupTabBar() {
        tabBarController.tabBar.lets {
            let itemAppearance = UITabBarItemAppearance().apply {
                $0.normal.iconColor = .brown
                $0.normal.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: AppColor.navy.toColor()
                ]
                $0.selected.iconColor = AppColor.black.toColor()
                $0.selected.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: AppColor.black.toColor()
                ]
            }
            let barAppearance = UITabBarAppearance().apply {
                $0.configureWithOpaqueBackground()
                $0.backgroundColor = AppColor.white.toColor()
                $0.inlineLayoutAppearance = itemAppearance
                $0.stackedLayoutAppearance = itemAppearance
                $0.compactInlineLayoutAppearance = itemAppearance
            }
            $0.standardAppearance = barAppearance
            $0.tintAdjustmentMode = .normal
            $0.scrollEdgeAppearance = barAppearance
            $0.isTranslucent = false
        }
    }
}

extension HomeCoordinator: UITabBarControllerDelegate {

}
