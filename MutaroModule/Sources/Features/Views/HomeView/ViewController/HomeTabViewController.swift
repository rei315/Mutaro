//
//  HomeCoordinator.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit
import AppResource

final public class HomeTabViewController: UITabBarController {
    
    public init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.lets {
            let itemAppearance = UITabBarItemAppearance().apply {
                $0.normal.iconColor = .brown
                $0.normal.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: Resources.Colors.navy.color
                ]
                $0.selected.iconColor = Resources.Colors.black.color
                $0.selected.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: Resources.Colors.black.color
                ]
            }
            let barAppearance = UITabBarAppearance().apply {
                $0.configureWithOpaqueBackground()
                $0.backgroundColor = Resources.Colors.white.color
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

enum HomeTabPage: Int {
    case mutaroList
    case setting

    var title: String {
        switch self {
        case .mutaroList:
            return "mutaro"
        case .setting:
            return "setting"
        }
    }
    
    var iconName: String {
        switch self {
        case .mutaroList:
            return "text.below.photo"
        case .setting:
            return "gear"
        }
    }
    
    var normalTabIconConfiguration: UIImage.SymbolConfiguration {
        let normalTabImageColor = Resources.Colors.navy.color
        return UIImage.SymbolConfiguration(hierarchicalColor: normalTabImageColor)
    }
    
    var selectedTabIconConfiguration: UIImage.SymbolConfiguration {
        let normalTabImageColor = Resources.Colors.turquoise.color
        return UIImage.SymbolConfiguration(hierarchicalColor: normalTabImageColor)
    }
    
    var item: UITabBarItem {
        return .init(
            title: self.title,
            image: UIImage(
                systemName: self.iconName,
                withConfiguration: self.normalTabIconConfiguration
            ),
            selectedImage: UIImage(
                systemName: self.iconName,
                withConfiguration: self.selectedTabIconConfiguration
            )
        )
    }
}
