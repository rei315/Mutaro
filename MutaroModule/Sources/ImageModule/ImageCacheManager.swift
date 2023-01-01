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

    private func insertImage(_ image: UIImage, for url: URL) {
        imageCache.setObject(image, forKey: url as AnyObject)
    }

    public func loadImage(for fileName: String, size: CGSize) -> UIImage? {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "png") else {
            return nil
        }
        if let imageFromCache = imageCache.object(forKey: fileUrl as AnyObject) as? UIImage {
            return imageFromCache
        }

        guard let image = loadImageFromResource(for: fileUrl) else {
            return nil
        }
        insertImage(image, for: fileUrl)

        return image.downsample(imageAt: fileUrl, to: size)
    }

    private func loadImageFromResource(for url: URL) -> UIImage? {
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            return image
        } catch {
            return nil
        }
    }
}
