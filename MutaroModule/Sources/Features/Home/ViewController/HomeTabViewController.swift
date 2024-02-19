//
//  HomeTabViewController.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

public final class HomeTabViewController: UITabBarController {
    public init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.lets {
            let itemAppearance = UITabBarItemAppearance().apply {
                $0.normal.iconColor = .brown
                $0.normal.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor(resource: .navy)
                ]
                $0.selected.iconColor = UIColor(resource: .black)
                $0.selected.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor(resource: .black)
                ]
            }
            let barAppearance = UITabBarAppearance().apply {
                $0.configureWithOpaqueBackground()
                $0.backgroundColor = UIColor(resource: .white)
                $0.inlineLayoutAppearance = itemAppearance
                $0.stackedLayoutAppearance = itemAppearance
                $0.compactInlineLayoutAppearance = itemAppearance
            }
            $0.standardAppearance = barAppearance
            $0.tintAdjustmentMode = .normal
            $0.scrollEdgeAppearance = barAppearance
            $0.isTranslucent = false
        }
    }
}
