//
//  LoadingRoute.swift
//
//
//  Created by minguk-kim on 2023/01/15.
//

import Combine
import UIKit

public protocol LoadingRoute {
    func openLoading(shouldCloseSubject: PassthroughSubject<Void, Never>)
}

extension LoadingRoute where Self: Router {
    public func openLoading(shouldCloseSubject: PassthroughSubject<Void, Never>) {
        let modal = ModalTransition(
            isAnimated: true,
            modalTransitionStyle: .crossDissolve,
            modalPresentationStyle: .overCurrentContext
        )
        let router = DefaultRouter(rootTransition: modal)
        let viewModel = LoadingViewModel(
            router: router,
            shouldCloseLoadingSubject: shouldCloseSubject
        )
        let viewController = LoadingViewController(viewModel: viewModel)
        router.root = viewController

        route(to: viewController, as: modal)
    }
}

extension DefaultRouter: LoadingRoute {}
