//
//  RegisterJWTRoute.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import RegisterJWTFeature
import UIKit

public extension RegisterJWTRoute where Self: Router {
    func openRegisterJWTRoute() {
//        let push = PushTransition()
//        let router = DefaultRouter(rootTransition: push)
//        let viewModel = RegisterJWTViewModel(router: router)
//        let viewController = RegisterJWTViewController(viewModel: viewModel)
//        router.root = viewController
//
//        route(to: viewController, as: push)
    }
}

extension DefaultRouter: RegisterJWTRoute {}
