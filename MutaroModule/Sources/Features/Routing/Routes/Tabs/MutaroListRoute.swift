//
//  MutaroListRoute.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

public protocol MutaroListRoute {
    func makeMutaroListTab() -> UIViewController
}

extension MutaroListRoute where Self: Router {
    public func makeMutaroListTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = MutaroListViewModel(router: router)
        let viewController = MutaroListViewController(viewModel: viewModel)
        router.root = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.tabBarItem = HomeTabPage.mutaroList.item
        return navigationController
    }

    func selectMutaroListTab() {
        root?.tabBarController?.selectedIndex = HomeTabPage.mutaroList.rawValue
    }
}

extension DefaultRouter: MutaroListRoute {}
