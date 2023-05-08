//
//  MyAppsFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Core
import Foundation

public struct MyAppsFeatureEnvironment<ImageDownloadServiceType: ImageDownloadService> {
    public let client: Providable
    public let imageDownloadService: ImageDownloadServiceType

    public init(client: Providable, imageDownloadService: ImageDownloadServiceType) {
        self.client = client
        self.imageDownloadService = imageDownloadService
    }
}
