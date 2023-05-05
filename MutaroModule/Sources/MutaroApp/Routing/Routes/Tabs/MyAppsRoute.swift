//
//  MyAppsRoute.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

public protocol MyAppsRoute {
    func makeMyAppsTab() -> UIViewController
}

extension MyAppsRoute where Self: Router {
    public func makeMyAppsTab() -> UIViewController {
//        let router = DefaultRouter(rootTransition: EmptyTransition())
//        let viewModel = MyAppsViewModel(router: router)
//        let viewController = MyAppsViewController(viewModel: viewModel)
//        router.root = viewController
//
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.setLargeTitle()
//        navigationController.tabBarItem = HomeTabPage.myApps.item
//        return navigationController
        UIViewController()
    }

    func selectMutaroListTab() {
//        root?.tabBarController?.selectedIndex = HomeTabPage.myApps.rawValue
    }
}

extension DefaultRouter: MyAppsRoute {}
