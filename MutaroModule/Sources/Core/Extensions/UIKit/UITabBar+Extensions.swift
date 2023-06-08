//
//  UITabBar+Extensions.swift
//
//
//  Created by minguk-kim on 2023/06/08.
//

import UIKit

public extension UITabBar {
    static func setGlobalStyle() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
    }
}
