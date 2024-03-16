//
//  MyAppToolsFeatureComponent.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Core
import Foundation
import NeedleFoundation
import UIKit

public protocol MyAppToolsFeatureDependency: Dependency, Sendable {
    var client: any Providable { get }
    var keychainDataStore: any KeychainDataStoreProtocol { get }
}

public class MyAppToolsFeatureBuilder: Builder<MyAppToolsFeatureDependency>, MyAppToolsFeatureBuildable {
    @MainActor
    public func build(appId: String) -> UIViewController {
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
            router: router,
            keychainDataStore: dependency.keychainDataStore
        )
    }

    private var router: any MyAppToolsRoutable {
        MyAppToolsRouter(
            dependency: .init()
        )
    }

    private var ciProductUseCase: any CIProductUseCase {
        CIProductUseCaseImp(client: dependency.client)
    }
}

public class MyAppToolsFeatureComponent: Component<MyAppToolsFeatureDependency>, FeatureMyAppTools {
    public func myAppToolsFeatureBuilder() -> any MyAppToolsFeatureBuildable {
        MyAppToolsFeatureBuilder(dependency: dependency)
    }
}
