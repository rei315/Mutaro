//
//  UINavigationController+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/14.
//

import UIKit

extension UINavigationController {
    public func setLargeTitle() {
        navigationItem.largeTitleDisplayMode = .always
        navigationBar.prefersLargeTitles = true
    }
}
