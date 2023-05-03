//
//  SettingViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import UIKit

final class SettingViewModel: NSObject {
    typealias Routes = SettingRoute & RegisterJWTRoute
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
