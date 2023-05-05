//
//  AppIntroductionFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Foundation

public struct AppIntroductionFeatureEnvironment {
    public let router: AppIntroductionRoutable

    public init(router: AppIntroductionRoutable) {
        self.router = router
    }
}
