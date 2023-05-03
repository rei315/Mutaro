//
//  UIImage.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import ImageIO
import UIKit

public extension UIImage {
    func downsample(imageAt imageURL: URL, to pointSize: CGSize) -> UIImage? {
        guard pointSize != .zero else {
            return self
        }

        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard
            let imageSource = CGImageSourceCreateWithURL(
                imageURL as CFURL,
                imageSourceOptions
            )
        else {
            return self
        }
        let maxDimensionInPixels =
            max(
                pointSize.width,
                pointSize.height
            ) * UIScreen.main.scale
        let downsampleOptions =
            [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
            ] as CFDictionary

        guard
            let downsampledImage = CGImageSourceCreateThumbnailAtIndex(
                imageSource,
                0,
                downsampleOptions
            )
        else {
            return self
        }
        return UIImage(cgImage: downsampledImage)
    }
}
