//
//  File.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

@MainActor
final public class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.childCoordinators = []
        self.navigationController = navigationController
    }

    public func start() {
        let isNotFirstAppLaunching = UserDefaults.standard.bool(
            forKey: UserDefaultsKey.notFirstAppLaunching.rawValue
        )

        if isNotFirstAppLaunching {
            showHomeView()
        } else {
            showAppIntroductionView()
        }
    }

    private func showHomeView() {
        let coordinator = HomeCoordinator(navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    private func showAppIntroductionView() {
        let coordinator = AppIntroductionCoordinator(navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

extension AppCoordinator: AppIntroductionCoordinatorDelegate {
    func didAgree() {
        childCoordinators = childCoordinators.filter { !($0.self is AppIntroductionCoordinator) }
        self.showHomeView()
    }
}
