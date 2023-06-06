//
//  MyAppToolsComponent.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Core
import Foundation
import NeedleFoundation
import UIKit

public protocol MyAppToolsFeatureDependency: Dependency {
    var client: Providable { get }
}

class MyAppToolsFeatureBuilder: Builder<MyAppToolsFeatureDependency>, MyAppToolsFeatureBuildable {
    @MainActor
    func build() -> UIViewController {
        let myAppTools = MyAppToolsViewController(
            dependency: .init(
                viewModel: .init(
                    environment: environment
                )
            )
        )
        return myAppTools
    }

    private var environment: MyAppToolsFeatureEnvironment {
        .init(
            router: router
        )
    }

    private var router: MyAppToolsRoutable {
        MyAppToolsRouter(
            dependency: .init()
        )
    }
}

public class MyAppToolsFeatureComponent: Component<MyAppToolsFeatureDependency>, FeatureMyAppTools {
    public func myAppToolsFeatureBuilder() -> MyAppToolsFeatureBuildable {
        MyAppToolsFeatureBuilder(dependency: dependency)
    }
}
