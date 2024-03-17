//
//  SettingViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import Core
import UIKit

@MainActor
public final class SettingViewModel: NSObject, Sendable {
    private let environment: SettingFeatureEnvironment

    var cancellables: Set<AnyCancellable> = []

    public init(environment: SettingFeatureEnvironment) {
        self.environment = environment
    }

    public func routeToRegisterJWT(from viewController: UIViewController) {
        environment.router.showRegisterJWT(from: viewController)
    }
}
