//
//  UINavigationBar+Extension.swift
//
//
//  Created by minguk-kim on 2023/06/08.
//

import UIKit

public extension UINavigationBar {
    static func setGlobalStyle() {
        let appearance = UINavigationBarAppearance().apply {
            $0.largeTitleTextAttributes = [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 32)
            ]
            $0.backgroundColor = .white
            $0.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        }

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().clipsToBounds = true
    }
}
