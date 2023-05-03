//
//  File.swift
//
//
//  Created by minguk-kim on 2023/01/06.
//

import UIKit

public final actor ImageLoadManager {
    public static let shared = ImageLoadManager()

    private var onLoadingTask: [String: Task<UIImage?, Never>] = [:]
    private var onPrefetchTask: [String: Task<Void, Never>] = [:]

    @discardableResult
    public func loadImage(for fileName: String, size: CGSize) async -> UIImage? {
        let task = Task(priority: .medium) { () -> UIImage? in
            guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "jpeg") else {
                return nil
            }

            if let cachedImage = ImageCacheManager.shared.getCachedImage(fileUrl: fileUrl) {
                return cachedImage.downsample(imageAt: fileUrl, to: size)
            }

            guard let image = loadImageFromResource(for: fileUrl) else {
                return nil
            }

            ImageCacheManager.shared.insertImage(image, for: fileUrl)

            return image.downsample(imageAt: fileUrl, to: size)
        }
        onLoadingTask.updateValue(task, forKey: fileName)

        let result = await task.result

        do {
            onLoadingTask.removeValue(forKey: fileName)
            guard !Task.isCancelled else {
                return nil
            }
            return try result.get()
        } catch {
            return nil
        }
    }

    public func prefetchImage(for fileName: String) async {
        let task = Task(priority: .medium) {
            guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "png") else {
                return
            }
            guard await ImageCacheManager.shared.isAlreadyInCache(fileUrl: fileUrl) == false else {
                return
            }

            guard let image = loadImageFromResource(for: fileUrl) else {
                return
            }

            await ImageCacheManager.shared.insertImage(image, for: fileUrl)
        }
        onPrefetchTask.updateValue(task, forKey: fileName)
        _ = await task.result
        onPrefetchTask.removeValue(forKey: fileName)
    }

    public func cancelLoad(key: String) {
        let task = onLoadingTask.first { $0.key == key }?.value
        task?.cancel()
    }

    public func cancelPrefetch(key: String) {
        let task = onPrefetchTask.first { $0.key == key }?.value
        task?.cancel()
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
