//
//  ImageCacheManager.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import UIKit

@globalActor
public final actor ImageCacheManager {
    public struct Config {
        let countLimit: Int
        let memoryLimit: Int

        public static let defaultConfig = Config(
            countLimit: 100,
            memoryLimit: 1024 * 1024 * 300
        )
    }

    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()

    private let config: Config
    public static let shared = ImageCacheManager()

    public init(config: Config = Config.defaultConfig) {
        self.config = config
    }

    public func insertImage(_ image: UIImage, for url: URL) {
        imageCache.setObject(image, forKey: url as AnyObject)
    }

    public func getCachedImage(fileUrl: URL) -> UIImage? {
        guard let imageFromCache = imageCache.object(forKey: fileUrl as AnyObject) as? UIImage
        else {
            return nil
        }
        return imageFromCache
    }
}
