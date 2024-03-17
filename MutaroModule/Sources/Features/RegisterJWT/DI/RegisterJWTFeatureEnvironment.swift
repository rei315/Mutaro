//
//  RegisterJWTFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Core
import Foundation

public struct RegisterJWTFeatureEnvironment: Sendable {
    public let keychainDataStore: any KeychainDataStoreProtocol
    public let router: any RegisterJWTFeatureRoutable

    public init(
        keychainDataStore: any KeychainDataStoreProtocol,
        router: any RegisterJWTFeatureRoutable
    ) {
        self.keychainDataStore = keychainDataStore
        self.router = router
    }
}
