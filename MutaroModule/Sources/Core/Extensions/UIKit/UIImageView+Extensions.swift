//
//  UIImageView+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import UIKit

public extension UIImageView {
    func clipToCircle(with radius: CGFloat? = nil) {
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
