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
import MyAppsFeature

public protocol MyAppsFeatureDependency: Dependency {
    // TODO: - var 遷移するB FeatureのBuilder: BModuleBuildable { get }
}

class MyAppsFeatureBuilder: Builder<MyAppsFeatureDependency>, MyAppsFeatureBuildable {
    @MainActor
    public func build() -> UIViewController {
        MyAppsViewController(
            dependency: .init(
                viewModel: .init()
            )
        )
    }
}

public class MyAppsFeatureBuilderComponent: Component<MyAppsFeatureDependency>, FeatureMyApps {
    public func myAppsFeatureBuilder() -> Core.MyAppsFeatureBuildable {
        MyAppsFeatureBuilder(dependency: dependency)
    }
}
