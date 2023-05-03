//
//  UINavigationController+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/14.
//

import UIKit

public extension UINavigationController {
    func setLargeTitle() {
        navigationItem.largeTitleDisplayMode = .automatic
        navigationBar.prefersLargeTitles = true
    }
}
