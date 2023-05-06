//
//  MyAppsFeatureComponent.swift
//  MutaroApp
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import Foundation
import NeedleFoundation
import UIKit

public protocol MyAppsFeatureDependency: Dependency {
    // TODO: - var 遷移するB FeatureのBuilder: BModuleBuildable { get }
}

class MyAppsFeatureBuilder: Builder<MyAppsFeatureDependency>, MyAppsFeatureBuildable {
    @MainActor
    public func build() -> UIViewController {
        let myAppsVC = MyAppsViewController(
            dependency: .init(
                viewModel: .init()
            )
        )
        let navigationVC = UINavigationController(rootViewController: myAppsVC)
        navigationVC.setLargeTitle()
        let imageName = "app"
        let normalTabColor = R.color.navy() ?? .gray
        let normalTabImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: normalTabColor)
        let normalTabImage = UIImage(systemName: imageName, withConfiguration: normalTabImageConfiguration)
        let selectedTabColor = R.color.turquoise() ?? .orange
        let selectedTabImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: selectedTabColor)
        let selectedTabImage = UIImage(systemName: imageName, withConfiguration: selectedTabImageConfiguration)

        navigationVC.tabBarItem = .init(
            title: "MyApps",
            image: normalTabImage,
            selectedImage: selectedTabImage
        )
        return navigationVC
    }
}

public class MyAppsFeatureBuilderComponent: Component<MyAppsFeatureDependency>, FeatureMyApps {
    public func myAppsFeatureBuilder() -> Core.MyAppsFeatureBuildable {
        MyAppsFeatureBuilder(dependency: dependency)
    }
}
