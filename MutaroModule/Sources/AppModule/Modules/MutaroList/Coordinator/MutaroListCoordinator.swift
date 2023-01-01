//
//  MutaroListCoordinator.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

@MainActor
public final class MutaroListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
    }

    public func start() {
        let vc = MutaroListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    public func tapMutaroPhoto() {

    }
}
