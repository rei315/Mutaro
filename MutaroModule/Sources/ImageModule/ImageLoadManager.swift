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

    public func downloadImage(with urlString: String, size: CGSize) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            return nil
        }

        if let cachedImage = await ImageCacheManager.shared.getCachedImage(fileUrl: url) {
            return cachedImage.downsample(imageAt: url, to: size)
        }

        do {
            guard let image = try await downloadImage(url: url) else {
                return nil
            }
            await ImageCacheManager.shared.insertImage(image, for: url)
            return image.downsample(imageAt: url, to: size)
        } catch {
            return nil
        }
    }

    public func loadImage(for fileName: String, size: CGSize) async -> UIImage? {
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

    public func loadImage(for fileType: ContentFileType, size: CGSize)
        async -> UIImage?
    {
        guard let fileUrl = ImageContentPathProvider.url(type: fileType) else {
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
