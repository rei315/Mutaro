//
//  ImageDownloadService.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import Foundation
import Kingfisher

public protocol ImageDownloadable {
    func downloadImage(with urlString: String, cache targetCache: ImageCacheType)
    func cancelDownloadImage(with urlString: String)
}

public final class ImageDownloadService: ImageDownloadable {
    public init() {}

    public func downloadImage(
        with urlString: String,
        cache targetCache: ImageCacheType
    ) {
        let cache = targetCache.getCache()
        guard !cache.isCached(forKey: urlString) else {
            return
        }

        guard let url = URL(string: urlString) else {
            return
        }

        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(
            with: resource,
            options: [
                .cacheOriginalImage,
                .targetCache(cache)
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
