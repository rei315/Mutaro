//
//  SettingRoute.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

public protocol SettingRoute {
    func makeSettingTab() -> UIViewController
}

extension SettingRoute where Self: Router {
    public func makeSettingTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = SettingViewModel(router: router)
        let viewController = SettingViewController(viewModel: viewModel)
        router.root = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.tabBarItem = HomeTabPage.setting.item
        return navigationController
    }

    func selectMutaroListTab() {
        root?.tabBarController?.selectedIndex = HomeTabPage.setting.rawValue
    }
}

extension DefaultRouter: SettingRoute {}
