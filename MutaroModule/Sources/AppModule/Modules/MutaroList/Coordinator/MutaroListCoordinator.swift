//
//  MutaroListCoordinator.swift
//  
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

@MainActor
public final class MutaroListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let vc = MutaroListViewController()
        navigationController.pushViewController(vc, animated: false)
    }
}
