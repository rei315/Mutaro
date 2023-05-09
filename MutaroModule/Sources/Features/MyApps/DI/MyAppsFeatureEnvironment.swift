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

    public init(client: Providable, imageDownloadService: ImageDownloadService) {
        self.client = client
        self.imageDownloadService = imageDownloadService
    }
}
