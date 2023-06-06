//
//  MyAppToolsViewModel.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Foundation

final class MyAppToolsViewModel {
    private let appId: String
    private let environment: MyAppToolsFeatureEnvironment

    public init(
        appId: String,
        environment: MyAppToolsFeatureEnvironment
    ) {
        self.appId = appId
        self.environment = environment
    }
}
