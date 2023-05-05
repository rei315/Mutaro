//
//  SettingRoute.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit
import SettingViewFeature
import RegisterJWTViewFeature

extension SettingRoute where Self: Router {
    public func makeSettingTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = SettingViewModel(router: router)
        let viewController = SettingViewController(viewModel: viewModel)
        router.root = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setLargeTitle()
        navigationController.tabBarItem = HomeTabPage.setting.item
        return navigationController
    }

    func selectMutaroListTab() {
        root?.tabBarController?.selectedIndex = HomeTabPage.setting.rawValue
    }
}
extension SettingRoute: RegisterJWTRoute {}
extension DefaultRouter: SettingRoute {}
