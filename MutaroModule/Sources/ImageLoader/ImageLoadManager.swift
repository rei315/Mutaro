//
//  File.swift
//
//
//  Created by minguk-kim on 2023/01/06.
//

import UIKit

@globalActor
public final actor ImageLoadManager {
    public static let shared = ImageLoadManager()

    private var onLoadingTask: [String: Task<UIImage?, Never>] = [:]
    private var onPrefetchTask: [String: Task<(), Never>] = [:]

    @discardableResult
    public func loadImage(for fileName: String, size: CGSize) async -> UIImage? {
        let task = Task { () -> UIImage? in
            guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "png") else {
                return nil
            }

            if let cachedImage = await ImageCacheManager.shared.getCachedImage(fileUrl: fileUrl) {
                return cachedImage.downsample(imageAt: fileUrl, to: size)
            }

            guard let image = loadImageFromResource(for: fileUrl) else {
                return nil
            }

            await ImageCacheManager.shared.insertImage(image, for: fileUrl)

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
        let task = Task {
            guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "png") else {
                return
            }
            guard await ImageCacheManager.shared.getCachedImage(fileUrl: fileUrl) == nil else {
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

    private func downloadImage(url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw ImageLoadError.downloadFailure
        }
        return image
    }
}
