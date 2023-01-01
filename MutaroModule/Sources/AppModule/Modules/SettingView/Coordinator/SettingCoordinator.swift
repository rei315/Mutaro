//
//  SettingCoordinator.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import UIKit

@MainActor
final class SettingCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
    }

    func start() {

    }
}
