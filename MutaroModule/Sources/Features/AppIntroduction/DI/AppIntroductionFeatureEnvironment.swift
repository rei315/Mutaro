//
//  AppIntroductionFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Foundation

public struct AppIntroductionFeatureEnvironment: Sendable {
    public let router: any AppIntroductionRoutable
    public let dataStore: any AppIntroductionDataStoreProtocol

    public init(
        router: any AppIntroductionRoutable,
        dataStore: any AppIntroductionDataStoreProtocol
    ) {
        self.router = router
        self.dataStore = dataStore
    }
}
