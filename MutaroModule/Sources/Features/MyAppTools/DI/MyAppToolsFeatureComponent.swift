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
    func build(appId: String) -> UIViewController {
        let myAppTools = MyAppToolsViewController(
            dependency: .init(
                viewModel: .init(
                    appId: appId,
                    environment: environment
                )
            )
        )
        return myAppTools
    }

    private var environment: MyAppToolsFeatureEnvironment {
        .init(
            ciProductUseCase: ciProductUseCase,
            router: router
        )
    }

    private var router: MyAppToolsRoutable {
        MyAppToolsRouter(
            dependency: .init()
        )
    }

    private var ciProductUseCase: CIProductUseCase {
        CIProductUseCaseImp(client: dependency.client)
    }
}

public class MyAppToolsFeatureComponent: Component<MyAppToolsFeatureDependency>, FeatureMyAppTools {
    public func myAppToolsFeatureBuilder() -> MyAppToolsFeatureBuildable {
        MyAppToolsFeatureBuilder(dependency: dependency)
    }
}
