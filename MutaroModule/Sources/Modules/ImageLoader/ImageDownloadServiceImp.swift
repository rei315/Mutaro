//
//  ImageDownloadServiceImp.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import Core
import Foundation
import Kingfisher

public final class ImageDownloadServiceImp: ImageDownloadService {
    public init() {}

    public func downloadImage(
        with urlString: String,
        cache targetCache: ImageCache
    ) {
        guard !targetCache.isCached(forKey: urlString) else {
            return
        }

        guard let url = URL(string: urlString) else {
            return
        }

        let resource = KF.ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(
            with: resource,
            options: [
                .cacheOriginalImage,
                .targetCache(targetCache)
            ],
            completionHandler: nil
        )
    }

    public func cancelDownloadImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        KingfisherManager.shared.downloader.cancel(url: url)
    }
}
