//
//  UIImage+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import ImageModule
import UIKit

extension UIImage {
    @discardableResult
    static func loadImage(with fileName: String, size: CGSize) async -> UIImage? {
        await ImageCacheManager.shared.loadImage(for: fileName, size: size)
    }

    @discardableResult
    static func loadImage(with fileType: ImageContentPathProvider.ContentFileType, size: CGSize)
        async -> UIImage?
    {
        await ImageCacheManager.shared.loadImage(for: fileType, size: size)
    }
}
