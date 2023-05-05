//
//  File.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import Kingfisher
import UIKit

public extension UIImageView {
    func rt_setImage(
        withURL url: URL?,
        placeholderImage: UIImage? = nil,
        processors: [ImageProcessor] = [],
        fade: TimeInterval = 0.4,
        targetCache: ImageCache? = nil,
        completion: ((UIImage?) -> Void)? = nil
    ) {
        image = placeholderImage
        guard let url else {
            return
        }
        let cache: ImageCache
        if let targetCache {
            cache = targetCache
        } else {
            cache = ImageCacheType.defaultCache.getCache()
        }

        let kf = KF.url(url)
            .cacheOriginalImage()
            .targetCache(cache)
            .onSuccess { result in completion?(result.image) }
            .placeholder(placeholderImage)
            .fade(duration: fade)

        processors.forEach {
            _ = kf.setProcessor($0)
        }

        kf.set(to: self)
    }

    func rt_cancelImageLoad() {
        kf.cancelDownloadTask()
    }
}
