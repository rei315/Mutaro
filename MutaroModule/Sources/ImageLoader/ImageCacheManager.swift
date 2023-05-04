//
//  ImageCacheManager.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import Foundation
import Kingfisher

public typealias ImageCacheType = ImageCacheManager.ImageCacheType

public final class ImageCacheManager {
    public static let shared = ImageCacheManager()

    public enum ImageCacheType: String {
        case myAppCache = "myApp.Mutaro.MGHouse.me"
        case defaultCache

        func getCache() -> ImageCache {
            switch self {
            case .myAppCache:
                return ImageCacheManager.shared.myAppCache
            case .defaultCache:
                return ImageCacheManager.shared.defaultCache
            }
        }
    }

    // TODO: - add user-detail cache
    private let myAppCache: ImageCache
    private let defaultCache = ImageCache.default

    init() {
        // 100 mb memory, 60 sec to expiration
        let megabyte = 1024 * 1024
        myAppCache = ImageCache(name: ImageCacheType.myAppCache.rawValue)
        myAppCache.memoryStorage.config.totalCostLimit = 100 * megabyte
        myAppCache.memoryStorage.config.countLimit = 100
        myAppCache.memoryStorage.config.cleanInterval = 60
        myAppCache.memoryStorage.config.expiration = .seconds(60)

        defaultCache.memoryStorage.config.totalCostLimit = 300 * megabyte
        defaultCache.memoryStorage.config.countLimit = 100
        defaultCache.memoryStorage.config.cleanInterval = 30
        defaultCache.memoryStorage.config.expiration = .seconds(300)
    }

    public func clearCache(_ types: [ImageCacheType]) {
        for type in types {
            switch type {
            case .myAppCache:
                myAppCache.clearMemoryCache()
            case .defaultCache:
                defaultCache.clearMemoryCache()
            }
        }
    }

    public func removeExpiredCache() {
        myAppCache.memoryStorage.removeExpired()
        defaultCache.memoryStorage.removeExpired()
    }
}
