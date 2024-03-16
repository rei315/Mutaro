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

@MainActor
public protocol HomeFeatureDependency: Dependency {
    // TODO: - var 遷移するB FeatureのBuilder: BModuleBuildable { get }
}

@MainActor
public class HomeFeatureBuilder: Builder<HomeFeatureDependency>, HomeFeatureBuildable {
    public func build(viewControllers: [UIViewController]) -> UIViewController {
        HomeTabViewController(viewControllers: viewControllers)
    }
}

public class HomeFeatureBuilderComponent: Component<HomeFeatureDependency>, FeatureHomeView {
    public func homeFeatureBuilder() -> any Core.HomeFeatureBuildable {
        HomeFeatureBuilder(dependency: dependency)
    }
}
