//
//  HomeFeatureComponent.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import Foundation
import NeedleFoundation
import UIKit
import HomeViewFeature

public protocol HomeFeatureDependency: Dependency {
    // TODO: - var 遷移するB FeatureのBuilder: BModuleBuildable { get }
}

class HomeFeatureBuilder: Builder<HomeFeatureDependency>, HomeViewFeatureBuildable {
    @MainActor
    public func build(viewControllers: [UIViewController]) -> UIViewController {
        HomeTabViewController(viewControllers: viewControllers)
    }
}

public class HomeFeatureBuilderComponent: Component<HomeFeatureDependency>, FeatureHomeView {
    public func homeViewFeatureBuilder() -> Core.HomeViewFeatureBuildable {
        HomeFeatureBuilder(dependency: dependency)
    }
}
