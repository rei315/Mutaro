//
//  UIImage.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import ImageIO
import UIKit

extension UIImage {
    public func downsample(imageAt imageURL: URL, to pointSize: CGSize) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard
            let imageSource = CGImageSourceCreateWithURL(
                imageURL as CFURL,
                imageSourceOptions
            )
        else {
            return nil
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
                kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels,
            ] as CFDictionary

        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(
            imageSource,
            0,
            downsampleOptions
        )!
        return UIImage(cgImage: downsampledImage)
    }
}
