//
//  SettingCoordinator.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import UIKit

@MainActor
public final class SettingCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
    }

    public func start() {
        let vc = SettingViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
