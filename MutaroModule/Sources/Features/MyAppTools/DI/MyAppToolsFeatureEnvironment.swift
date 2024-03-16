//
//  MyAppToolsFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Core
import Foundation

public struct MyAppToolsFeatureEnvironment: Sendable {
    public let ciProductUseCase: any CIProductUseCase
    public let router: any MyAppToolsRoutable
    public let keychainDataStore: any KeychainDataStoreProtocol

    public init(
        ciProductUseCase: any CIProductUseCase,
        router: any MyAppToolsRoutable,
        keychainDataStore: any KeychainDataStoreProtocol
    ) {
        self.ciProductUseCase = ciProductUseCase
        self.router = router
        self.keychainDataStore = keychainDataStore
    }
}
