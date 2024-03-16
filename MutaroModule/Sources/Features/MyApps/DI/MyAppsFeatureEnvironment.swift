//
//  MyAppsFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Core
import Foundation

public struct MyAppsFeatureEnvironment: Sendable {
    public let appInfoUseCase: any AppInfoUseCase
    public let imageDownloadService: any ImageDownloadService
    public let keychainDataStore: any KeychainDataStoreProtocol
    public let router: any MyAppsRoutable

    public init(
        appInfoUseCase: any AppInfoUseCase,
        imageDownloadService: any ImageDownloadService,
        keychainDataStore: any KeychainDataStoreProtocol,
        router: any MyAppsRoutable
    ) {
        self.appInfoUseCase = appInfoUseCase
        self.imageDownloadService = imageDownloadService
        self.keychainDataStore = keychainDataStore
        self.router = router
    }
}
