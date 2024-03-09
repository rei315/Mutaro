//
//  AppIntroductionViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

public final class AppIntroductionViewModel: NSObject, Sendable {
    private let environment: AppIntroductionFeatureEnvironment

    public init(environment: AppIntroductionFeatureEnvironment) {
        self.environment = environment
    }

    func onTapAgree() async {
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.notFirstAppLaunching.rawValue)
        await environment.router.showHomeAsRoot()
    }
}
