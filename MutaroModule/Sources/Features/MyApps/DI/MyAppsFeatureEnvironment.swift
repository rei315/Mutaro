//
//  MyAppsFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Core
import Foundation

public struct MyAppsFeatureEnvironment {
    public let appInfoUseCase: AppInfoUseCase
    public let imageDownloadService: ImageDownloadService
    public let router: MyAppsRoutable

    public init(
        appInfoUseCase: AppInfoUseCase,
        imageDownloadService: ImageDownloadService,
        router: MyAppsRoutable
    ) {
        self.appInfoUseCase = appInfoUseCase
        self.imageDownloadService = imageDownloadService
        self.router = router
    }
}
