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
    public let router: any MyAppsRoutable

    public init(
        appInfoUseCase: any AppInfoUseCase,
        imageDownloadService: any ImageDownloadService,
        router: any MyAppsRoutable
    ) {
        self.appInfoUseCase = appInfoUseCase
        self.imageDownloadService = imageDownloadService
        self.router = router
    }
}
