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
    public func loadImage(with fileName: String, size: CGSize) async {
        image = await ImageCacheManager.shared.loadImage(for: fileName, size: size)
    }

    public func clipToCircle() {
        layer.masksToBounds = false
        let radius: CGFloat = min(frame.width, frame.height) / 2.0
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
