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

    private var ongoingTask: [String: Task<UIImage?, Never>] = [:]

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
        ongoingTask.updateValue(task, forKey: fileName)

        let result = await task.result

        do {
            ongoingTask.removeValue(forKey: fileName)
            guard !Task.isCancelled else {
                return nil
            }
            return try result.get()
        } catch {
            return nil
        }
    }

    public func cancelLoad(key: String) {
        let task = ongoingTask.first { $0.key == key }?.value
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
