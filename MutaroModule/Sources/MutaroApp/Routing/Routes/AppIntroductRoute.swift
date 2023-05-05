//
//  AppIntroductRoute.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import AppIntroductionFeature
import UIKit

public extension AppIntroductRoute where Self: Router {
    func makeAppIntroduct(_: AppIntroductDelegate) -> UIViewController {
//        let router = DefaultRouter(rootTransition: EmptyTransition())
//        let viewModel = AppIntroductionViewModel(router: router)
//        let viewController = AppIntroductionViewController(viewModel: viewModel)
//        viewController.delegate = delegate
//        router.root = viewController
//
//        let navigationController = UINavigationController(rootViewController: viewController)
//        return navigationController
        UIViewController()
    }
}

extension DefaultRouter: AppIntroductRoute {}
