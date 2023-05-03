//
//  UIView+Extensions.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

public extension UIView {
    func fillConstraint(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    static func createSpacer(axis: NSLayoutConstraint.Axis) -> UIView {
        UIView().apply {
            $0.isUserInteractionEnabled = false
            $0.setContentHuggingPriority(.fittingSizeLevel, for: axis)
            $0.setContentCompressionResistancePriority(.fittingSizeLevel, for: axis)
        }
    }

    static func createSpacer(axis: NSLayoutConstraint.Axis, padding: CGFloat) -> UIView {
        UIView().apply {
            $0.translatesAutoresizingMaskIntoConstraints = false
            if axis == .vertical {
                NSLayoutConstraint.activate([
                    $0.heightAnchor.constraint(equalToConstant: padding)
                ])
            } else {
                NSLayoutConstraint.activate([
                    $0.widthAnchor.constraint(equalToConstant: padding)
                ])
            }
        }
    }
}
