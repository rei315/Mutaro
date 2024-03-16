//
//  AppIntroductionFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Foundation

public struct AppIntroductionFeatureEnvironment {
    public let router: any AppIntroductionRoutable

    public init(router: any AppIntroductionRoutable) {
        self.router = router
    }
}
