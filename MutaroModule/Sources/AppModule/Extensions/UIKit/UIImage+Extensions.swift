//
//  UIImage+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import ImageIO
import UIKit

extension UIImage {
    func downsample(imageAt imageURL: URL, to pointSize: CGSize) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * CGFloat.deviceScale
        let downsampleOptions =
            [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels,
            ] as CFDictionary

        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(
            imageSource, 0, downsampleOptions)!
        return UIImage(cgImage: downsampledImage)
    }
}
