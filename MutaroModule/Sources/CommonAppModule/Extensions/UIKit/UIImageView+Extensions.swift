//
//  UIImageView+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import ImageModule
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
    public func clipToCircle() {
        layer.masksToBounds = false
        let radius: CGFloat = min(frame.width, frame.height) / 2.0
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
