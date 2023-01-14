//
//  MutaroInfoUploadRoute.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

public protocol MutaroInfoUploadRoute {
    func openMutaroInfoUpload()
}

extension MutaroInfoUploadRoute where Self: Router {
    public func openMutaroInfoUpload() {
        let push = PushTransition()
        let router = DefaultRouter(rootTransition: push)
        let viewModel = MutaroInfoUploadViewModel(router: router)
        let viewController = MutaroInfoUploadViewController(viewModel: viewModel)
        router.root = viewController

        route(to: viewController, as: push)
    }
}

extension DefaultRouter: MutaroInfoUploadRoute {}
