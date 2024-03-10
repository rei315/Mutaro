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
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.notFirstAppLaunching.rawValue)
        environment.router.showHomeAsRoot()
    }
}
