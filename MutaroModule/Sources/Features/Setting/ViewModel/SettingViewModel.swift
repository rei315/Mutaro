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

public final class SettingViewModel: NSObject {
    var cancellables: Set<AnyCancellable> = []

    override public init() {
        super.init()
    }

    public func routeToRegisterJWT() {
//        router.openRegisterJWTRoute()
    }
}
