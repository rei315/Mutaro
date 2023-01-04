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
    public static func loadImage(with fileName: String, size: CGSize) async -> UIImage? {
        await ImageCacheManager.shared.loadImage(for: fileName, size: size)
    }
}
