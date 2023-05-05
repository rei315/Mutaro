//
//  ImageProcessGenerator.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import Foundation
import Kingfisher

public enum ImageProcessGenerator {
    public static func createDownsample(size: CGSize) -> ImageProcessor {
        DownsamplingImageProcessor(size: size)
    }
}
