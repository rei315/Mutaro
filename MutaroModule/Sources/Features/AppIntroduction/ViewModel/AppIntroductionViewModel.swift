//
//  AppIntroductionViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

@MainActor
public final class AppIntroductionViewModel: NSObject, Sendable {
    private let environment: AppIntroductionFeatureEnvironment

    public init(environment: AppIntroductionFeatureEnvironment) {
        self.environment = environment
    }

    func onTapAgree() {
        environment.dataStore.storeFirstLaunchStatus(with: true)
        environment.router.showHomeAsRoot()
    }
}
