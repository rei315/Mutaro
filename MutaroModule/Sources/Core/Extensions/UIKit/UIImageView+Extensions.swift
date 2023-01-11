//
//  UIImageView+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import ImageLoader
import UIKit

@MainActor
extension UIImageView {
    public func loadImage(fileName: String, size: CGSize) async {
        image = await ImageLoadManager.shared.loadImage(for: fileName, size: size)
    }

    public func loadImage(urlString: String, size: CGSize) async {
        image = await ImageLoadManager.shared.downloadImage(with: urlString, size: size)
    }
}

@MainActor
extension UIImageView {
    public func clipToCircle(with radius: CGFloat? = nil) {
        layer.masksToBounds = false
        let settingRadius: CGFloat
        if let radius {
            settingRadius = radius
        } else {
            settingRadius = min(frame.width, frame.height) / 2.0
        }
        layer.cornerRadius = settingRadius
        clipsToBounds = true
    }
}
