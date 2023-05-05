//
//  SettingViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import UIKit

public protocol SettingRoute {
    func makeSettingTab() -> UIViewController
    func openRegisterJWTRoute()
}

final class SettingViewModel: NSObject {
    typealias Routes = SettingRoute
    private let router: Routes

    var cancellables: Set<AnyCancellable> = []

    init(router: Routes) {
        self.router = router
        super.init()
    }

    func routeToRegisterJWT() {
        router.openRegisterJWTRoute()
    }
}
