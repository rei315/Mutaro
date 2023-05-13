//
//  MyAppsFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Core
import Foundation

public struct MyAppsFeatureEnvironment {
    public let client: Providable
    public let imageDownloadService: ImageDownloadService
    public let router: MyAppsRoutable

    public init(
        client: Providable,
        imageDownloadService: ImageDownloadService,
        router: MyAppsRoutable
    ) {
        self.client = client
        self.imageDownloadService = imageDownloadService
        self.router = router
    }
}
