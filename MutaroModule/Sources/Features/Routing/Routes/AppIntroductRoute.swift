//
//  AppIntroductRoute.swift
//  
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

@MainActor
public protocol AppIntroductDelegate: AnyObject {
    func onTapAgree()
}

@MainActor
public protocol AppIntroductRoute {
    func makeAppIntroduct(_ delegate: AppIntroductDelegate) -> UIViewController
}

extension AppIntroductRoute where Self: Router {
    public func makeAppIntroduct(_ delegate: AppIntroductDelegate) -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = AppIntroductionViewModel(router: router)
        let viewController = AppIntroductionViewController(viewModel: viewModel)
        viewController.delegate = delegate
        router.root = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}

extension DefaultRouter: AppIntroductRoute { }
