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
    public static func loadImage(fileName: String, size: CGSize) async -> UIImage? {
        await ImageLoadManager.shared.loadImage(for: fileName, size: size)
    }

    @discardableResult
    public static func loadImage(urlString: String, size: CGSize) async -> UIImage? {
        await ImageLoadManager.shared.downloadImage(with: urlString, size: size)
    }
}
