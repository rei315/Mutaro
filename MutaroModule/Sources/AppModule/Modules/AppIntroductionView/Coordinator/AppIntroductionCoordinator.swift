//
//  AppIntroductionCoordinator.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import UIKit

@MainActor
protocol AppIntroductionCoordinatorDelegate: AnyObject {
    func didAgree()
}

@MainActor
final public class AppIntroductionCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var delegate: AppIntroductionCoordinatorDelegate?

    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
    }

    func start() {
        let viewController = AppIntroductionViewController()
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }

    func onTapAgree() {
        delegate?.didAgree()
    }
}
